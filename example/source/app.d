
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
	
	string txtMarkup = "hello";
	char* txtz;
	PangoAttrList* attrs;
	if(!pango_parse_markup(
		&txtMarkup[0], cast(int)txtMarkup.length,
		cast(dchar)0, &attrs, &txtz,
		null, null,
	))
		printf("Markup error\n");
	char[] txt = fromStringz(txtz);
	
	//itemisation
	GList* anaList = pango_itemise(
		pangoCtx,
		&txt[0], 0, cast(int)txt.length,
		attrs, null,
	);
	pango_attr_list_unref(attrs);
	
	//shaping
	PangoGlyphString* glyphs = pango_glyph_string_new();
	auto l = anaList;
	while(true){
		auto item = cast(PangoItem*)l.data;
		pango_shape(&txt[item.offset], item.length, &item.analysis, glyphs);
		if(!l.next) break;
		l = l.next;
	}
	g_list_free_full(anaList, cast(GDestroyNotify)&pango_item_free);
	g_free(&txt[0]);
	
	//load font
	PangoFontDescription* desc = pango_font_description_new();
	pango_font_description_set_absolute_size(desc, pangoScale * 24.0);
	PangoFont* font = pango_font_map_load_font(fontMap, pangoCtx, desc);
	pango_font_description_free(desc);
	
	auto newDesc = pango_font_describe(font);
	printf("Font: %s\n", pango_font_description_to_string(newDesc));
	pango_font_description_free(newDesc);
	
	FT_Bitmap ftBmp;
	FT_Bitmap_Init(&ftBmp);
	ftBmp.pitch = 128;
	ftBmp.width = 128;
	ftBmp.rows  = 48;
	ftBmp.pixelMode = FT_Pixel_Mode.grey;
	ftBmp.numGreys = 256;
	ftBmp.buffer = cast(ubyte*)calloc(ftBmp.rows * ftBmp.width, 1);
	
	pango_ft2_render(&ftBmp, font, glyphs, 0,24);
	
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
	
	g_object_unref(cast(GObject*)font);
	pango_glyph_string_free(glyphs);
	g_object_unref(cast(GObject*)pangoCtx);
	g_object_unref(cast(GObject*)fontMap);
	
	FT_Done_FreeType(ftLib);
	
	return 0;
}

