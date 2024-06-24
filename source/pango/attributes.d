/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.attributes;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.attributes;
import pango.colour;
import pango.font;
import pango.gravity;
import pango.types;

mixin(makeEnumBind(q{PangoAttrType}, aliases: [q{PangoAttr}], members: (){
	EnumMember[] ret = [
		{{q{invalid},              q{PANGO_ATTR_INVALID}}},
		{{q{language},             q{PANGO_ATTR_LANGUAGE}}},
		{{q{family},               q{PANGO_ATTR_FAMILY}}},
		{{q{style},                q{PANGO_ATTR_STYLE}}},
		{{q{weight},               q{PANGO_ATTR_WEIGHT}}},
		{{q{variant},              q{PANGO_ATTR_VARIANT}}},
		{{q{stretch},              q{PANGO_ATTR_STRETCH}}},
		{{q{size},                 q{PANGO_ATTR_SIZE}}},
		{{q{fontDesc},             q{PANGO_ATTR_FONT_DESC}}},
		{{q{foreground},           q{PANGO_ATTR_FOREGROUND}}},
		{{q{background},           q{PANGO_ATTR_BACKGROUND}}},
		{{q{underline},            q{PANGO_ATTR_UNDERLINE}}},
		{{q{strikethrough},        q{PANGO_ATTR_STRIKETHROUGH}}},
		{{q{rise},                 q{PANGO_ATTR_RISE}}},
		{{q{shape},                q{PANGO_ATTR_SHAPE}}},
		{{q{scale},                q{PANGO_ATTR_SCALE}}},
		{{q{fallback},             q{PANGO_ATTR_FALLBACK}}},
		{{q{letterSpacing},        q{PANGO_ATTR_LETTER_SPACING}}},
		{{q{underlineColour},      q{PANGO_ATTR_UNDERLINE_COLOUR}}, aliases: [{q{underlineColor}, q{PANGO_ATTR_UNDERLINE_COLOR}}]},
		{{q{strikethroughColour},  q{PANGO_ATTR_STRIKETHROUGH_COLOUR}}, aliases: [{q{strikethroughColor}, q{PANGO_ATTR_STRIKETHROUGH_COLOR}}]},
		{{q{absoluteSize},         q{PANGO_ATTR_ABSOLUTE_SIZE}}},
		{{q{gravity},              q{PANGO_ATTR_GRAVITY}}},
		{{q{gravityHint},          q{PANGO_ATTR_GRAVITY_HINT}}},
	];
	if(pangoVersion >= Version(1,38,0)){
		EnumMember[] add = [
			{{q{fontFeatures},        q{PANGO_ATTR_FONT_FEATURES}}},
			{{q{foregroundAlpha},     q{PANGO_ATTR_FOREGROUND_ALPHA}}},
			{{q{backgroundAlpha},     q{PANGO_ATTR_BACKGROUND_ALPHA}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		EnumMember[] add = [
			{{q{allowBreaks},         q{PANGO_ATTR_ALLOW_BREAKS}}},
			{{q{show},                q{PANGO_ATTR_SHOW}}},
			{{q{insertHyphens},       q{PANGO_ATTR_INSERT_HYPHENS}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,46,0)){
		EnumMember[] add = [
			{{q{overline},            q{PANGO_ATTR_OVERLINE}}},
			{{q{overlineColour},       q{PANGO_ATTR_OVERLINE_COLOUR}}, aliases: [{q{overlineColor}, q{PANGO_ATTR_OVERLINE_COLOR}}]},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,50,0)){
		EnumMember[] add = [
			{{q{lineHeight},          q{PANGO_ATTR_LINE_HEIGHT}}},
			{{q{absoluteLineHeight},  q{PANGO_ATTR_ABSOLUTE_LINE_HEIGHT}}},
			{{q{textTransform},       q{PANGO_ATTR_TEXT_TRANSFORM}}},
			{{q{word},                q{PANGO_ATTR_WORD}}},
			{{q{sentence},            q{PANGO_ATTR_SENTENCE}}},
			{{q{baselineShift},       q{PANGO_ATTR_BASELINE_SHIFT}}},
			{{q{fontScale},           q{PANGO_ATTR_FONT_SCALE}}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{PangoUnderline}, members: (){
	EnumMember[] ret = [
		{{q{none},     q{PANGO_UNDERLINE_NONE}}},
		{{q{single},   q{PANGO_UNDERLINE_SINGLE}}},
		{{q{double_},  q{PANGO_UNDERLINE_DOUBLE}}},
		{{q{low},      q{PANGO_UNDERLINE_LOW}}},
	];
	if(pangoVersion >= Version(1,4,0)){
		EnumMember[] add = [
			{{q{error},  q{PANGO_UNDERLINE_ERROR}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,46,0)){
		EnumMember[] add = [
			{{q{singleLine},  q{PANGO_UNDERLINE_SINGLE_LINE}}},
			{{q{doubleLine},  q{PANGO_UNDERLINE_DOUBLE_LINE}}},
			{{q{errorLine},   q{PANGO_UNDERLINE_ERROR_LINE}}},
		];
		ret ~= add;
	}
	return ret;
}()));

static if(pangoVersion >= Version(1,46,0))
mixin(makeEnumBind(q{PangoOverline}, members: (){
	EnumMember[] ret = [
		{{q{none},    q{PANGO_OVERLINE_NONE}}},
		{{q{single},  q{PANGO_OVERLINE_SINGLE}}},
	];
	return ret;
}()));

static if(pangoVersion >= Version(1,44,0))
mixin(makeEnumBind(q{PangoShowFlags}, aliases: [q{PangoShow}], members: (){
	EnumMember[] ret = [
		{{q{none},        q{PANGO_SHOW_NONE}},         q{0}},
		{{q{spaces},      q{PANGO_SHOW_SPACES}},       q{1 << 0}},
		{{q{lineBreaks},  q{PANGO_SHOW_LINE_BREAKS}},  q{1 << 1}},
		{{q{ignorables},  q{PANGO_SHOW_IGNORABLES}},   q{1 << 2}},
	];
	return ret;
}()));

static if(pangoVersion >= Version(1,50,0)){
	mixin(makeEnumBind(q{PangoTextTransform}, members: (){
		EnumMember[] ret = [
			{{q{none},        q{PANGO_TEXT_TRANSFORM_NONE}}},
			{{q{lowercase},   q{PANGO_TEXT_TRANSFORM_LOWERCASE}}},
			{{q{uppercase},   q{PANGO_TEXT_TRANSFORM_UPPERCASE}}},
			{{q{capitalise},  q{PANGO_TEXT_TRANSFORM_CAPITALISE}}, aliases: {q{capitalize}, q{PANGO_TEXT_TRANSFORM_CAPITALIZE}}},
		];
		return ret;
	}()));
	
	mixin(makeEnumBind(q{PangoBaselineShift}, members: (){
		EnumMember[] ret = [
			{{q{none},         q{PANGO_BASELINE_SHIFT_NONE}}},
			{{q{superscript},  q{PANGO_BASELINE_SHIFT_SUPERSCRIPT}}},
			{{q{subscript},    q{PANGO_BASELINE_SHIFT_SUBSCRIPT}}},
		];
		return ret;
	}()));
	
	mixin(makeEnumBind(q{PangoFontScale}, members: (){
		EnumMember[] ret = [
			{{q{none},         q{PANGO_FONT_SCALE_NONE}}},
			{{q{superscript},  q{PANGO_FONT_SCALE_SUPERSCRIPT}}},
			{{q{subscript},    q{PANGO_FONT_SCALE_SUBSCRIPT}}},
			{{q{smallCaps},    q{PANGO_FONT_SCALE_SMALL_CAPS}}},
		];
		return ret;
	}()));
}

static if(pangoVersion >= Version(1,24,0)){
	enum uint pangoAttrIndexFromTextBeginning = 0U;
	enum uint pangoAttrIndexToTextEnd = uint.max + 0U;
	alias PANGO_ATTR_INDEX_FROM_TEXT_BEGINNING = pangoAttrIndexFromTextBeginning;
	alias PANGO_ATTR_INDEX_TO_TEXT_END = pangoAttrIndexToTextEnd;
}

struct PangoAttribute{
	const(PangoAttrClass)* klass;
	uint startIndex;
	uint endIndex;
	alias start_index = startIndex;
	alias end_index = endIndex;
}

alias PangoAttrFilterFunc = extern(C) gboolean function(PangoAttribute* attribute, void* userData) nothrow;

alias PangoAttrDataCopyFunc = extern(C) void* function(const(void)* userData) nothrow;

struct PangoAttrClass{
	PangoAttrType type;
	PangoAttribute* function(const(PangoAttribute)* attr) copy;
	void function(PangoAttribute* attr) destroy;
	gboolean function(const(PangoAttribute)* attr1, const(PangoAttribute)* attr2) equal;
}

struct PangoAttrString{
	PangoAttribute attr;
	char* value;
}

struct PangoAttrLanguage{
	PangoAttribute attr;
	PangoLanguage* value;
}

struct PangoAttrInt{
	PangoAttribute attr;
	int value;
}

struct PangoAttrFloat{
	PangoAttribute attr;
	double value;
}

struct PangoAttrColour{
	PangoAttribute attr;
	PangoColour colour;
	alias color = colour;
}
alias PangoAttrColor = PangoAttrColour;

struct PangoAttrSize{
	PangoAttribute attr;
	int size;
	uint absolute; //originally a 1-bit field
}

struct PangoAttrShape{
	PangoAttribute attr;
	PangoRectangle inkRect;
	PangoRectangle logicalRect;
	alias ink_rect = inkRect;
	alias logical_rect = logicalRect;
	
	void* data;
	PangoAttrDataCopyFunc copyFunc;
	GDestroyNotify destroyFunc;
	alias copy_func = copyFunc;
	alias destroy_func = destroyFunc;
}

struct PangoAttrFontDesc{
	PangoAttribute attr;
	PangoFontDescription* desc;
}

struct PangoAttrFontFeatures{
	PangoAttribute attr;
	char* features;
}

struct PangoAttrList;

struct PangoAttrIterator;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_attribute_get_type}, q{}, attr: q{pure}},
		{q{PangoAttrType}, q{pango_attr_type_register}, q{const(char)* name}},
		{q{PangoAttribute*}, q{pango_attribute_copy}, q{const(PangoAttribute)* attr}},
		{q{void}, q{pango_attribute_destroy}, q{PangoAttribute* attr}},
		{q{gboolean}, q{pango_attribute_equal}, q{const(PangoAttribute)* attr1, const(PangoAttribute)* attr2}},
		{q{PangoAttribute*}, q{pango_attr_language_new}, q{PangoLanguage* language}},
		{q{PangoAttribute*}, q{pango_attr_family_new}, q{const(char)* family}},
		{q{PangoAttribute*}, q{pango_attr_foreground_new}, q{ushort red, ushort green, ushort blue}},
		{q{PangoAttribute*}, q{pango_attr_background_new}, q{ushort red, ushort green, ushort blue}},
		{q{PangoAttribute*}, q{pango_attr_size_new}, q{int size}},
		{q{PangoAttribute*}, q{pango_attr_style_new}, q{PangoStyle style}},
		{q{PangoAttribute*}, q{pango_attr_weight_new}, q{PangoWeight weight}},
		{q{PangoAttribute*}, q{pango_attr_variant_new}, q{PangoVariant variant}},
		{q{PangoAttribute*}, q{pango_attr_stretch_new}, q{PangoStretch stretch}},
		{q{PangoAttribute*}, q{pango_attr_font_desc_new}, q{const(PangoFontDescription)* desc}},
		{q{PangoAttribute*}, q{pango_attr_underline_new}, q{PangoUnderline underline}},
		{q{PangoAttribute*}, q{pango_attr_strikethrough_new}, q{gboolean strikethrough}},
		{q{PangoAttribute*}, q{pango_attr_rise_new}, q{int rise}},
		{q{PangoAttribute*}, q{pango_attr_scale_new}, q{double scaleFactor}},
		{q{PangoAttribute*}, q{pango_attr_shape_new}, q{const(PangoRectangle)* ink_rect, const(PangoRectangle)* logicalRect}},
		{q{GType}, q{pango_attr_list_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_ATTR_LIST}]},
		{q{PangoAttrList*}, q{pango_attr_list_new}, q{}},
		{q{void}, q{pango_attr_list_unref}, q{PangoAttrList* list}},
		{q{PangoAttrList*}, q{pango_attr_list_copy}, q{PangoAttrList* list}},
		{q{void}, q{pango_attr_list_insert}, q{PangoAttrList* list, PangoAttribute* attr}},
		{q{void}, q{pango_attr_list_insert_before}, q{PangoAttrList* list, PangoAttribute* attr}},
		{q{void}, q{pango_attr_list_change}, q{PangoAttrList* list, PangoAttribute* attr}},
		{q{void}, q{pango_attr_list_splice}, q{PangoAttrList* list, PangoAttrList* other, int pos, int len}},
		{q{PangoAttrIterator*}, q{pango_attr_list_get_iterator}, q{PangoAttrList* list}},
		{q{void}, q{pango_attr_iterator_range}, q{PangoAttrIterator* iterator, int* start, int* end}},
		{q{gboolean}, q{pango_attr_iterator_next}, q{PangoAttrIterator* iterator}},
		{q{PangoAttrIterator*}, q{pango_attr_iterator_copy}, q{PangoAttrIterator* iterator}},
		{q{void}, q{pango_attr_iterator_destroy}, q{PangoAttrIterator* iterator}},
		{q{PangoAttribute*}, q{pango_attr_iterator_get}, q{PangoAttrIterator* iterator, PangoAttrType type}},
		{q{void}, q{pango_attr_iterator_get_font}, q{PangoAttrIterator* iterator, PangoFontDescription* desc, PangoLanguage** language, GSList** extraAttrs}},
	];
	if(pangoVersion >= Version(1,2,0)){
		FnBind[] add = [
			{q{PangoAttrList*}, q{pango_attr_list_filter}, q{PangoAttrList* list, PangoAttrFilterFunc func, void* data}},
			{q{GSList*}, q{pango_attr_iterator_get_attrs}, q{PangoAttrIterator* iterator}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{PangoAttribute*}, q{pango_attr_fallback_new}, q{gboolean enableFallback}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{PangoAttribute*}, q{pango_attr_letter_spacing_new}, q{int letterSpacing}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,8,0)){
		FnBind[] add = [
			{q{PangoAttribute*}, q{pango_attr_size_new_absolute}, q{int size}},
			{q{PangoAttribute*}, q{pango_attr_underline_color_new}, q{ushort red, ushort green, ushort blue}, aliases: [q{pango_attr_underline_colour_new}]},
			{q{PangoAttribute*}, q{pango_attr_strikethrough_color_new}, q{ushort red, ushort green, ushort blue}, aliases: [q{pango_attr_strikethrough_colour_new}]},
			{q{PangoAttribute*}, q{pango_attr_shape_new_with_data}, q{const(PangoRectangle)* inkRect, const(PangoRectangle)* logicalRect, void* data, PangoAttrDataCopyFunc copyFunc, GDestroyNotify destroyFunc}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,10,0)){
		FnBind[] add = [
			{q{PangoAttrList*}, q{pango_attr_list_ref}, q{PangoAttrList* list}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{PangoAttribute*}, q{pango_attr_gravity_new}, q{PangoGravity gravity}},
			{q{PangoAttribute*}, q{pango_attr_gravity_hint_new}, q{PangoGravityHint hint}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,20,0)){
		FnBind[] add = [
			{q{void}, q{pango_attribute_init}, q{PangoAttribute* attr, const(PangoAttrClass)* klass}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,22,0)){
		FnBind[] add = [
			{q{const(char)*}, q{pango_attr_type_get_name}, q{PangoAttrType type}, attr: q{pure}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,38,0)){
		FnBind[] add = [
			{q{PangoAttribute*}, q{pango_attr_font_features_new}, q{const(char)* features}},
			{q{PangoAttribute*}, q{pango_attr_foreground_alpha_new}, q{ushort alpha}},
			{q{PangoAttribute*}, q{pango_attr_background_alpha_new}, q{ushort alpha}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{PangoAttribute*}, q{pango_attr_allow_breaks_new}, q{gboolean allowBreaks}},
			{q{PangoAttribute*}, q{pango_attr_insert_hyphens_new}, q{gboolean insertHyphens}},
			{q{PangoAttribute*}, q{pango_attr_show_new}, q{PangoShowFlags flags}},
			{q{void}, q{pango_attr_list_update}, q{PangoAttrList* list, int pos, int remove, int add}},
			{q{GSList*}, q{pango_attr_list_get_attributes}, q{PangoAttrList* list}},
			{q{GType}, q{pango_attr_iterator_get_type}, q{}, attr: q{pure}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,46,0)){
		FnBind[] add = [
			{q{PangoAttribute*}, q{pango_attr_overline_new}, q{PangoOverline overline}},
			{q{PangoAttribute*}, q{pango_attr_overline_color_new}, q{ushort red, ushort green, ushort blue}, aliases: [q{pango_attr_overline_colour_new}]},
			{q{gboolean}, q{pango_attr_list_equal}, q{PangoAttrList* list, PangoAttrList* otherList}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,50,0)){
		FnBind[] add = [
			{q{PangoAttribute*}, q{pango_attr_baseline_shift_new}, q{int shift}},
			{q{PangoAttribute*}, q{pango_attr_font_scale_new}, q{PangoFontScale scale}},
			{q{PangoAttribute*}, q{pango_attr_word_new}, q{}},
			{q{PangoAttribute*}, q{pango_attr_sentence_new}, q{}},
			{q{PangoAttribute*}, q{pango_attr_line_height_new}, q{double factor}},
			{q{PangoAttribute*}, q{pango_attr_line_height_new_absolute}, q{int height}},
			{q{PangoAttribute*}, q{pango_attr_text_transform_new}, q{PangoTextTransform transform}},
			{q{PangoAttrString*}, q{pango_attribute_as_string}, q{PangoAttribute* attr}},
			{q{PangoAttrLanguage*}, q{pango_attribute_as_language}, q{PangoAttribute* attr}},
			{q{PangoAttrInt*}, q{pango_attribute_as_int}, q{PangoAttribute* attr}},
			{q{PangoAttrSize*}, q{pango_attribute_as_size}, q{PangoAttribute* attr}},
			{q{PangoAttrFloat*}, q{pango_attribute_as_float}, q{PangoAttribute* attr}},
			{q{PangoAttrColor*}, q{pango_attribute_as_color}, q{PangoAttribute* attr}, aliases: [q{pango_attribute_as_colour}]},
			{q{PangoAttrFontDesc*}, q{pango_attribute_as_font_desc}, q{PangoAttribute* attr}},
			{q{PangoAttrShape*}, q{pango_attribute_as_shape}, q{PangoAttribute* attr}},
			{q{PangoAttrFontFeatures*}, q{pango_attribute_as_font_features}, q{PangoAttribute* attr}},
			{q{char*}, q{pango_attr_list_to_string}, q{PangoAttrList* list}},
			{q{PangoAttrList*}, q{pango_attr_list_from_string}, q{const(char)* text}},
		];
		ret ~= add;
	}
	return ret;
}()));
