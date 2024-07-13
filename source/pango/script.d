/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.script;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.types;

struct PangoScriptIter;

mixin(makeEnumBind(q{UnicodeScript}, aliases: [q{PangoScript}], members: (){
	EnumMember[] ret = [
		{{q{invalidCode},               q{INVALID_CODE}},  q{-1}},
		{{q{common},                    q{COMMON}},        q{0}},
		{{q{inherited},                 q{G_UNICODE_SCRIPT_INHERITED}}},
		{{q{arabic},                    q{G_UNICODE_SCRIPT_ARABIC}}},
		{{q{armenian},                  q{G_UNICODE_SCRIPT_ARMENIAN}}},
		{{q{bengali},                   q{G_UNICODE_SCRIPT_BENGALI}}},
		{{q{bopomofo},                  q{G_UNICODE_SCRIPT_BOPOMOFO}}},
		{{q{cherokee},                  q{G_UNICODE_SCRIPT_CHEROKEE}}},
		{{q{coptic},                    q{G_UNICODE_SCRIPT_COPTIC}}},
		{{q{cyrillic},                  q{G_UNICODE_SCRIPT_CYRILLIC}}},
		{{q{deseret},                   q{G_UNICODE_SCRIPT_DESERET}}},
		{{q{devanagari},                q{G_UNICODE_SCRIPT_DEVANAGARI}}},
		{{q{ethiopic},                  q{G_UNICODE_SCRIPT_ETHIOPIC}}},
		{{q{georgian},                  q{G_UNICODE_SCRIPT_GEORGIAN}}},
		{{q{gothic},                    q{G_UNICODE_SCRIPT_GOTHIC}}},
		{{q{greek},                     q{G_UNICODE_SCRIPT_GREEK}}},
		{{q{gujarati},                  q{G_UNICODE_SCRIPT_GUJARATI}}},
		{{q{gurmukhi},                  q{G_UNICODE_SCRIPT_GURMUKHI}}},
		{{q{han},                       q{G_UNICODE_SCRIPT_HAN}}},
		{{q{hangul},                    q{G_UNICODE_SCRIPT_HANGUL}}},
		{{q{hebrew},                    q{G_UNICODE_SCRIPT_HEBREW}}},
		{{q{hiragana},                  q{G_UNICODE_SCRIPT_HIRAGANA}}},
		{{q{kannada},                   q{G_UNICODE_SCRIPT_KANNADA}}},
		{{q{katakana},                  q{G_UNICODE_SCRIPT_KATAKANA}}},
		{{q{khmer},                     q{G_UNICODE_SCRIPT_KHMER}}},
		{{q{lao},                       q{G_UNICODE_SCRIPT_LAO}}},
		{{q{latin},                     q{G_UNICODE_SCRIPT_LATIN}}},
		{{q{malayalam},                 q{G_UNICODE_SCRIPT_MALAYALAM}}},
		{{q{mongolian},                 q{G_UNICODE_SCRIPT_MONGOLIAN}}},
		{{q{myanmar},                   q{G_UNICODE_SCRIPT_MYANMAR}}},
		{{q{ogham},                     q{G_UNICODE_SCRIPT_OGHAM}}},
		{{q{oldItalic},                 q{G_UNICODE_SCRIPT_OLD_ITALIC}}},
		{{q{oriya},                     q{G_UNICODE_SCRIPT_ORIYA}}},
		{{q{runic},                     q{G_UNICODE_SCRIPT_RUNIC}}},
		{{q{sinhala},                   q{G_UNICODE_SCRIPT_SINHALA}}},
		{{q{syriac},                    q{G_UNICODE_SCRIPT_SYRIAC}}},
		{{q{tamil},                     q{G_UNICODE_SCRIPT_TAMIL}}},
		{{q{telugu},                    q{G_UNICODE_SCRIPT_TELUGU}}},
		{{q{thaana},                    q{G_UNICODE_SCRIPT_THAANA}}},
		{{q{thai},                      q{G_UNICODE_SCRIPT_THAI}}},
		{{q{tibetan},                   q{G_UNICODE_SCRIPT_TIBETAN}}},
		{{q{canadianAboriginal},        q{G_UNICODE_SCRIPT_CANADIAN_ABORIGINAL}}},
		{{q{yi},                        q{G_UNICODE_SCRIPT_YI}}},
		{{q{tagalog},                   q{G_UNICODE_SCRIPT_TAGALOG}}},
		{{q{hanunoo},                   q{G_UNICODE_SCRIPT_HANUNOO}}},
		{{q{buhid},                     q{G_UNICODE_SCRIPT_BUHID}}},
		{{q{tagbanwa},                  q{G_UNICODE_SCRIPT_TAGBANWA}}},
		{{q{braille},                   q{G_UNICODE_SCRIPT_BRAILLE}}},
		{{q{cypriot},                   q{G_UNICODE_SCRIPT_CYPRIOT}}},
		{{q{limbu},                     q{G_UNICODE_SCRIPT_LIMBU}}},
		{{q{osmanya},                   q{G_UNICODE_SCRIPT_OSMANYA}}},
		{{q{shavian},                   q{G_UNICODE_SCRIPT_SHAVIAN}}},
		{{q{linearB},                   q{G_UNICODE_SCRIPT_LINEAR_B}}},
		{{q{taiLe},                     q{G_UNICODE_SCRIPT_TAI_LE}}},
		{{q{ugaritic},                  q{G_UNICODE_SCRIPT_UGARITIC}}},
	];
	if(pangoVersion >= Version(1,10,0)){
		EnumMember[] add = [
			{{q{newTaiLue},             q{G_UNICODE_SCRIPT_NEW_TAI_LUE}}},
			{{q{buginese},              q{G_UNICODE_SCRIPT_BUGINESE}}},
			{{q{glagolitic},            q{G_UNICODE_SCRIPT_GLAGOLITIC}}},
			{{q{tifinagh},              q{G_UNICODE_SCRIPT_TIFINAGH}}},
			{{q{sylotiNagri},           q{G_UNICODE_SCRIPT_SYLOTI_NAGRI}}},
			{{q{oldPersian},            q{G_UNICODE_SCRIPT_OLD_PERSIAN}}},
			{{q{kharoshthi},            q{G_UNICODE_SCRIPT_KHAROSHTHI}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,14,0)){
		EnumMember[] add = [
			{{q{unknown},               q{G_UNICODE_SCRIPT_UNKNOWN}}},
			{{q{balinese},              q{G_UNICODE_SCRIPT_BALINESE}}},
			{{q{cuneiform},             q{G_UNICODE_SCRIPT_CUNEIFORM}}},
			{{q{phoenician},            q{G_UNICODE_SCRIPT_PHOENICIAN}}},
			{{q{phagsPa},               q{G_UNICODE_SCRIPT_PHAGS_PA}}},
			{{q{nko},                   q{G_UNICODE_SCRIPT_NKO}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,20,1)){
		EnumMember[] add = [
			{{q{kayahLi},               q{G_UNICODE_SCRIPT_KAYAH_LI}}},
			{{q{lepcha},                q{G_UNICODE_SCRIPT_LEPCHA}}},
			{{q{rejang},                q{G_UNICODE_SCRIPT_REJANG}}},
			{{q{sundanese},             q{G_UNICODE_SCRIPT_SUNDANESE}}},
			{{q{saurashtra},            q{G_UNICODE_SCRIPT_SAURASHTRA}}},
			{{q{cham},                  q{G_UNICODE_SCRIPT_CHAM}}},
			{{q{olChiki},               q{G_UNICODE_SCRIPT_OL_CHIKI}}},
			{{q{vai},                   q{G_UNICODE_SCRIPT_VAI}}},
			{{q{carian},                q{G_UNICODE_SCRIPT_CARIAN}}},
			{{q{lycian},                q{G_UNICODE_SCRIPT_LYCIAN}}},
			{{q{lydian},                q{G_UNICODE_SCRIPT_LYDIAN}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,32,0)){
		EnumMember[] add = [
			{{q{batak},                 q{G_UNICODE_SCRIPT_BATAK}}},
			{{q{brahmi},                q{G_UNICODE_SCRIPT_BRAHMI}}},
			{{q{mandaic},               q{G_UNICODE_SCRIPT_MANDAIC}}},
			{{q{chakma},                q{G_UNICODE_SCRIPT_CHAKMA}}},
			{{q{meroiticCursive},       q{G_UNICODE_SCRIPT_MEROITIC_CURSIVE}}},
			{{q{meroiticHieroglyphs},   q{G_UNICODE_SCRIPT_MEROITIC_HIEROGLYPHS}}},
			{{q{miao},                  q{G_UNICODE_SCRIPT_MIAO}}},
			{{q{sharada},               q{G_UNICODE_SCRIPT_SHARADA}}},
			{{q{soraSompeng},           q{G_UNICODE_SCRIPT_SORA_SOMPENG}}},
			{{q{takri},                 q{G_UNICODE_SCRIPT_TAKRI}}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,40,0)){
		EnumMember[] add = [
			{{q{bassaVah},              q{G_UNICODE_SCRIPT_BASSA_VAH}}},
			{{q{caucasianAlbanian},     q{G_UNICODE_SCRIPT_CAUCASIAN_ALBANIAN}}},
			{{q{duployan},              q{G_UNICODE_SCRIPT_DUPLOYAN}}},
			{{q{elbasan},               q{G_UNICODE_SCRIPT_ELBASAN}}},
			{{q{grantha},               q{G_UNICODE_SCRIPT_GRANTHA}}},
			{{q{khojki},                q{G_UNICODE_SCRIPT_KHOJKI}}},
			{{q{khudawadi},             q{G_UNICODE_SCRIPT_KHUDAWADI}}},
			{{q{linearA},               q{G_UNICODE_SCRIPT_LINEAR_A}}},
			{{q{mahajani},              q{G_UNICODE_SCRIPT_MAHAJANI}}},
			{{q{manichaean},            q{G_UNICODE_SCRIPT_MANICHAEAN}}},
			{{q{mendeKikakui},          q{G_UNICODE_SCRIPT_MENDE_KIKAKUI}}},
			{{q{modi},                  q{G_UNICODE_SCRIPT_MODI}}},
			{{q{mro},                   q{G_UNICODE_SCRIPT_MRO}}},
			{{q{nabataean},             q{G_UNICODE_SCRIPT_NABATAEAN}}},
			{{q{oldNorthArabian},       q{G_UNICODE_SCRIPT_OLD_NORTH_ARABIAN}}},
			{{q{oldPermic},             q{G_UNICODE_SCRIPT_OLD_PERMIC}}},
			{{q{pahawhHmong},           q{G_UNICODE_SCRIPT_PAHAWH_HMONG}}},
			{{q{palmyrene},             q{G_UNICODE_SCRIPT_PALMYRENE}}},
			{{q{pauCinHau},             q{G_UNICODE_SCRIPT_PAU_CIN_HAU}}},
			{{q{psalterPahlavi},        q{G_UNICODE_SCRIPT_PSALTER_PAHLAVI}}},
			{{q{siddham},               q{G_UNICODE_SCRIPT_SIDDHAM}}},
			{{q{tirhuta},               q{G_UNICODE_SCRIPT_TIRHUTA}}},
			{{q{warangCiti},            q{G_UNICODE_SCRIPT_WARANG_CITI}}},
			{{q{ahom},                  q{G_UNICODE_SCRIPT_AHOM}}},
			{{q{anatolianHieroglyphs},  q{G_UNICODE_SCRIPT_ANATOLIAN_HIEROGLYPHS}}},
			{{q{hatran},                q{G_UNICODE_SCRIPT_HATRAN}}},
			{{q{multani},               q{G_UNICODE_SCRIPT_MULTANI}}},
			{{q{oldHungarian},          q{G_UNICODE_SCRIPT_OLD_HUNGARIAN}}},
			{{q{signwriting},           q{G_UNICODE_SCRIPT_SIGNWRITING}}},
			//from GLib only:
			{{q{adlam},                 q{G_UNICODE_SCRIPT_ADLAM}}},
			{{q{bhaiksuki},             q{G_UNICODE_SCRIPT_BHAIKSUKI}}},
			{{q{marchen},               q{G_UNICODE_SCRIPT_MARCHEN}}},
			{{q{newa},                  q{G_UNICODE_SCRIPT_NEWA}}},
			{{q{osage},                 q{G_UNICODE_SCRIPT_OSAGE}}},
			{{q{tangut},                q{G_UNICODE_SCRIPT_TANGUT}}},
			{{q{masaramGondi},          q{G_UNICODE_SCRIPT_MASARAM_GONDI}}},
			{{q{nushu},                 q{G_UNICODE_SCRIPT_NUSHU}}},
			{{q{soyombo},               q{G_UNICODE_SCRIPT_SOYOMBO}}},
			{{q{zanabazarSquare},       q{G_UNICODE_SCRIPT_ZANABAZAR_SQUARE}}},
			{{q{dogra},                 q{G_UNICODE_SCRIPT_DOGRA}}},
			{{q{gunjalaGondi},          q{G_UNICODE_SCRIPT_GUNJALA_GONDI}}},
			{{q{hanifiRohingya},        q{G_UNICODE_SCRIPT_HANIFI_ROHINGYA}}},
			{{q{makasar},               q{G_UNICODE_SCRIPT_MAKASAR}}},
			{{q{medefaidrin},           q{G_UNICODE_SCRIPT_MEDEFAIDRIN}}},
			{{q{oldSogdian},            q{G_UNICODE_SCRIPT_OLD_SOGDIAN}}},
			{{q{sogdian},               q{G_UNICODE_SCRIPT_SOGDIAN}}},
			{{q{elymaic},               q{G_UNICODE_SCRIPT_ELYMAIC}}},
			{{q{nandinagari},           q{G_UNICODE_SCRIPT_NANDINAGARI}}},
			{{q{nyiakengPuachueHmong},  q{G_UNICODE_SCRIPT_NYIAKENG_PUACHUE_HMONG}}},
			{{q{wancho},                q{G_UNICODE_SCRIPT_WANCHO}}},
			{{q{chorasmian},            q{G_UNICODE_SCRIPT_CHORASMIAN}}},
			{{q{divesAkuru},            q{G_UNICODE_SCRIPT_DIVES_AKURU}}},
			{{q{khitanSmallScript},     q{G_UNICODE_SCRIPT_KHITAN_SMALL_SCRIPT}}},
			{{q{yezidi},                q{G_UNICODE_SCRIPT_YEZIDI}}},
			{{q{cyproMinoan},           q{G_UNICODE_SCRIPT_CYPRO_MINOAN}}},
			{{q{oldUyghur},             q{G_UNICODE_SCRIPT_OLD_UYGHUR}}},
			{{q{tangsa},                q{G_UNICODE_SCRIPT_TANGSA}}},
			{{q{toto},                  q{G_UNICODE_SCRIPT_TOTO}}},
			{{q{vithkuqi},              q{G_UNICODE_SCRIPT_VITHKUQI}}},
			{{q{math},                  q{G_UNICODE_SCRIPT_MATH}}},
			{{q{kawi},                  q{G_UNICODE_SCRIPT_KAWI}}},
			{{q{nagMundari},            q{G_UNICODE_SCRIPT_NAG_MUNDARI}}},
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
