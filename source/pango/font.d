/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.font;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.coverage;
import pango.fontmap;
import pango.gravity;
import pango.types;

struct PangoFontDescription;

mixin(makeEnumBind(q{PangoStyle}, members: (){
	EnumMember[] ret = [
		{{q{normal},   q{PANGO_STYLE_NORMAL}}},
		{{q{oblique},  q{PANGO_STYLE_OBLIQUE}}},
		{{q{italic},   q{PANGO_STYLE_ITALIC}}},
	];
	return ret;
}()));


mixin(makeEnumBind(q{PangoVariant}, members: (){
	EnumMember[] ret = [
		{{q{normal},     q{PANGO_VARIANT_NORMAL}}},
		{{q{smallCaps},  q{PANGO_VARIANT_SMALL_CAPS}}},
	];
	if(pangoVersion >= Version(1,50,0)){
		EnumMember[] add = [
			{{q{allSmallCaps},   q{PANGO_VARIANT_ALL_SMALL_CAPS}}},
			{{q{petiteCaps},     q{PANGO_VARIANT_PETITE_CAPS}}},
			{{q{allPetiteCaps},  q{PANGO_VARIANT_ALL_PETITE_CAPS}}},
			{{q{unicase},        q{PANGO_VARIANT_UNICASE}}},
			{{q{titleCaps},      q{PANGO_VARIANT_TITLE_CAPS}}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{PangoWeight}, members: (){
	EnumMember[] ret = [
		{{q{ultraLight},  q{PANGO_WEIGHT_ULTRALIGHT}},      q{200}},
		{{q{light},       q{PANGO_WEIGHT_LIGHT}},           q{300}},
		{{q{normal},      q{PANGO_WEIGHT_NORMAL}},          q{400}},
		{{q{semiBold},    q{PANGO_WEIGHT_SEMIBOLD}},        q{600}},
		{{q{bold},        q{PANGO_WEIGHT_BOLD}},            q{700}},
		{{q{ultraBold},   q{PANGO_WEIGHT_ULTRABOLD}},       q{800}},
		{{q{heavy},       q{PANGO_WEIGHT_HEAVY}},           q{900}},
	];
	if(pangoVersion >= Version(1,24,0)){
		EnumMember[] add = [
			{{q{thin},        q{PANGO_WEIGHT_THIN}},        q{100}},
			{{q{book},        q{PANGO_WEIGHT_BOOK}},        q{380}},
			{{q{medium},      q{PANGO_WEIGHT_MEDIUM}},      q{500}},
			{{q{ultraHeavy},  q{PANGO_WEIGHT_ULTRAHEAVY}},  q{1000}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,36,7)){
		EnumMember[] add = [
			{{q{semiLight},   q{PANGO_WEIGHT_SEMILIGHT}},   q{350}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{PangoStretch}, members: (){
	EnumMember[] ret = [
		{{q{ultraCondensed},  q{PANGO_STRETCH_ULTRA_CONDENSED}}},
		{{q{extraCondensed},  q{PANGO_STRETCH_EXTRA_CONDENSED}}},
		{{q{condensed},       q{PANGO_STRETCH_CONDENSED}}},
		{{q{semiCondensed},   q{PANGO_STRETCH_SEMI_CONDENSED}}},
		{{q{normal},          q{PANGO_STRETCH_NORMAL}}},
		{{q{semiExpanded},    q{PANGO_STRETCH_SEMI_EXPANDED}}},
		{{q{expanded},        q{PANGO_STRETCH_EXPANDED}}},
		{{q{extraExpanded},   q{PANGO_STRETCH_EXTRA_EXPANDED}}},
		{{q{ultraExpanded},   q{PANGO_STRETCH_ULTRA_EXPANDED}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{PangoFontMask}, members: (){
	EnumMember[] ret = [
		{{q{family},      q{PANGO_FONT_MASK_FAMILY}},      q{1 << 0}},
		{{q{style},       q{PANGO_FONT_MASK_STYLE}},       q{1 << 1}},
		{{q{variant},     q{PANGO_FONT_MASK_VARIANT}},     q{1 << 2}},
		{{q{weight},      q{PANGO_FONT_MASK_WEIGHT}},      q{1 << 3}},
		{{q{stretch},     q{PANGO_FONT_MASK_STRETCH}},     q{1 << 4}},
		{{q{size},        q{PANGO_FONT_MASK_SIZE}},        q{1 << 5}},
	];
	if(pangoVersion >= Version(1,16,0)){
		EnumMember[] add = [
		{{q{gravity},     q{PANGO_FONT_MASK_GRAVITY}},     q{1 << 6}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,42,0)){
		EnumMember[] add = [
		{{q{variations},  q{PANGO_FONT_MASK_VARIATIONS}},  q{1 << 7}},
		];
		ret ~= add;
	}
	return ret;
}()));

enum: double{
	pangoScaleXXSmall     = 0.5787037037037,
	pangoScaleXSmall      = 0.6944444444444,
	pangoScaleSmall       = 0.8333333333333,
	pangoScaleMedium      = 1.0,
	pangoScaleLarge       = 1.2,
	pangoScaleXLarge      = 1.44,
	pangoScaleXXLarge     = 1.728,
	PANGO_SCALE_XX_SMALL  = pangoScaleXXSmall,
	PANGO_SCALE_X_SMALL   = pangoScaleXSmall,
	PANGO_SCALE_SMALL     = pangoScaleSmall,
	PANGO_SCALE_MEDIUM    = pangoScaleMedium,
	PANGO_SCALE_LARGE     = pangoScaleLarge,
	PANGO_SCALE_X_LARGE   = pangoScaleXLarge,
	PANGO_SCALE_XX_LARGE  = pangoScaleXXLarge,
}

struct PangoFontMetrics{
	private uint refCount;

	int ascent;
	int descent;
	int height;
	int approximateCharWidth;
	int approximateDigitWidth;
	int underlinePosition;
	int underlineThickness;
	int strikethroughPosition;
	int strikethroughThickness;
	alias approximate_char_width = approximateCharWidth;
	alias approximate_digit_width = approximateDigitWidth;
	alias underline_position = underlinePosition;
	alias underline_thickness = underlineThickness;
	alias strikethrough_position = strikethroughPosition;
	alias strikethrough_thickness = strikethroughThickness;
}

struct PangoFontFace;

struct PangoFontFamily;

struct PangoFontFamilyClass;

struct PangoFontFaceClass;

enum PangoGlyph pangoGlyphEmpty         = 0x0FFF_FFFF;
enum PangoGlyph pangoGlyphInvalidInput  = 0xFFFF_FFFF;
alias PANGO_GLYPH_EMPTY = pangoGlyphEmpty;
alias PANGO_GLYPH_INVALID_INPUT = pangoGlyphInvalidInput;

static if(pangoVersion >= Version(1,20,0)){
	enum PangoGlyph pangoGlyphUnknownFlag   = 0x1000_0000;
	alias PANGO_GLYPH_UNKNOWN_FLAG = pangoGlyphUnknownFlag;
	
	pragma(inline,true) PangoGlyph pangoGetUnknownGlyph(dchar wc) nothrow @nogc pure @safe =>
		cast(PangoGlyph)wc|pangoGlyphUnknownFlag;
	alias PANGO_GET_UNKNOWN_GLYPH = pangoGetUnknownGlyph;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_font_description_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_FONT_DESCRIPTION}]},
		{q{PangoFontDescription*}, q{pango_font_description_new}, q{}},
		{q{PangoFontDescription*}, q{pango_font_description_copy}, q{const(PangoFontDescription)* desc}},
		{q{PangoFontDescription*}, q{pango_font_description_copy_static}, q{const(PangoFontDescription)* desc}},
		{q{uint}, q{pango_font_description_hash}, q{const(PangoFontDescription)* desc}},
		{q{gboolean}, q{pango_font_description_equal}, q{const(PangoFontDescription)* desc1, const(PangoFontDescription)* desc2}},
		{q{void}, q{pango_font_description_free}, q{PangoFontDescription* desc}},
		{q{void}, q{pango_font_descriptions_free}, q{PangoFontDescription** descs, int nDescs}},
		{q{void}, q{pango_font_description_set_family}, q{PangoFontDescription* desc, const(char)* family}},
		{q{void}, q{pango_font_description_set_family_static}, q{PangoFontDescription* desc, const(char)* family}},
		{q{const(char)*}, q{pango_font_description_get_family}, q{const(PangoFontDescription)* desc}},
		{q{void}, q{pango_font_description_set_style}, q{PangoFontDescription* desc, PangoStyle style}},
		{q{PangoStyle}, q{pango_font_description_get_style}, q{const(PangoFontDescription)* desc}},
		{q{void}, q{pango_font_description_set_variant}, q{PangoFontDescription* desc, PangoVariant variant}},
		{q{PangoVariant}, q{pango_font_description_get_variant}, q{const(PangoFontDescription)* desc}},
		{q{void}, q{pango_font_description_set_weight}, q{PangoFontDescription* desc, PangoWeight weight}},
		{q{PangoWeight}, q{pango_font_description_get_weight}, q{const(PangoFontDescription)* desc}},
		{q{void}, q{pango_font_description_set_stretch}, q{PangoFontDescription* desc, PangoStretch stretch}},
		{q{PangoStretch}, q{pango_font_description_get_stretch}, q{const(PangoFontDescription)* desc}},
		{q{void}, q{pango_font_description_set_size}, q{PangoFontDescription* desc, int size}},
		{q{int}, q{pango_font_description_get_size}, q{const(PangoFontDescription)* desc}},
		{q{PangoFontMask}, q{pango_font_description_get_set_fields}, q{const(PangoFontDescription)* desc}},
		{q{void}, q{pango_font_description_unset_fields}, q{PangoFontDescription* desc, PangoFontMask toUnset}},
		{q{void}, q{pango_font_description_merge}, q{PangoFontDescription* desc, const(PangoFontDescription)* descToMerge, gboolean replaceExisting}},
		{q{void}, q{pango_font_description_merge_static}, q{PangoFontDescription* desc, const(PangoFontDescription)* descToMerge, gboolean replaceExisting}},
		{q{gboolean}, q{pango_font_description_better_match}, q{const(PangoFontDescription)* desc, const(PangoFontDescription)* oldMatch, const(PangoFontDescription)* newMatch}},
		{q{PangoFontDescription*}, q{pango_font_description_from_string}, q{const(char)* str}},
		{q{char*}, q{pango_font_description_to_string}, q{const(PangoFontDescription)* desc}},
		{q{char*}, q{pango_font_description_to_filename}, q{const(PangoFontDescription)* desc}},
		{q{GType}, q{pango_font_metrics_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_FONT_METRICS}]},
		{q{PangoFontMetrics*}, q{pango_font_metrics_ref}, q{PangoFontMetrics* metrics}},
		{q{void}, q{pango_font_metrics_unref}, q{PangoFontMetrics* metrics}},
		{q{int}, q{pango_font_metrics_get_ascent}, q{PangoFontMetrics* metrics}},
		{q{int}, q{pango_font_metrics_get_descent}, q{PangoFontMetrics* metrics}},
		{q{int}, q{pango_font_metrics_get_approximate_char_width}, q{PangoFontMetrics* metrics}},
		{q{int}, q{pango_font_metrics_get_approximate_digit_width}, q{PangoFontMetrics* metrics}},
		{q{GType}, q{pango_font_family_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_FONT_FAMILY}]},
		{q{void}, q{pango_font_family_list_faces}, q{PangoFontFamily* family, PangoFontFace*** faces, int* nFaces}},
		{q{const(char)*}, q{pango_font_family_get_name}, q{PangoFontFamily*  family}},
		{q{GType}, q{pango_font_face_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_FONT_FACE}]},
		{q{PangoFontDescription*}, q{pango_font_face_describe}, q{PangoFontFace* face}},
		{q{const(char)*}, q{pango_font_face_get_face_name}, q{PangoFontFace* face}},
		{q{GType}, q{pango_font_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_FONT}]},
		{q{PangoFontDescription*}, q{pango_font_describe}, q{PangoFont* font}},
		{q{PangoCoverage*}, q{pango_font_get_coverage}, q{PangoFont* font, PangoLanguage* language}},
		{q{PangoFontMetrics*}, q{pango_font_get_metrics}, q{PangoFont* font, PangoLanguage* language}},
		{q{void}, q{pango_font_get_glyph_extents}, q{PangoFont* font, PangoGlyph glyph, PangoRectangle* inkRect, PangoRectangle* logicalRect}},
	];
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{gboolean}, q{pango_font_family_is_monospace}, q{PangoFontFamily* family}},
			{q{void}, q{pango_font_face_list_sizes}, q{PangoFontFace* face, int** sizes, int* nSizes}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{int}, q{pango_font_metrics_get_underline_position}, q{PangoFontMetrics* metrics}},
			{q{int}, q{pango_font_metrics_get_underline_thickness}, q{PangoFontMetrics* metrics}},
			{q{int}, q{pango_font_metrics_get_strikethrough_position}, q{PangoFontMetrics* metrics}},
			{q{int}, q{pango_font_metrics_get_strikethrough_thickness}, q{PangoFontMetrics* metrics}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,8,0)){
		FnBind[] add = [
			{q{void}, q{pango_font_description_set_absolute_size}, q{PangoFontDescription* desc, double size}},
			{q{gboolean}, q{pango_font_description_get_size_is_absolute}, q{const(PangoFontDescription)* desc}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,10,0)){
		FnBind[] add = [
			{q{PangoFontMap*}, q{pango_font_get_font_map}, q{PangoFont* font}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,14,0)){
		FnBind[] add = [
			{q{PangoFontDescription*}, q{pango_font_describe_with_absolute_size}, q{PangoFont* font}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{void}, q{pango_font_description_set_gravity}, q{PangoFontDescription* desc, PangoGravity gravity}},
			{q{PangoGravity}, q{pango_font_description_get_gravity}, q{const(PangoFontDescription)* desc}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,18,0)){
		FnBind[] add = [
			{q{gboolean}, q{pango_font_face_is_synthesized}, q{PangoFontFace* face}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,42,0)){
		FnBind[] add = [
			{q{void}, q{pango_font_description_set_variations_static}, q{PangoFontDescription* desc, const(char)* variations}},
			{q{void}, q{pango_font_description_set_variations}, q{PangoFontDescription* desc, const(char)* variations}},
			{q{const(char)*}, q{pango_font_description_get_variations}, q{const(PangoFontDescription)* desc}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{int}, q{pango_font_metrics_get_height}, q{PangoFontMetrics* metrics}},
			{q{gboolean}, q{pango_font_family_is_variable}, q{PangoFontFamily* family}},
			{q{gboolean}, q{pango_font_has_char}, q{PangoFont* font, dchar wc}},
			{q{void}, q{pango_font_get_features}, q{PangoFont* font, hb_feature_t* features, uint len, uint* numFeatures}},
			{q{hb_font_t*}, q{pango_font_get_hb_font}, q{PangoFont* font}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,46,0)){
		FnBind[] add = [
			{q{PangoFontFace*}, q{pango_font_family_get_face}, q{PangoFontFamily* family, const(char)* name}},
			{q{PangoFontFamily*}, q{pango_font_face_get_family}, q{PangoFontFace* face}},
			{q{PangoFontFace*}, q{pango_font_get_face}, q{PangoFont* font}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,50,0)){
		FnBind[] add = [
			{q{PangoLanguage**}, q{pango_font_get_languages}, q{PangoFont* font}},
			{q{GBytes*}, q{pango_font_serialize}, q{PangoFont* font}},
			{q{PangoFont*}, q{pango_font_deserialize}, q{PangoContext* context, GBytes* bytes, GError** error}},
		];
		ret ~= add;
	}
	return ret;
}()));
