/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.language;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.script;
import pango.types;

pragma(inline,true) auto pango_language_to_string(PangoLanguage* language) nothrow @nogc pure =>
	cast(const(char)*)language;

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GType}, q{pango_language_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_LANGUAGE}]},
			{q{PangoLanguage*}, q{pango_language_from_string}, q{const(char)* language}},
			{q{const(char)*}, q{pango_language_to_string}, q{PangoLanguage* language}, attr: q{pure}},
			{q{const(char)*}, q{pango_language_get_sample_string}, q{PangoLanguage* language}, attr: q{pure}},
			{q{gboolean}, q{pango_language_matches}, q{PangoLanguage* language, const(char)* rangeList}},
	];
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{gboolean}, q{pango_language_includes_script}, q{PangoLanguage* language, PangoScript script}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{PangoLanguage*}, q{pango_language_get_default}, q{}, attr: q{pure}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,22,0)){
		FnBind[] add = [
			{q{const(PangoScript)*}, q{pango_language_get_scripts}, q{PangoLanguage* language, int* numScripts}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,48,0)){
		FnBind[] add = [
			{q{PangoLanguage**}, q{pango_language_get_preferred}, q{}, attr: q{pure}},
		];
		ret ~= add;
	}
	return ret;
}()));
