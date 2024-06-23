/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.gravity;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.matrix;
import pango.script;

static if(pangoVersion >= Version(1,16,0)){
	mixin(makeEnumBind(q{PangoGravity}, members: (){
		EnumMember[] ret = [
			{{q{south},  q{PANGO_GRAVITY_SOUTH}}},
			{{q{east},   q{PANGO_GRAVITY_EAST}}},
			{{q{north},  q{PANGO_GRAVITY_NORTH}}},
			{{q{west},   q{PANGO_GRAVITY_WEST}}},
			{{q{auto_},  q{PANGO_GRAVITY_AUTO}}},
		];
		return ret;
	}()));
	
	mixin(makeEnumBind(q{PangoGravityHint}, members: (){
		EnumMember[] ret = [
			{{q{natural},  q{PANGO_GRAVITY_HINT_NATURAL}}},
			{{q{strong},   q{PANGO_GRAVITY_HINT_STRONG}}},
			{{q{line},     q{PANGO_GRAVITY_HINT_LINE}}},
		];
		return ret;
	}()));
	
	pragma(inline,true) nothrow @nogc pure @safe{
		bool pangoGravityIsVertical(PangoGravity gravity) => gravity == PangoGravity.east || gravity == PangoGravity.west;
		bool pangoGravityIsImproper(PangoGravity gravity) => gravity == PangoGravity.west || gravity == PangoGravity.north;
		alias PANGO_GRAVITY_IS_VERTICAL = pangoGravityIsVertical;
		alias PANGO_GRAVITY_IS_IMPROPER = pangoGravityIsImproper;
	}
}
mixin(joinFnBinds((){
	FnBind[] ret;
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{double}, q{pango_gravity_to_rotation}, q{PangoGravity gravity}, attr: q{pure}},
			{q{PangoGravity}, q{pango_gravity_get_for_matrix}, q{const(PangoMatrix)* matrix}},
			{q{PangoGravity}, q{pango_gravity_get_for_script}, q{PangoScript script, PangoGravity baseGravity, PangoGravityHint hint}, attr: q{pure}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,26,0)){
		FnBind[] add = [
			{q{PangoGravity}, q{pango_gravity_get_for_script_and_width}, q{PangoScript script, gboolean wide, PangoGravity baseGravity, PangoGravityHint hint}, attr: q{pure}},
		];
		ret ~= add;
	}
	return ret;
}()));

