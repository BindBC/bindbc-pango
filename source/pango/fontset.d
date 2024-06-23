/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.fontset;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.coverage;
import pango.font;
import pango.types;

alias PangoFontsetForeachFunc = extern(C) gboolean function(PangoFontset* fontset, PangoFont* font, void* userData) nothrow;

struct PangoFontset{
	GObject parentInstance;
	alias parent_instance = parentInstance;
}

struct PangoFontsetClass{
	GObjectClass parentClass;
	alias parent_class = parentClass;
	
	extern(C) nothrow{
		alias GetFontFn = PangoFont* function(PangoFontset* fontset, uint wc);
		alias GetMetricsFn = PangoFontMetrics* function(PangoFontset* fontset);
		alias GetLanguageFn = PangoLanguage* function(PangoFontset* fontset);
		alias ForeachFn = void function(PangoFontset* fontset, PangoFontsetForeachFunc func, void* data);
		alias ReservedFn = void function();
	}
	GetFontFn getFont;
	GetMetricsFn getMetrics;
	GetLanguageFn getLanguage;
	ForeachFn foreach_;
	alias get_font = getFont;
	alias get_metrics = getMetrics;
	alias get_language = getLanguage;
	
	private:
	ReservedFn _pango_reserved1;
	ReservedFn _pango_reserved2;
	ReservedFn _pango_reserved3;
	ReservedFn _pango_reserved4;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_fontset_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_FONTSET}]},
		{q{PangoFont*}, q{pango_fontset_get_font}, q{PangoFontset* fontset, uint wc}},
		{q{PangoFontMetrics*}, q{pango_fontset_get_metrics}, q{PangoFontset* fontset}},
	];
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{void}, q{pango_fontset_foreach}, q{PangoFontset* fontset, PangoFontsetForeachFunc func, void* data}},
		];
		ret ~= add;
	}
	return ret;
}()));
