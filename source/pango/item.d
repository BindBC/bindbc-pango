/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.item;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.attributes;
import pango.types;

static if(pangoVersion >= Version(1,16,0))
mixin(makeEnumBind(q{PangoAnalysisFlag}, q{ubyte}, members: (){
	EnumMember[] ret = [
		{{q{centredBaseline},  q{PANGO_ANALYSIS_FLAG_CENTRED_BASELINE}},  q{1 << 0}, aliases: [{q{centeredBaseline}, q{PANGO_ANALYSIS_FLAG_CENTERED_BASELINE}}]},
	];
	if(pangoVersion >= Version(1,36,7)){
		EnumMember[] add = [
			{{q{isEllipsis},   q{PANGO_ANALYSIS_FLAG_IS_ELLIPSIS}},       q{1 << 1}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		EnumMember[] add = [
			{{q{needHyphen},   q{PANGO_ANALYSIS_FLAG_NEED_HYPHEN}},       q{1 << 2}},
		];
		ret ~= add;
	}
	return ret;
}()));

struct PangoAnalysis{
	void* shapeEngine;
	void* langEngine;
	alias shape_engine = shapeEngine;
	alias lang_engine = langEngine;
	PangoFont* font;
	
	ubyte level;
	ubyte gravity;
	static if(pangoVersion >= Version(1,16,0))
	PangoAnalysisFlag flags;
	
	static if(pangoVersion >= Version(1,18,0))
	ubyte script;
	PangoLanguage* language;
	
	GSList* extraAttrs;
	alias extra_attrs = extraAttrs;
}

struct PangoItem{
	int offset;
	int length;
	int numChars;
	alias num_chars = numChars;
	PangoAnalysis analysis;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{pango_item_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_ITEM}]},
		{q{PangoItem*}, q{pango_item_new}, q{}},
		{q{PangoItem*}, q{pango_item_copy}, q{PangoItem* item}},
		{q{void}, q{pango_item_free}, q{PangoItem* item}},
		{q{PangoItem*}, q{pango_item_split}, q{PangoItem* orig, int splitIndex, int splitOffset}},
		{q{GList*}, q{pango_reorder_items}, q{GList* items}},
		{q{GList*}, q{pango_itemize}, q{PangoContext* context, const(char)* text, int startIndex, int length, PangoAttrList* attrs, PangoAttrIterator* cachedIter}, aliases: [q{pango_itemise}]},
	];
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{GList*}, q{pango_itemize_with_base_dir}, q{PangoContext* context, PangoDirection baseDir, const(char)* text, int startIndex, int length, PangoAttrList* attrs, PangoAttrIterator* cachedIter}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{void}, q{pango_item_apply_attrs}, q{PangoItem* item, PangoAttrIterator* iter}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,54,0)){
		FnBind[] add = [
			{q{int}, q{pango_item_get_char_offset}, q{PangoItem* item}},
		];
		ret ~= add;
	}
	return ret;
}()));
