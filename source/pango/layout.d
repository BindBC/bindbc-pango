/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.layout;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.attributes;
import pango.break_;
import pango.context;
import pango.direction;
import pango.font;
import pango.glyph_item;
import pango.tabs;
import pango.types;

struct PangoLayout;

struct PangoLayoutClass;

alias PangoLayoutRun = PangoGlyphItem;

mixin(makeEnumBind(q{PangoAlignment}, aliases: [q{PangoAlign}], members: (){
	EnumMember[] ret = [
		{{q{left},    q{PANGO_ALIGN_LEFT}}},
		{{q{centre},  q{PANGO_ALIGN_CENTRE}}, aliases: [{q{center}, q{PANGO_ALIGN_CENTER}}]},
		{{q{right},   q{PANGO_ALIGN_RIGHT}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{PangoWrapMode}, aliases: [q{PangoWrap}], members: (){
	EnumMember[] ret = [
		{{q{word},      q{PANGO_WRAP_WORD}}},
		{{q{char_},     q{PANGO_WRAP_CHAR}}},
		{{q{wordChar},  q{PANGO_WRAP_WORD_CHAR}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{PangoEllipsiseMode}, aliases: [q{PangoEllipsizeMode}, q{PangoEllipsise}, q{PangoEllipsize}], members: (){
	EnumMember[] ret = [
		{{q{none},    q{PANGO_ELLIPSISE_NONE}}, aliases: [{c: q{PANGO_ELLIPSIZE_NONE}}]},
		{{q{start},   q{PANGO_ELLIPSISE_START}}, aliases: [{c: q{PANGO_ELLIPSIZE_START}}]},
		{{q{middle},  q{PANGO_ELLIPSISE_MIDDLE}}, aliases: [{c: q{PANGO_ELLIPSIZE_MIDDLE}}]},
		{{q{end},     q{PANGO_ELLIPSISE_END}}, aliases: [{c: q{PANGO_ELLIPSIZE_END}}]},
	];
	return ret;
}()));

struct PangoLayoutLine{
	PangoLayout* layout;
	int startIndex;
	alias start_index = startIndex;
	int length;
	GSList* runs;
	
	import std.bitmanip: bitfields;
	mixin(bitfields!(
		uint, q{isParagraphStart},  1,
		uint, q{resolvedDir},       3,
		uint, q{reserved},          4,
	));
	alias is_paragraph_start = isParagraphStart;
	alias resolved_dir = resolvedDir;
}

static if(pangoVersion >= Version(1,50,0)){
	mixin(makeEnumBind(q{PangoLayoutSerialiseFlags}, aliases: [q{PangoLayoutSerializeFlags}, q{PangoLayoutSerialise}, q{PangoLayoutSerialize}], members: (){
		EnumMember[] ret = [
			{{q{default_},  q{PANGO_LAYOUT_SERIALISE_DEFAULT}},  q{0}, aliases: [{c: q{PANGO_LAYOUT_SERIALIZE_DEFAULT}}]},
			{{q{context},   q{PANGO_LAYOUT_SERIALISE_CONTEXT}},  q{1 << 0}, aliases: [{c: q{PANGO_LAYOUT_SERIALIZE_CONTEXT}}]},
			{{q{output},    q{PANGO_LAYOUT_SERIALISE_OUTPUT}},   q{1 << 1}, aliases: [{c: q{PANGO_LAYOUT_SERIALIZE_OUTPUT}}]},
		];
		return ret;
	}()));
	mixin(makeEnumBind(q{PangoLayoutDeserialiseError}, aliases: [q{PangoLayoutDeserializeError}], members: (){
		EnumMember[] ret = [
			{{q{invalid},       q{PANGO_LAYOUT_DESERIALISE_INVALID}}, aliases: [{c: q{PANGO_LAYOUT_DESERIALIZE_INVALID}}]},
			{{q{invalidValue},  q{PANGO_LAYOUT_DESERIALISE_INVALID_VALUE}}, aliases: [{c: q{PANGO_LAYOUT_DESERIALIZE_INVALID_VALUE}}]},
			{{q{missingValue},  q{PANGO_LAYOUT_DESERIALISE_MISSING_VALUE}}, aliases: [{c: q{PANGO_LAYOUT_DESERIALIZE_MISSING_VALUE}}]},
		];
		return ret;
	}()));
	mixin(makeEnumBind(q{PangoLayoutDeserialiseFlags}, aliases: [q{PangoLayoutDeserializeFlags}, q{PangoLayoutDeserialise}, q{PangoLayoutDeserialize}], members: (){
		EnumMember[] ret = [
			{{q{default_},  q{PANGO_LAYOUT_DESERIALISE_DEFAULT}}, q{0}, aliases: [{c: q{PANGO_LAYOUT_DESERIALIZE_DEFAULT}}]},
			{{q{context},   q{PANGO_LAYOUT_DESERIALISE_CONTEXT}}, q{1 << 0}, aliases: [{c: q{PANGO_LAYOUT_DESERIALIZE_CONTEXT}}]},
		];
		return ret;
	}()));
}

struct PangoLayoutIter;

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GType}, q{pango_layout_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_LAYOUT}]},
			{q{PangoLayout*}, q{pango_layout_new}, q{PangoContext* context}},
			{q{PangoLayout*}, q{pango_layout_copy}, q{PangoLayout* src}},
			{q{PangoContext*}, q{pango_layout_get_context}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_attributes}, q{PangoLayout* layout, PangoAttrList* attrs}},
			{q{PangoAttrList*}, q{pango_layout_get_attributes}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_text}, q{PangoLayout* layout, const(char)* text, int length}},
			{q{const(char)*}, q{pango_layout_get_text}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_markup}, q{PangoLayout* layout, const(char)* markup, int length}},
			{q{void}, q{pango_layout_set_markup_with_accel}, q{PangoLayout* layout, const(char)* markup, int length, dchar accelMarker, dchar* accelChar}},
			{q{void}, q{pango_layout_set_font_description}, q{PangoLayout* layout, const(PangoFontDescription)* desc}},
			{q{void}, q{pango_layout_set_width}, q{PangoLayout* layout, int width}},
			{q{int}, q{pango_layout_get_width}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_wrap}, q{PangoLayout* layout, PangoWrapMode wrap}},
			{q{PangoWrapMode}, q{pango_layout_get_wrap}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_indent}, q{PangoLayout* layout, int indent}},
			{q{int}, q{pango_layout_get_indent}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_spacing}, q{PangoLayout* layout, int spacing}},
			{q{int}, q{pango_layout_get_spacing}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_justify}, q{PangoLayout* layout, gboolean justify}},
			{q{gboolean}, q{pango_layout_get_justify}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_alignment}, q{PangoLayout* layout, PangoAlignment alignment}},
			{q{PangoAlignment}, q{pango_layout_get_alignment}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_tabs}, q{PangoLayout* layout, PangoTabArray* tabs}},
			{q{PangoTabArray*}, q{pango_layout_get_tabs}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_set_single_paragraph_mode}, q{PangoLayout* layout, gboolean setting}},
			{q{gboolean}, q{pango_layout_get_single_paragraph_mode}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_context_changed}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_get_log_attrs}, q{PangoLayout* layout, PangoLogAttr** attrs, int* nAttrs}},
			{q{void}, q{pango_layout_index_to_pos}, q{PangoLayout* layout, int index, PangoRectangle* pos}},
			{q{void}, q{pango_layout_index_to_line_x}, q{PangoLayout* layout, int index, gboolean trailing, int* line, int* xPos}},
			{q{void}, q{pango_layout_get_cursor_pos}, q{PangoLayout* layout, int index, PangoRectangle* strongPos, PangoRectangle* weakPos}},
			{q{void}, q{pango_layout_move_cursor_visually}, q{PangoLayout* layout, gboolean strong, int oldIndex, int oldTrailing, int direction, int* newIndex, int* newTrailing}},
			{q{gboolean}, q{pango_layout_xy_to_index}, q{PangoLayout* layout, int x, int y, int* index, int* trailing}},
			{q{void}, q{pango_layout_get_extents}, q{PangoLayout* layout, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
			{q{void}, q{pango_layout_get_pixel_extents}, q{PangoLayout* layout, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
			{q{void}, q{pango_layout_get_size}, q{PangoLayout* layout, int* width, int* height}},
			{q{void}, q{pango_layout_get_pixel_size}, q{PangoLayout* layout, int* width, int* height}},
			{q{int}, q{pango_layout_get_line_count}, q{PangoLayout* layout}},
			{q{PangoLayoutLine*}, q{pango_layout_get_line}, q{PangoLayout* layout, int line}},
			{q{GSList*}, q{pango_layout_get_lines}, q{PangoLayout* layout}},
			{q{GType}, q{pango_layout_line_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_LAYOUT_LINE}]},
			{q{void}, q{pango_layout_line_unref}, q{PangoLayoutLine* line}},
			{q{gboolean}, q{pango_layout_line_x_to_index}, q{PangoLayoutLine* line, int xPos, int* index, int* trailing}},
			{q{void}, q{pango_layout_line_index_to_x}, q{PangoLayoutLine* line, int index, gboolean trailing, int* xPos}},
			{q{void}, q{pango_layout_line_get_x_ranges}, q{PangoLayoutLine* line, int startIndex, int endIndex, int** ranges, int* nRanges}},
			{q{void}, q{pango_layout_line_get_extents}, q{PangoLayoutLine* line, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
			{q{void}, q{pango_layout_line_get_pixel_extents}, q{PangoLayoutLine* layoutLine, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
			{q{GType}, q{pango_layout_iter_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_LAYOUT_ITER}]},
			{q{PangoLayoutIter*}, q{pango_layout_get_iter}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_iter_free}, q{PangoLayoutIter* iter}},
			{q{int}, q{pango_layout_iter_get_index}, q{PangoLayoutIter* iter}},
			{q{PangoLayoutRun*}, q{pango_layout_iter_get_run}, q{PangoLayoutIter* iter}},
			{q{PangoLayoutLine*}, q{pango_layout_iter_get_line}, q{PangoLayoutIter* iter}},
			{q{gboolean}, q{pango_layout_iter_at_last_line}, q{PangoLayoutIter* iter}},
			{q{gboolean}, q{pango_layout_iter_next_char}, q{PangoLayoutIter* iter}},
			{q{gboolean}, q{pango_layout_iter_next_cluster}, q{PangoLayoutIter* iter}},
			{q{gboolean}, q{pango_layout_iter_next_run}, q{PangoLayoutIter* iter}},
			{q{gboolean}, q{pango_layout_iter_next_line}, q{PangoLayoutIter* iter}},
			{q{void}, q{pango_layout_iter_get_char_extents}, q{PangoLayoutIter* iter, PangoRectangle* logicalRect}},
			{q{void}, q{pango_layout_iter_get_cluster_extents}, q{PangoLayoutIter* iter, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
			{q{void}, q{pango_layout_iter_get_run_extents}, q{PangoLayoutIter* iter, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
			{q{void}, q{pango_layout_iter_get_line_extents}, q{PangoLayoutIter* iter, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
			{q{void}, q{pango_layout_iter_get_line_yrange}, q{PangoLayoutIter* iter, int* y0, int* y1}},
			{q{void}, q{pango_layout_iter_get_layout_extents}, q{PangoLayoutIter* iter, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
			{q{int}, q{pango_layout_iter_get_baseline}, q{PangoLayoutIter* iter}},
	];
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{void}, q{pango_layout_set_auto_dir}, q{PangoLayout* layout, gboolean autoDir}},
			{q{gboolean}, q{pango_layout_get_auto_dir}, q{PangoLayout* layout}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{void}, q{pango_layout_set_ellipsize}, q{PangoLayout* layout, PangoEllipsiseMode ellipsise}, aliases: [q{pango_layout_set_ellipsise}]},
			{q{PangoEllipsizeMode}, q{pango_layout_get_ellipsize}, q{PangoLayout* layout}, aliases: [q{pango_layout_get_ellipsise}]},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,8,0)){
		FnBind[] add = [
			{q{const(PangoFontDescription)*}, q{pango_layout_get_font_description}, q{PangoLayout* layout}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{gboolean}, q{pango_layout_is_wrapped}, q{PangoLayout* layout}},
			{q{gboolean}, q{pango_layout_is_ellipsized}, q{PangoLayout* layout}, aliases: [q{pango_layout_is_ellipsised}]},
			{q{int}, q{pango_layout_get_unknown_glyphs_count}, q{PangoLayout* layout}},
			{q{PangoLayoutLine*}, q{pango_layout_get_line_readonly}, q{PangoLayout* layout, int line}},
			{q{GSList*}, q{pango_layout_get_lines_readonly}, q{PangoLayout* layout}},
			{q{PangoLayoutRun*}, q{pango_layout_iter_get_run_readonly}, q{PangoLayoutIter* iter}},
			{q{PangoLayoutLine*}, q{pango_layout_iter_get_line_readonly}, q{PangoLayoutIter* iter}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,20,0)){
		FnBind[] add = [
			{q{void}, q{pango_layout_set_height}, q{PangoLayout* layout, int height}},
			{q{int}, q{pango_layout_get_height}, q{PangoLayout* layout}},
			{q{PangoLayoutIter*}, q{pango_layout_iter_copy}, q{PangoLayoutIter* iter}},
			{q{PangoLayout*}, q{pango_layout_iter_get_layout}, q{PangoLayoutIter* iter}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,22,0)){
		FnBind[] add = [
			{q{int}, q{pango_layout_get_baseline}, q{PangoLayout* layout}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,30,0)){
		FnBind[] add = [
			{q{int}, q{pango_layout_get_character_count}, q{PangoLayout* layout}},
			{q{const(PangoLogAttr)*}, q{pango_layout_get_log_attrs_readonly}, q{PangoLayout* layout, int* nAttrs}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,32,0)){
		FnBind[] add = [
			{q{uint}, q{pango_layout_get_serial}, q{PangoLayout* layout}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{void}, q{pango_layout_set_line_spacing}, q{PangoLayout* layout, float factor}},
			{q{float}, q{pango_layout_get_line_spacing}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_line_get_height}, q{PangoLayoutLine* line, int* height}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,46,0)){
		FnBind[] add = [
			{q{PangoDirection}, q{pango_layout_get_direction}, q{PangoLayout* layout, int index}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,50,0)){
		FnBind[] add = [
			{q{void}, q{pango_layout_set_justify_last_line}, q{PangoLayout* layout, gboolean justify}},
			{q{gboolean}, q{pango_layout_get_justify_last_line}, q{PangoLayout* layout}},
			{q{void}, q{pango_layout_get_caret_pos}, q{PangoLayout* layout, int index, PangoRectangle* strongPos, PangoRectangle* weakPos}},
			{q{GBytes*}, q{pango_layout_serialize}, q{PangoLayout* layout, PangoLayoutSerialiseFlags flags}, aliases: [q{pango_layout_serialise}]},
			{q{gboolean}, q{pango_layout_write_to_file}, q{PangoLayout* layout, PangoLayoutSerialiseFlags flags, const(char)* filename, GError** error}},
			{q{GQuark}, q{pango_layout_deserialize_error_quark}, q{}, aliases: [q{pango_layout_deserialise_error_quark}, q{PANGO_LAYOUT_DESERIALISE_ERROR}, q{PANGO_LAYOUT_DESERIALIZE_ERROR}]},
			{q{PangoLayout*}, q{pango_layout_deserialize}, q{PangoContext* context, GBytes* bytes, PangoLayoutDeserialiseFlags flags, GError** error}, aliases: [q{pango_layout_deserialise}]},
			{q{PangoLayoutLine*}, q{pango_layout_line_ref}, q{PangoLayoutLine* line}},
			{q{int}, q{pango_layout_line_get_start_index}, q{PangoLayoutLine* line}},
			{q{int}, q{pango_layout_line_get_length}, q{PangoLayoutLine* line}},
			{q{gboolean}, q{pango_layout_line_is_paragraph_start}, q{PangoLayoutLine* line}},
			{q{PangoDirection}, q{pango_layout_line_get_resolved_direction}, q{PangoLayoutLine* line}},
			{q{int}, q{pango_layout_iter_get_run_baseline}, q{PangoLayoutIter* iter}},
		];
		ret ~= add;
	}
	return ret;
}()));
