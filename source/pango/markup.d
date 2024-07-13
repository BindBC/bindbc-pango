/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.markup;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.attributes;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{gboolean}, q{pango_parse_markup}, q{const(char)* markupText, int length, dchar accelMarker, PangoAttrList** attrList, char** text, dchar* accelChar, GError** error}},
	];
	if(pangoVersion >= Version(1,32,0)){
		FnBind[] add = [
			{q{GMarkupParseContext*}, q{pango_markup_parser_new}, q{dchar accelMarker}},
			{q{gboolean}, q{pango_markup_parser_finish}, q{GMarkupParseContext* context, PangoAttrList** attrList, char** text, dchar* accelChar, GError** error}},
		];
		ret ~= add;
	}
	return ret;
}()));
