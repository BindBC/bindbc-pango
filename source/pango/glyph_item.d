/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.glyph_item;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.attributes;
import pango.break_;
import pango.glyph;
import pango.item;

struct PangoGlyphItem{
	PangoItem* item;
	PangoGlyphString* glyphs;
	int yOffset;
	int startXOffset;
	int endXOffset;
	alias y_offset = yOffset;
	alias start_x_offset = startXOffset;
	alias end_x_offset = endXOffset;
}

static if(pangoVersion >= Version(1,22,0))
struct PangoGlyphItemIter{
	PangoGlyphItem* glyphItem;
	alias glyph_item = glyphItem;
	const(char)* text;
	
	int startGlyph;
	int startIndex;
	int startChar;
	alias start_glyph = startGlyph;
	alias start_index = startIndex;
	alias start_char = startChar;
	
	int endGlyph;
	int endIndex;
	int endChar;
	alias end_glyph = endGlyph;
	alias end_index = endIndex;
	alias end_char = endChar;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GType}, q{pango_glyph_item_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_GLYPH_ITEM}]},
	];
	if(pangoVersion >= Version(1,2,0)){
		FnBind[] add = [
			{q{PangoGlyphItem*}, q{pango_glyph_item_split}, q{PangoGlyphItem* orig, const(char)* text, int splitIndex}},
			{q{GSList*}, q{pango_glyph_item_apply_attrs}, q{PangoGlyphItem* glyphItem, const(char)* text, PangoAttrList* list}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{void}, q{pango_glyph_item_free}, q{PangoGlyphItem* glyphItem}},
			{q{void}, q{pango_glyph_item_letter_space}, q{PangoGlyphItem* glyphItem, const(char)* text, PangoLogAttr* logAttrs, int letterSpacing}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,20,0)){
		FnBind[] add = [
			{q{PangoGlyphItem*}, q{pango_glyph_item_copy}, q{PangoGlyphItem* orig}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,22,0)){
		FnBind[] add = [
			{q{GType}, q{pango_glyph_item_iter_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_GLYPH_ITEM_ITER}]},
			{q{PangoGlyphItemIter*}, q{pango_glyph_item_iter_copy}, q{PangoGlyphItemIter* orig}},
			{q{void}, q{pango_glyph_item_iter_free}, q{PangoGlyphItemIter* iter}},
			{q{gboolean}, q{pango_glyph_item_iter_init_start}, q{PangoGlyphItemIter* iter, PangoGlyphItem* glyphItem, const(char)* text}},
			{q{gboolean}, q{pango_glyph_item_iter_init_end}, q{PangoGlyphItemIter* iter, PangoGlyphItem* glyphItem, const(char)* text}},
			{q{gboolean}, q{pango_glyph_item_iter_next_cluster}, q{PangoGlyphItemIter* iter}},
			{q{gboolean}, q{pango_glyph_item_iter_prev_cluster}, q{PangoGlyphItemIter* iter}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,26,0)){
		FnBind[] add = [
			{q{void}, q{pango_glyph_item_get_logical_widths}, q{PangoGlyphItem* glyphItem, const(char)* text, int* logicalWidths}},
		];
		ret ~= add;
	}
	return ret;
}()));
