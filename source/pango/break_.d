/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.break_;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.item;
import pango.types;

struct PangoLogAttr{
	import std.bitmanip: bitfields;
	mixin(bitfields!(
		uint, q{isLineBreak},                1,
		uint, q{isMandatoryBreak},           1,
		uint, q{isCharBreak},                1,
		uint, q{isWhite},                    1,
		uint, q{isCursorPosition},           1,
		uint, q{isWordStart},                1,
		uint, q{isWordEnd},                  1,
		uint, q{isSentenceBoundary},         1,
		uint, q{isSentenceStart},            1,
		uint, q{isSentenceEnd},              1,
		uint, q{backspaceDeletesCharacter},  1,
		uint, q{isExpandableSpace},          1, //since 1.18
		uint, q{isWordBoundary},             1, //since 1.22
		uint, q{breakInsertsHyphen},         1, //since 1.50
		uint, q{breakRemovesPreceding},      1, //since 1.50
		
		uint, q{reserved},                   17,
	));
	
	alias is_line_break = isLineBreak;
	alias is_mandatory_break = isMandatoryBreak;
	alias is_char_break = isCharBreak;
	alias is_white = isWhite;
	alias is_cursor_position = isCursorPosition;
	alias is_word_start = isWordStart;
	alias is_word_end = isWordEnd;
	alias is_sentence_boundary = isSentenceBoundary;
	alias is_sentence_start = isSentenceStart;
	alias is_sentence_end = isSentenceEnd;
	alias backspace_deletes_character = backspaceDeletesCharacter;
	alias is_expandable_space = isExpandableSpace;
	alias is_word_boundary = isWordBoundary;
	alias break_inserts_hyphen = breakInsertsHyphen;
	alias break_removes_preceding = breakRemovesPreceding;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{pango_get_log_attrs}, q{const(char)* text, int length, int level, PangoLanguage* language, PangoLogAttr* attrs, int attrsLen}},
		{q{void}, q{pango_default_break}, q{const(char)* text, int length, PangoAnalysis* analysis, PangoLogAttr* attrs, int attrsLen}},
	];
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{void}, q{pango_tailor_break}, q{const(char)* text, int length, PangoAnalysis* analysis, int offset, PangoLogAttr* attrs, int attrsLen}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,50,0)){
		FnBind[] add = [
			{q{void}, q{pango_attr_break}, q{const(char)* text, int length, PangoAttrList* attrList, int offset, PangoLogAttr* attrs, int attrsLen}},
		];
		ret ~= add;
	}
	return ret;
}()));
