
import core.stdc.stdlib;
import core.stdc.stdio;
import core.stdc.string;

import bindbc.freetype;
import bindbc.fontconfig;
import bindbc.fontconfig.freetype;
import bindbc.pango;
import bindbc.pango.fontconfig;
import bindbc.pango.freetype;

import gamut;

inout(char)[] fromStringz(return scope inout(char)* cStr) @nogc pure nothrow =>
	cStr ? cStr[0..strlen(cStr)] : null;

extern(C) int main(){
	static if(!bindbc.pango.config.staticBinding){
		import bindbc.loader;
		if(loadFreeType() != ftSupport){
			foreach(err; errors){
				printf("[loadFreeType] %s: %s\n", err.error, err.message);
			}
			return 1;
		}
		static foreach(loadFn; [
			q{loadFontconfig},
			q{loadFontconfigFreeType},
			q{loadPango},
			q{loadPangoFontconfig},
			q{loadPangoFreeType},
		]){
mixin(`
resetErrors();
if(`~loadFn~`() != LoadMsg.success){
	import core.stdc.stdio: printf;
	foreach(err; errors){
		printf("[`~loadFn~`] %s: %s\n", err.error, err.message);
	}
	return 1;
}`);
		}
	}
	
	FT_Library ftLib;
	if(FT_Error err = FT_Init_FreeType(&ftLib))
		printf("Loading error: %s\n", FT_Error_String(err));
	
	Version ftLoaded;
	FT_Library_Version(ftLib, &ftLoaded.major, &ftLoaded.minor, &ftLoaded.patch);
	assert(ftLoaded >= ftSupport);
	
	PangoFontMap* fontMap = pango_ft2_font_map_new();
	PangoContext* pangoCtx = pango_font_map_create_context(fontMap);
	
	string txtMarkup =
"I can eat glass and it doesn't hurt me.
ฉันกินกระจกได้ แต่มันไม่ทำให้ฉันเจ็บ
काचं शक्नोम्यत्तुम् । नोपहिनस्ति माम् ॥
私はガラスを食べられます。それは私を傷つけません。
我能吞下玻璃而不傷身體。
Я можу їсти скло, і воно мені не зашкодить.
میں کانچ کھا سکتا ہوں اور مجھے تکلیف نہیں ہوتی ۔
אני יכול לאכול זכוכית וזה לא מזיק לי.
Samples from: https://kermitproject.org/utf8.html";
	
	//load font
	PangoFontDescription* desc = pango_font_description_new();
	pango_font_description_set_absolute_size(desc, pangoScale * 24.0);
	pango_context_set_font_description(pangoCtx, desc);
	printf("Font: %s\n", pango_font_description_to_string(desc));
	//PangoFont* font = pango_font_map_load_font(fontMap, pangoCtx, desc);
	
	//layout
	PangoLayout* layout = pango_layout_new(pangoCtx);
	pango_layout_set_markup(layout, &txtMarkup[0], cast(int)txtMarkup.length);
	
	int txtWidth, txtHeight;
	pango_layout_get_size(layout, &txtWidth, &txtHeight);
	txtWidth /= pangoScale;
	txtHeight /= pangoScale;
	
	FT_Bitmap ftBmp;
	FT_Bitmap_Init(&ftBmp);
	ftBmp.pitch = (txtWidth+16+8) & ~4;
	ftBmp.width = txtWidth+16;
	ftBmp.rows  = txtHeight+16;
	ftBmp.pixelMode = FT_Pixel_Mode.grey;
	ftBmp.numGreys = 256;
	ftBmp.buffer = cast(ubyte*)calloc(ftBmp.rows * ftBmp.width, 1);
	
	pango_ft2_render_layout(&ftBmp, layout, 8,8);
	
	auto image = Image(ftBmp.width, ftBmp.rows, PixelType.l8);
	size_t buffOff = 0;
	foreach(y; 0..image.height()){
		auto scan = cast(ubyte[])image.scanline(y);
		auto buffOffY = buffOff;
		foreach(ref pixel; scan[0..image.width()]){
			pixel = ftBmp.buffer[buffOff++];
		}
		buffOff = buffOffY + ftBmp.pitch;
	}
	if(!image.saveToFile("output.png"))
		printf("Writing output.png failed\n");
	FT_Bitmap_Done(ftLib, &ftBmp);
	
	pango_font_description_free(desc);
	g_object_unref(cast(GObject*)pangoCtx);
	g_object_unref(cast(GObject*)fontMap);
	
	FT_Done_FreeType(ftLib);
	
	return 0;
}

