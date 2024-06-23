/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.script;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.language;

struct PangoScriptIter;

mixin(makeEnumBind(q{UnicodeScript}, aliases: [q{PangoScript}], members: (){
	EnumMember[] ret = [
		{{q{invalidCode},               q{INVALID_CODE}},  q{-1}},
		{{q{common},                    q{COMMON}},        q{0}},
		{{q{inherited},                 q{PANGO_SCRIPT_INHERITED}}},
		{{q{arabic},                    q{PANGO_SCRIPT_ARABIC}}},
		{{q{armenian},                  q{PANGO_SCRIPT_ARMENIAN}}},
		{{q{bengali},                   q{PANGO_SCRIPT_BENGALI}}},
		{{q{bopomofo},                  q{PANGO_SCRIPT_BOPOMOFO}}},
		{{q{cherokee},                  q{PANGO_SCRIPT_CHEROKEE}}},
		{{q{coptic},                    q{PANGO_SCRIPT_COPTIC}}},
		{{q{cyrillic},                  q{PANGO_SCRIPT_CYRILLIC}}},
		{{q{deseret},                   q{PANGO_SCRIPT_DESERET}}},
		{{q{devanagari},                q{PANGO_SCRIPT_DEVANAGARI}}},
		{{q{ethiopic},                  q{PANGO_SCRIPT_ETHIOPIC}}},
		{{q{georgian},                  q{PANGO_SCRIPT_GEORGIAN}}},
		{{q{gothic},                    q{PANGO_SCRIPT_GOTHIC}}},
		{{q{greek},                     q{PANGO_SCRIPT_GREEK}}},
		{{q{gujarati},                  q{PANGO_SCRIPT_GUJARATI}}},
		{{q{gurmukhi},                  q{PANGO_SCRIPT_GURMUKHI}}},
		{{q{han},                       q{PANGO_SCRIPT_HAN}}},
		{{q{hangul},                    q{PANGO_SCRIPT_HANGUL}}},
		{{q{hebrew},                    q{PANGO_SCRIPT_HEBREW}}},
		{{q{hiragana},                  q{PANGO_SCRIPT_HIRAGANA}}},
		{{q{kannada},                   q{PANGO_SCRIPT_KANNADA}}},
		{{q{katakana},                  q{PANGO_SCRIPT_KATAKANA}}},
		{{q{khmer},                     q{PANGO_SCRIPT_KHMER}}},
		{{q{lao},                       q{PANGO_SCRIPT_LAO}}},
		{{q{latin},                     q{PANGO_SCRIPT_LATIN}}},
		{{q{malayalam},                 q{PANGO_SCRIPT_MALAYALAM}}},
		{{q{mongolian},                 q{PANGO_SCRIPT_MONGOLIAN}}},
		{{q{myanmar},                   q{PANGO_SCRIPT_MYANMAR}}},
		{{q{ogham},                     q{PANGO_SCRIPT_OGHAM}}},
		{{q{oldItalic},                 q{PANGO_SCRIPT_OLD_ITALIC}}},
		{{q{oriya},                     q{PANGO_SCRIPT_ORIYA}}},
		{{q{runic},                     q{PANGO_SCRIPT_RUNIC}}},
		{{q{sinhala},                   q{PANGO_SCRIPT_SINHALA}}},
		{{q{syriac},                    q{PANGO_SCRIPT_SYRIAC}}},
		{{q{tamil},                     q{PANGO_SCRIPT_TAMIL}}},
		{{q{telugu},                    q{PANGO_SCRIPT_TELUGU}}},
		{{q{thaana},                    q{PANGO_SCRIPT_THAANA}}},
		{{q{thai},                      q{PANGO_SCRIPT_THAI}}},
		{{q{tibetan},                   q{PANGO_SCRIPT_TIBETAN}}},
		{{q{canadianAboriginal},        q{PANGO_SCRIPT_CANADIAN_ABORIGINAL}}},
		{{q{yi},                        q{PANGO_SCRIPT_YI}}},
		{{q{tagalog},                   q{PANGO_SCRIPT_TAGALOG}}},
		{{q{hanunoo},                   q{PANGO_SCRIPT_HANUNOO}}},
		{{q{buhid},                     q{PANGO_SCRIPT_BUHID}}},
		{{q{tagbanwa},                  q{PANGO_SCRIPT_TAGBANWA}}},
		{{q{braille},                   q{PANGO_SCRIPT_BRAILLE}}},
		{{q{cypriot},                   q{PANGO_SCRIPT_CYPRIOT}}},
		{{q{limbu},                     q{PANGO_SCRIPT_LIMBU}}},
		{{q{osmanya},                   q{PANGO_SCRIPT_OSMANYA}}},
		{{q{shavian},                   q{PANGO_SCRIPT_SHAVIAN}}},
		{{q{linearB},                   q{PANGO_SCRIPT_LINEAR_B}}},
		{{q{taiLe},                     q{PANGO_SCRIPT_TAI_LE}}},
		{{q{ugaritic},                  q{PANGO_SCRIPT_UGARITIC}}},
	];
	if(pangoVersion >= Version(1,10,0)){
		EnumMember[] add = [
			{{q{newTaiLue},             q{PANGO_SCRIPT_NEW_TAI_LUE}}},
			{{q{buginese},              q{PANGO_SCRIPT_BUGINESE}}},
			{{q{glagolitic},            q{PANGO_SCRIPT_GLAGOLITIC}}},
			{{q{tifinagh},              q{PANGO_SCRIPT_TIFINAGH}}},
			{{q{sylotiNagri},           q{PANGO_SCRIPT_SYLOTI_NAGRI}}},
			{{q{oldPersian},            q{PANGO_SCRIPT_OLD_PERSIAN}}},
			{{q{kharoshthi},            q{PANGO_SCRIPT_KHAROSHTHI}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,14,0)){
		EnumMember[] add = [
			{{q{unknown},               q{PANGO_SCRIPT_UNKNOWN}}},
			{{q{balinese},              q{PANGO_SCRIPT_BALINESE}}},
			{{q{cuneiform},             q{PANGO_SCRIPT_CUNEIFORM}}},
			{{q{phoenician},            q{PANGO_SCRIPT_PHOENICIAN}}},
			{{q{phagsPa},               q{PANGO_SCRIPT_PHAGS_PA}}},
			{{q{nko},                   q{PANGO_SCRIPT_NKO}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,20,1)){
		EnumMember[] add = [
			{{q{kayahLi},               q{PANGO_SCRIPT_KAYAH_LI}}},
			{{q{lepcha},                q{PANGO_SCRIPT_LEPCHA}}},
			{{q{rejang},                q{PANGO_SCRIPT_REJANG}}},
			{{q{sundanese},             q{PANGO_SCRIPT_SUNDANESE}}},
			{{q{saurashtra},            q{PANGO_SCRIPT_SAURASHTRA}}},
			{{q{cham},                  q{PANGO_SCRIPT_CHAM}}},
			{{q{olChiki},               q{PANGO_SCRIPT_OL_CHIKI}}},
			{{q{vai},                   q{PANGO_SCRIPT_VAI}}},
			{{q{carian},                q{PANGO_SCRIPT_CARIAN}}},
			{{q{lycian},                q{PANGO_SCRIPT_LYCIAN}}},
			{{q{lydian},                q{PANGO_SCRIPT_LYDIAN}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,32,0)){
		EnumMember[] add = [
			{{q{batak},                 q{PANGO_SCRIPT_BATAK}}},
			{{q{brahmi},                q{PANGO_SCRIPT_BRAHMI}}},
			{{q{mandaic},               q{PANGO_SCRIPT_MANDAIC}}},
			{{q{chakma},                q{PANGO_SCRIPT_CHAKMA}}},
			{{q{meroiticCursive},       q{PANGO_SCRIPT_MEROITIC_CURSIVE}}},
			{{q{meroiticHieroglyphs},   q{PANGO_SCRIPT_MEROITIC_HIEROGLYPHS}}},
			{{q{miao},                  q{PANGO_SCRIPT_MIAO}}},
			{{q{sharada},               q{PANGO_SCRIPT_SHARADA}}},
			{{q{soraSompeng},           q{PANGO_SCRIPT_SORA_SOMPENG}}},
			{{q{takri},                 q{PANGO_SCRIPT_TAKRI}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,40,0)){
		EnumMember[] add = [
			{{q{bassaVah},              q{PANGO_SCRIPT_BASSA_VAH}}},
			{{q{caucasianAlbanian},     q{PANGO_SCRIPT_CAUCASIAN_ALBANIAN}}},
			{{q{duployan},              q{PANGO_SCRIPT_DUPLOYAN}}},
			{{q{elbasan},               q{PANGO_SCRIPT_ELBASAN}}},
			{{q{grantha},               q{PANGO_SCRIPT_GRANTHA}}},
			{{q{khojki},                q{PANGO_SCRIPT_KHOJKI}}},
			{{q{khudawadi},             q{PANGO_SCRIPT_KHUDAWADI}}},
			{{q{linearA},               q{PANGO_SCRIPT_LINEAR_A}}},
			{{q{mahajani},              q{PANGO_SCRIPT_MAHAJANI}}},
			{{q{manichaean},            q{PANGO_SCRIPT_MANICHAEAN}}},
			{{q{mendeKikakui},          q{PANGO_SCRIPT_MENDE_KIKAKUI}}},
			{{q{modi},                  q{PANGO_SCRIPT_MODI}}},
			{{q{mro},                   q{PANGO_SCRIPT_MRO}}},
			{{q{nabataean},             q{PANGO_SCRIPT_NABATAEAN}}},
			{{q{oldNorthArabian},       q{PANGO_SCRIPT_OLD_NORTH_ARABIAN}}},
			{{q{oldPermic},             q{PANGO_SCRIPT_OLD_PERMIC}}},
			{{q{pahawhHmong},           q{PANGO_SCRIPT_PAHAWH_HMONG}}},
			{{q{palmyrene},             q{PANGO_SCRIPT_PALMYRENE}}},
			{{q{pauCinHau},             q{PANGO_SCRIPT_PAU_CIN_HAU}}},
			{{q{psalterPahlavi},        q{PANGO_SCRIPT_PSALTER_PAHLAVI}}},
			{{q{siddham},               q{PANGO_SCRIPT_SIDDHAM}}},
			{{q{tirhuta},               q{PANGO_SCRIPT_TIRHUTA}}},
			{{q{warangCiti},            q{PANGO_SCRIPT_WARANG_CITI}}},
			{{q{ahom},                  q{PANGO_SCRIPT_AHOM}}},
			{{q{anatolianHieroglyphs},  q{PANGO_SCRIPT_ANATOLIAN_HIEROGLYPHS}}},
			{{q{hatran},                q{PANGO_SCRIPT_HATRAN}}},
			{{q{multani},               q{PANGO_SCRIPT_MULTANI}}},
			{{q{oldHungarian},          q{PANGO_SCRIPT_OLD_HUNGARIAN}}},
			{{q{signwriting},           q{PANGO_SCRIPT_SIGNWRITING}}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret;
	if(pangoVersion >= Version(1,4,0)){
		FnBind[] add = [
			{q{PangoScriptIter*}, q{pango_script_iter_new}, q{const(char)* text, int length}},
			{q{void}, q{pango_script_iter_get_range}, q{PangoScriptIter* iter, const(char)** start, const(char)** end, PangoScript* script}},
			{q{gboolean}, q{pango_script_iter_next}, q{PangoScriptIter* iter}},
			{q{void}, q{pango_script_iter_free}, q{PangoScriptIter* iter}},
			{q{PangoLanguage*}, q{pango_script_get_sample_language}, q{PangoScript script}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,44,0)){
		FnBind[] add = [
			{q{GType}, q{pango_script_iter_get_type}, q{}, attr: q{pure}},
		];
		ret ~= add;
	}
	return ret;
}()));
