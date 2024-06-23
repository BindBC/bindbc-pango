/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.fontmap;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.font;
import pango.fontset;
import pango.types;

struct PangoFontMap{
	GObject parentInstance;
	alias parent_instance = parentInstance;
}

struct PangoFontMapClass{
	GObjectClass parentClass;
	alias parent_class = parentClass;
	
	extern(C) nothrow{
		alias LoadFontFn = PangoFont* function();
		alias ListFamiliesFn = void function();
		alias LoadFontsetFn = PangoFontset* function();
		alias GetSerialFn = uint function(PangoFontMap* fontmap);
		alias ChangedcFn = void function(PangoFontMap* fontmap);
		alias GetFamilyFn = PangoFontFamily* function(PangoFontMap* fontmap, const(char)* name);
		alias GetFaceFn = PangoFontFace* function(PangoFontMap* fontmap, PangoFont* font);
	}
	LoadFontFn loadFont;
	ListFamiliesFn listFamilies;
	LoadFontsetFn loadFontset;
	const(char)* shapeEngineType;
	GetSerialFn getSerial;
	ChangedcFn changed;
	GetFamilyFn getFamily;
	GetFaceFn getFace;
	alias load_font = loadFont;
	alias list_families = listFamilies;
	alias load_fontset = loadFontset;
	alias shape_engine_type = shapeEngineType;
	alias get_serial = getSerial;
	alias get_family = getFamily;
	alias get_face = getFace;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_font_map_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_FONT_MAP}]},
		{q{PangoFont*}, q{pango_font_map_load_font}, q{PangoFontMap* fontmap, PangoContext* context, const(PangoFontDescription)* desc}},
		{q{PangoFontset*}, q{pango_font_map_load_fontset}, q{PangoFontMap* fontmap, PangoContext* context, const(PangoFontDescription)* desc, PangoLanguage* language}},
		{q{void}, q{pango_font_map_list_families}, q{PangoFontMap* fontmap, PangoFontFamily*** families, int* nFamilies}},
	];
	if(pangoVersion >= Version(1,22,0)){
		FnBind[] add = [
			{q{PangoContext*}, q{pango_font_map_create_context}, q{PangoFontMap* fontmap}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,32,0)){
		FnBind[] add = [
			{q{uint}, q{pango_font_map_get_serial}, q{PangoFontMap* fontmap}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,34,0)){
		FnBind[] add = [
			{q{void}, q{pango_font_map_changed}, q{PangoFontMap* fontmap}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,46,0)){
		FnBind[] add = [
			{q{PangoFontFamily*}, q{pango_font_map_get_family}, q{PangoFontMap* fontmap, const(char)* name}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,52,0)){
		FnBind[] add = [
			{q{PangoFont*}, q{pango_font_map_reload_font}, q{PangoFontMap* fontmap, PangoFont* font, double scale, PangoContext* context, const(char)* variations}},
		];
		ret ~= add;
	}
	return ret;
}()));
