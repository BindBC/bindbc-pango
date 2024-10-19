/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.script;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.types;

struct PangoScriptIter;

alias PangoScript = GUnicodeScript;

mixin(joinFnBinds((){
	FnBind[] ret;
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{PangoScriptIter*}, q{pango_script_iter_new}, q{const(char)* text, int length}},
			{q{void}, q{pango_script_iter_get_range}, q{PangoScriptIter* iter, const(char)** start, const(char)** end, PangoScript* script}},
			{q{gboolean}, q{pango_script_iter_next}, q{PangoScriptIter* iter}},
			{q{void}, q{pango_script_iter_free}, q{PangoScriptIter* iter}},
			{q{PangoLanguage*}, q{pango_script_get_sample_language}, q{PangoScript script}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{GType}, q{pango_script_iter_get_type}, q{}, attr: q{pure}},
		];
		ret ~= add;
	}
	return ret;
}()));
