/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.utils;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.font;

pragma(inline,true) nothrow @nogc pure @safe{
	auto pangoVersionEncode(uint major, uint minor, uint micro) =>
		(major*  10_000) +
		(minor*     100) +
		(micro*       1);
	bool pangoVersionCheck(uint major,uint minor,uint micro) =>
		pangoVersion >= Version(major, minor, micro);
	
	alias PANGO_VERSION_ENCODE = pangoVersionEncode;
	alias PANGO_VERSION_CHECK = pangoVersionCheck;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{gboolean}, q{pango_parse_style}, q{const(char)* str, PangoStyle* style, gboolean warn}},
		{q{gboolean}, q{pango_parse_variant}, q{const(char)* str, PangoVariant* variant, gboolean warn}},
		{q{gboolean}, q{pango_parse_weight}, q{const(char)* str, PangoWeight* weight, gboolean warn}},
		{q{gboolean}, q{pango_parse_stretch}, q{const(char)* str, PangoStretch* stretch, gboolean warn}},
		{q{void}, q{pango_find_paragraph_boundary}, q{const(char)* text, int length, int* paragraphDelimiterIndex, int* nextParagraphStart}},
	];
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{ubyte*}, q{pango_log2vis_get_embedding_levels}, q{const(char)* text, int length, PangoDirection* pBaseDir}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,10,0)){
		FnBind[] add = [
			{q{gboolean}, q{pango_is_zero_width}, q{dchar ch}, attr: q{pure}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,12,0)){
		FnBind[] add = [
			{q{void}, q{pango_quantize_line_geometry}, q{int* thickness, int* position}, aliases: [q{pango_quantise_line_geometry}]},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{int}, q{pango_version}, q{}, attr: q{pure}},
			{q{const(char)*}, q{pango_version_string}, q{}, attr: q{pure}},
			{q{const(char)*}, q{pango_version_check}, q{int requiredMajor, int requiredMinor, int requiredMicro}, attr: q{pure}},
		];
		ret ~= add;
	}
	return ret;
}()));
