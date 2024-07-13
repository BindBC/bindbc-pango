/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.matrix;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

import pango.types;

static if(pangoVersion >= Version(1,6,0))
struct PangoMatrix{
	double xx=1.0, xy=0.0, yx=0.0;
	double yy=1.0, x0=0.0, y0=0.0;
}

mixin(joinFnBinds((){
	FnBind[] ret;
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{GType}, q{pango_matrix_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_MATRIX}]},
			{q{PangoMatrix*}, q{pango_matrix_copy}, q{const(PangoMatrix)* matrix}},
			{q{void}, q{pango_matrix_free}, q{PangoMatrix* matrix}},
			{q{void}, q{pango_matrix_translate}, q{PangoMatrix* matrix, double tx, double ty}},
			{q{void}, q{pango_matrix_scale}, q{PangoMatrix* matrix, double scaleX, double scaleY}},
			{q{void}, q{pango_matrix_rotate}, q{PangoMatrix* matrix, double degrees}},
			{q{void}, q{pango_matrix_concat}, q{PangoMatrix* matrix, const(PangoMatrix)* newMatrix}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,12,0)){
		FnBind[] add = [
			{q{double}, q{pango_matrix_get_font_scale_factor}, q{const(PangoMatrix)* matrix}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,16,0)){
		FnBind[] add = [
			{q{void}, q{pango_matrix_transform_point}, q{const(PangoMatrix)* matrix, double* x, double* y}},
			{q{void}, q{pango_matrix_transform_distance}, q{const(PangoMatrix)* matrix, double* dx, double* dy}},
			{q{void}, q{pango_matrix_transform_rectangle}, q{const(PangoMatrix)* matrix, PangoRectangle* rect}},
			{q{void}, q{pango_matrix_transform_pixel_rectangle}, q{const(PangoMatrix)* matrix, PangoRectangle* rect}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,38,0)){
		FnBind[] add = [
			{q{void}, q{pango_matrix_get_font_scale_factors}, q{const(PangoMatrix)* matrix, double* xScale, double* yScale}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,50,0)){
		FnBind[] add = [
			{q{double}, q{pango_matrix_get_slant_ratio}, q{const(PangoMatrix)* matrix}},
		];
		ret ~= add;
	}
	return ret;
}()));
