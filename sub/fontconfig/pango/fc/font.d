/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.fc.font;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.glyph;
import pango.font;

import bindbc.fontconfig;

struct PangoFcFont;

struct PangoFcFontClass;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_fc_font_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_FC_TYPE_FONT}]},
	];
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{uint}, q{pango_fc_font_get_glyph}, q{PangoFcFont* font, dchar wc}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,48,0)){
		FnBind[] add = [
			{q{FcPattern*}, q{pango_fc_font_get_pattern}, q{PangoFcFont* font}},
		];
		ret ~= add;
	}
	return ret;
}()));
