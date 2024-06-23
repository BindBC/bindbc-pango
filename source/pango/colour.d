/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.colour;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.types;

struct PangoColour{
	ushort red;
	ushort green;
	ushort blue;
}
alias PangoColor = PangoColour;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_color_get_type}, q{}, attr: q{pure}, aliases: [q{pango_colour_get_type}, q{PANGO_TYPE_COLOUR}, q{PANGO_TYPE_COLOR}]},
		{q{PangoColour*}, q{pango_color_copy}, q{const(PangoColour)* src}, aliases: [q{pango_colour_copy}]},
		{q{void}, q{pango_color_free}, q{PangoColour* colour}, aliases: [q{pango_colour_free}]},
		{q{gboolean}, q{pango_color_parse}, q{PangoColour* colour, const(char)* spec}, aliases: [q{pango_colour_parse}]},
	];
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{char*}, q{pango_color_to_string}, q{const(PangoColour)* colour}, aliases: [q{pango_colour_to_string}]},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,46,0)){
		FnBind[] add = [
			{q{gboolean}, q{pango_color_parse_with_alpha}, q{PangoColour* colour, ushort* alpha, const(char)* spec}, aliases: [q{pango_colour_parse_with_alpha}]},
		];
		ret ~= add;
	}
	return ret;
}()));
