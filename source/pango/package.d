/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango;

import bindbc.pango.config;
import bindbc.pango.codegen;

public import
	pango.attributes,  pango.break_,      pango.colour,
	pango.context,     pango.coverage,    pango.direction,
	pango.font,        pango.fontmap,     pango.fontset_simple,
	pango.fontset,     pango.glyph_item,  pango.glyph,
	pango.gravity,     pango.item,        pango.language,
	pango.layout,      pango.markup,      pango.matrix,
	pango.renderer,    pango.script,      pango.tabs,
	pango.types,       pango.utils;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GObject*}, q{g_object_ref}, q{GObject* object}},
		{q{void}, q{g_object_unref}, q{GObject* object}},
		{q{void}, q{g_list_free_full}, q{GList* list, GDestroyNotify freeFunc}},
		{q{void}, q{g_free}, q{void* mem}},
	];
	return ret;
}()));

static if(!staticBinding):
import bindbc.loader;

mixin(makeDynloadFns("Pango", makeLibPaths(["pango-1.0"]), [
	__MODULE__,
	"pango.attributes",  "pango.break_",          "pango.colour",
	"pango.context",     "pango.coverage",        "pango.font",
	"pango.fontmap",     "pango.fontset_simple",  "pango.fontset",
	"pango.glyph_item",  "pango.glyph",           "pango.gravity",
	"pango.item",        "pango.language",        "pango.layout",
	"pango.markup",      "pango.matrix",          "pango.renderer",
	"pango.script",      "pango.tabs",            "pango.types",
	"pango.utils",
]));
