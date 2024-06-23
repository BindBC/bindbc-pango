/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.tabs;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.types;

struct PangoTabArray;

mixin(makeEnumBind(q{PangoTabAlign}, aliases: [q{PangoTab}], members: (){
	EnumMember[] ret = [
		{{q{left},         q{PANGO_TAB_LEFT}}},
		
	];
	if(pangoVersion >= Version(1,50,0)){
		EnumMember[] add = [
			{{q{right},    q{PANGO_TAB_RIGHT}}},
			{{q{centre},   q{PANGO_TAB_CENTRE}}, aliases: [{q{center}, q{PANGO_TAB_CENTER}}]},
			{{q{decimal},  q{PANGO_TAB_DECIMAL}}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{PangoTabArray*}, q{pango_tab_array_new}, q{int initialSize, gboolean positionsInPixels}},
			{q{PangoTabArray*}, q{pango_tab_array_new_with_positions}, q{int size, gboolean positionsInPixels, PangoTabAlign firstAlignment, int firstPosition, ...}},
			{q{GType}, q{pango_tab_array_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_TAB_ARRAY}]},
			{q{PangoTabArray*}, q{pango_tab_array_copy}, q{PangoTabArray* src}},
			{q{void}, q{pango_tab_array_free}, q{PangoTabArray* tabArray}},
			{q{int}, q{pango_tab_array_get_size}, q{PangoTabArray* tabArray}},
			{q{void}, q{pango_tab_array_resize}, q{PangoTabArray* tabArray, int newSize}},
			{q{void}, q{pango_tab_array_set_tab}, q{PangoTabArray* tabArray, int tabIndex, PangoTabAlign alignment, int location}},
			{q{void}, q{pango_tab_array_get_tab}, q{PangoTabArray* tabArray, int tabIndex, PangoTabAlign* alignment, int* location}},
			{q{void}, q{pango_tab_array_get_tabs}, q{PangoTabArray* tabArray, PangoTabAlign** alignments, int** locations}},
			{q{gboolean}, q{pango_tab_array_get_positions_in_pixels}, q{PangoTabArray* tabArray}},
	];
	if(pangoVersion >= Version(1,50,0)){
		FnBind[] add = [
			{q{void}, q{pango_tab_array_set_positions_in_pixels}, q{PangoTabArray* tabArray, gboolean positionsInPixels}},
			{q{char*}, q{pango_tab_array_to_string}, q{PangoTabArray* tabArray}},
			{q{PangoTabArray*}, q{pango_tab_array_from_string}, q{const char* text}},
			{q{void}, q{pango_tab_array_set_decimal_point}, q{PangoTabArray* tabArray, int tabIndex, dchar decimalPoint}},
			{q{dchar}, q{pango_tab_array_get_decimal_point}, q{PangoTabArray* tabArray, int tabIndex}},
			{q{void}, q{pango_tab_array_sort}, q{PangoTabArray* tabArray}},
		];
		ret ~= add;
	}
	return ret;
}()));
