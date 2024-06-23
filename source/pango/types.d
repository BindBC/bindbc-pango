/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.types;

import bindbc.pango.config;
import bindbc.pango.codegen;

struct PangoFont;

struct PangoContext;

struct PangoLanguage;

alias PangoGlyph = uint;

enum pangoScale = 1024;
alias PANGO_SCALE = pangoScale;

struct PangoRectangle{
	int x;
	int y;
	int width;
	int height;
}

pragma(inline,true) nothrow @nogc pure @safe{
	int pangoPixels(T)(T d)      => (cast(int)d +  512) >> 10;
	int pangoPixelsFloor(T)(T d) => (cast(int)d       ) >> 10;
	int pangoPixelsCeil(T)(T d)  => (cast(int)d + 1023) >> 10;
	int pangoUnitsFloor(T)(T d)  =>  d & ~(pangoScale -  1);
	int pangoUnitsCeil(T)(T d)   => (d +  (pangoScale -  1)) & ~(pangoScale - 1);
	int pangoUnitsRound(T)(T d)  => (d +  (pangoScale >> 1)) & ~(pangoScale - 1);
	int pangoAscent(PangoRectangle rect)   => -rect.y;
	int pangoDescent(PangoRectangle rect)  =>  rect.y + rect.height;
	int pangoLBearing(PangoRectangle rect) =>  rect.x;
	int pangoRBearing(PangoRectangle rect) =>  rect.x + rect.width;
	alias PANGO_PIXELS = pangoPixels;
	alias PANGO_PIXELS_FLOOR = pangoPixelsFloor;
	alias PANGO_PIXELS_CEIL = pangoPixelsCeil;
	alias PANGO_UNITS_FLOOR = pangoUnitsFloor;
	alias PANGO_UNITS_CEIL = pangoUnitsCeil;
	alias PANGO_UNITS_ROUND = pangoUnitsRound;
	alias PANGO_ASCENT = pangoAscent;
	alias PANGO_DESCENT = pangoDescent;
	alias PANGO_LBEARING = pangoLBearing;
	alias PANGO_RBEARING = pangoRBearing;
}

mixin(joinFnBinds((){
	FnBind[] ret;
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{int}, q{pango_units_from_double}, q{double d}, attr: q{pure}},
			{q{double}, q{pango_units_to_double}, q{int i}, attr: q{pure}},
			{q{void}, q{pango_extents_to_pixels}, q{PangoRectangle* inclusive, PangoRectangle* nearest}},
		];
		ret ~= add;
	}
	return ret;
}()));
