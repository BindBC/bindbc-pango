/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.fontset_simple;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.coverage;
import pango.fontset;
import pango.types;

struct PangoFontsetSimple;
struct PangoFontsetSimpleClass;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_fontset_simple_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_FONTSET_SIMPLE}]},
		{q{PangoFontsetSimple*}, q{pango_fontset_simple_new}, q{PangoLanguage* language}},
		{q{void}, q{pango_fontset_simple_append}, q{PangoFontsetSimple* fontset, PangoFont* font}},
		{q{int}, q{pango_fontset_simple_size}, q{PangoFontsetSimple* fontset}},
	];
	return ret;
}()));
