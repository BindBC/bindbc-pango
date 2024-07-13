/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.coverage;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

struct PangoCoverage;

mixin(makeEnumBind(q{PangoCoverageLevel}, members: (){
	EnumMember[] ret = [
		{{q{none},         q{PANGO_COVERAGE_NONE}}},
		{{q{fallback},     q{PANGO_COVERAGE_FALLBACK}}},
		{{q{approximate},  q{PANGO_COVERAGE_APPROXIMATE}}},
		{{q{exact},        q{PANGO_COVERAGE_EXACT}}},
	];
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_coverage_get_type}, q{}, attr: q{pure}},
		{q{PangoCoverage*}, q{pango_coverage_new}, q{}},
		{q{PangoCoverage*}, q{pango_coverage_copy}, q{PangoCoverage* coverage}},
		{q{PangoCoverageLevel}, q{pango_coverage_get}, q{PangoCoverage* coverage, int index}},
		{q{void}, q{pango_coverage_set}, q{PangoCoverage* coverage, int index, PangoCoverageLevel level}},
	];
	return ret;
}()));
