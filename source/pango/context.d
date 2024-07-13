/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.context;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.attributes;
import pango.direction;
import pango.font;
import pango.fontmap;
import pango.fontset;
import pango.gravity;
import pango.matrix;
import pango.types;

struct PangoContextClass;

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GType}, q{pango_context_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_CONTEXT}]},
			{q{PangoContext*}, q{pango_context_new}, q{}},
			{q{void}, q{pango_context_set_font_map}, q{PangoContext* context, PangoFontMap* fontMap}},
			{q{void}, q{pango_context_list_families}, q{PangoContext* context, PangoFontFamily*** families, int* nFamilies}},
			{q{PangoFont*}, q{pango_context_load_font}, q{PangoContext* context, const(PangoFontDescription)* desc}},
			{q{PangoFontset*}, q{pango_context_load_fontset}, q{PangoContext* context, const(PangoFontDescription)* desc, PangoLanguage* language}},
			{q{PangoFontMetrics*}, q{pango_context_get_metrics}, q{PangoContext* context, const(PangoFontDescription)* desc, PangoLanguage* language}},
			{q{void}, q{pango_context_set_font_description}, q{PangoContext* context, const(PangoFontDescription)* desc}},
			{q{PangoFontDescription*}, q{pango_context_get_font_description}, q{PangoContext* context}},
			{q{PangoLanguage*}, q{pango_context_get_language}, q{PangoContext* context}},
			{q{void}, q{pango_context_set_language}, q{PangoContext* context, PangoLanguage* language}},
			{q{void}, q{pango_context_set_base_dir}, q{PangoContext* context, PangoDirection direction}},
			{q{PangoDirection}, q{pango_context_get_base_dir}, q{PangoContext* context}},
	];
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{PangoFontMap*}, q{pango_context_get_font_map}, q{PangoContext* context}},
			{q{void}, q{pango_context_set_matrix}, q{PangoContext* context, const(PangoMatrix)* matrix}},
			{q{const(PangoMatrix)*}, q{pango_context_get_matrix}, q{PangoContext* context}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{void}, q{pango_context_set_base_gravity}, q{PangoContext* context, PangoGravity gravity}},
			{q{PangoGravity}, q{pango_context_get_base_gravity}, q{PangoContext* context}},
			{q{PangoGravity}, q{pango_context_get_gravity}, q{PangoContext* context}},
			{q{void}, q{pango_context_set_gravity_hint}, q{PangoContext* context, PangoGravityHint hint}},
			{q{PangoGravityHint}, q{pango_context_get_gravity_hint}, q{PangoContext* context}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,32,0)){
		FnBind[] add = [
			{q{void}, q{pango_context_changed}, q{PangoContext* context}},
			{q{uint}, q{pango_context_get_serial}, q{PangoContext* context}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{void}, q{pango_context_set_round_glyph_positions}, q{PangoContext* context, gboolean roundPositions}},
			{q{gboolean}, q{pango_context_get_round_glyph_positions}, q{PangoContext* context}},
		];
		ret ~= add;
	}
	return ret;
}()));
