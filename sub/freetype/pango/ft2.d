/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.ft2;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.fc.fontmap;
import pango.fc.font;
import pango.fontmap;
import pango.glyph;
import pango.layout;
import pango.matrix;
import pango.types;

import bindbc.fontconfig;
import bindbc.freetype;

struct PangoFT2FontMap;

alias PangoFT2SubstituteFunc = extern(C) void function(FcPattern* pattern, void* data) nothrow;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{pango_ft2_render}, q{FT_Bitmap* bitmap, PangoFont* font, PangoGlyphString* glyphs, int x, int y}},
		{q{void}, q{pango_ft2_render_layout_line}, q{FT_Bitmap* bitmap, PangoLayoutLine* line, int x, int y}},
		{q{void}, q{pango_ft2_render_layout}, q{FT_Bitmap* bitmap, PangoLayout* layout, int x, int y}},
		{q{GType}, q{pango_ft2_font_map_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_FT2_TYPE_FONT_MAP}]},
	];
	if(pangoVersion >= Version(1,2,0)){
		FnBind[] add = [
			{q{PangoFontMap*}, q{pango_ft2_font_map_new}, q{}},
			{q{void}, q{pango_ft2_font_map_set_resolution}, q{PangoFT2FontMap* fontMap, double dpiX, double dpiY}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{void}, q{pango_ft2_render_transformed}, q{FT_Bitmap* bitmap, const PangoMatrix* matrix, PangoFont* font, PangoGlyphString* glyphs, int x, int y}},
			{q{void}, q{pango_ft2_render_layout_line_subpixel}, q{FT_Bitmap* bitmap, PangoLayoutLine* line, int x, int y}},
			{q{void}, q{pango_ft2_render_layout_subpixel}, q{FT_Bitmap* bitmap, PangoLayout* layout, int x, int y}},
		];
		ret ~= add;
	}
	return ret;
}()));

static if(!bindbc.pango.config.staticBinding):
import bindbc.loader;

mixin(makeDynloadFns("PangoFreeType", makeLibPaths(["pangoft2-1.0"]), [__MODULE__]));
