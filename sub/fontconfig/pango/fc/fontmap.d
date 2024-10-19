/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.fc.fontmap;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango;
import pango.fc.decoder;
import pango.fc.font;

import bindbc.fontconfig;

struct PangoFcFontMap;

struct PangoFcFontMapClass;

struct PangoFcFontMapPrivate;

extern(C) nothrow{
	alias PangoFcDecoderFindFunc = PangoFcDecoder* function(FcPattern* pattern, void* userData);
	alias PangoFcSubstituteFunc = void function(FcPattern* pattern, void* data);
}

static if(pangoVersion >= Version(1,20,0)){
	enum PANGO_FC_GRAVITY = "pangogravity";
	enum PANGO_FC_VERSION = "pangoversion";
}
static if(pangoVersion >= Version(1,24,0)){
	enum PANGO_FC_PRGNAME = "prgname";
}
static if(pangoVersion >= Version(1,34,0)){
	enum PANGO_FC_FONT_FEATURES = "fontfeatures";
}
enum PANGO_FC_FONT_VARIATIONS = "fontvariations";

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_fc_font_map_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_FC_TYPE_FONT_MAP}]},
	];
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{void}, q{pango_fc_font_map_cache_clear}, q{PangoFcFontMap* fcFontMap}},
			{q{PangoFontDescription*}, q{pango_fc_font_description_from_pattern}, q{FcPattern* pattern, gboolean includeSize}},
			{q{void}, q{pango_fc_font_map_shutdown}, q{PangoFcFontMap* fcFontMap}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{void}, q{pango_fc_font_map_add_decoder_find_func}, q{PangoFcFontMap* fcFontMap, PangoFcDecoderFindFunc findFunc, void* userData, GDestroyNotify dNotify}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,26,0)){
		FnBind[] add = [
			{q{PangoFcDecoder*}, q{pango_fc_font_map_find_decoder}, q{PangoFcFontMap* fcFontMap, FcPattern* pattern}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,38,0)){
		FnBind[] add = [
			{q{void}, q{pango_fc_font_map_config_changed}, q{PangoFcFontMap* fcFontMap}},
			{q{void}, q{pango_fc_font_map_set_config}, q{PangoFcFontMap* fcFontMap, FcConfig* fcConfig}},
			{q{FcConfig*}, q{pango_fc_font_map_get_config}, q{PangoFcFontMap* fcFontMap}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{hb_face_t*}, q{pango_fc_font_map_get_hb_face}, q{PangoFcFontMap* fcFontMap, PangoFcFont* fcFont}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,48,0)){
		FnBind[] add = [
			{q{void}, q{pango_fc_font_map_set_default_substitute}, q{PangoFcFontMap* fontMap, PangoFcSubstituteFunc func, void* data, GDestroyNotify notify}},
			{q{void}, q{pango_fc_font_map_substitute_changed}, q{PangoFcFontMap* fontMap}},
		];
		ret ~= add;
	}
	return ret;
}()));
