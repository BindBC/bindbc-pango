/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.glyph;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.break_;
import pango.item;
import pango.types;

alias PangoGlyphUnit = int;

struct PangoGlyphGeometry{
	PangoGlyphUnit width;
	PangoGlyphUnit xOffset;
	PangoGlyphUnit yOffset;
	alias x_offset = xOffset;
	alias y_offset = yOffset;
}

struct PangoGlyphVisAttr{
	import std.bitmanip: bitfields;
	mixin(bitfields!(
		uint, q{isClusterStart},  1,
		uint, q{isColour},        1,
		uint, q{reserved},        6,
	));
	alias is_cluster_start = isClusterStart;
	alias is_colour = isColour;
	alias is_color = isColour;
	alias isColor = isColour;
}

struct PangoGlyphInfo{
	PangoGlyph glyph;
	PangoGlyphGeometry geometry;
	PangoGlyphVisAttr attr;
}

struct PangoGlyphString{
	int numGlyphs;
	alias num_glyphs = numGlyphs;
	
	PangoGlyphInfo* glyphs;
	int* logClusters;
	alias log_clusters = logClusters;
	
	int space;
}


static if(pangoVersion >= Version(1,44,0))
mixin(makeEnumBind(q{PangoShapeFlags}, aliases: [q{PangoShape}], members: (){
	EnumMember[] ret = [
		{{q{none},            q{PANGO_SHAPE_NONE}},             q{0}},
		{{q{roundPositions},  q{PANGO_SHAPE_ROUND_POSITIONS}},  q{1 << 0}},
	];
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_glyph_string_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_GLYPH_STRING}]},
		{q{PangoGlyphString*}, q{pango_glyph_string_new}, q{}},
		{q{void}, q{pango_glyph_string_set_size}, q{PangoGlyphString* string, int newLen}},
		{q{PangoGlyphString*}, q{pango_glyph_string_copy}, q{PangoGlyphString* string}},
		{q{void}, q{pango_glyph_string_free}, q{PangoGlyphString* string}},
		{q{void}, q{pango_glyph_string_extents}, q{PangoGlyphString* glyphs, PangoFont* font, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
		{q{void}, q{pango_glyph_string_extents_range}, q{PangoGlyphString* glyphs, int start, int end, PangoFont* font, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
		{q{void}, q{pango_glyph_string_get_logical_widths}, q{PangoGlyphString* glyphs, const(char)* text, int length, int embeddingLevel, int* logicalWidths}},
		{q{void}, q{pango_glyph_string_index_to_x}, q{PangoGlyphString* glyphs, const(char)* text, int length, PangoAnalysis* analysis, int index, gboolean trailing, int* xPos}},
		{q{void}, q{pango_glyph_string_x_to_index}, q{PangoGlyphString* glyphs, const(char)* text, int length, PangoAnalysis* analysis, int xPos, int* index, int* trailing}},
		{q{void}, q{pango_shape}, q{const(char)* text, int length, const(PangoAnalysis)* analysis, PangoGlyphString* glyphs}},
	];
	if(pangoVersion >= Version(1,14,0)){
		FnBind[] add = [
			{q{int}, q{pango_glyph_string_get_width}, q{PangoGlyphString* glyphs}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,32,0)){
		FnBind[] add = [
			{q{void}, q{pango_shape_full}, q{const(char)* itemText, int itemLength, const(char)* paragraphText, int paragraphLength, const(PangoAnalysis)* analysis, PangoGlyphString* glyphs}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{void}, q{pango_shape_with_flags}, q{const(char)* itemText, int itemLength, const(char)* paragraphText, int paragraphLength, const(PangoAnalysis)* analysis, PangoGlyphString* glyphs, PangoShapeFlags flags}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,50,0)){
		FnBind[] add = [
			{q{void}, q{pango_glyph_string_index_to_x_full}, q{PangoGlyphString* glyphs, const(char)* text, int length, PangoAnalysis* analysis, PangoLogAttr* attrs, int index, gboolean trailing, int* xPos}},
			{q{void}, q{pango_shape_item}, q{PangoItem* item, const(char)* paragraphText, int paragraphLength, PangoLogAttr* logAttrs, PangoGlyphString* glyphs, PangoShapeFlags flags}},
		];
		ret ~= add;
	}
	return ret;
}()));
