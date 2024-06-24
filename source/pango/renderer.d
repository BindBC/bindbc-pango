/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.renderer;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.attributes;
import pango.colour;
import pango.glyph_item;
import pango.glyph;
import pango.layout;
import pango.matrix;
import pango.types;

struct PangoRendererPrivate;

static if(pangoVersion >= Version(1,8,0)){
	mixin(makeEnumBind(q{PangoRenderPart}, members: (){
		EnumMember[] ret = [
			{{q{foreground},     q{PANGO_RENDER_PART_FOREGROUND}}},
			{{q{background},     q{PANGO_RENDER_PART_BACKGROUND}}},
			{{q{underline},      q{PANGO_RENDER_PART_UNDERLINE}}},
			{{q{strikethrough},  q{PANGO_RENDER_PART_STRIKETHROUGH}}},
			{{q{overline},       q{PANGO_RENDER_PART_OVERLINE}}},
		];
		return ret;
	}()));
	
	struct PangoRenderer{
		private{
			GObject parentInstance;
			
			PangoUnderline underline;
			gboolean strikethrough;
			int activeCount;
		}
		
		PangoMatrix* matrix;
		
		private PangoRendererPrivate* priv;
	}
	
	struct PangoRendererClass{
		private GObjectClass parentClass;
		
		extern(C) nothrow{
			alias GenericFn = void function(PangoRenderer* renderer);
			alias DrawGlyphsFn = void function(PangoRenderer* renderer, PangoFont* font, PangoGlyphString* glyphs, int x, int y);
			alias DrawRectangleFn = void function(PangoRenderer* renderer, PangoRenderPart part, int x, int y, int width, int height);
			alias DrawErrorUnderlineFn = void function(PangoRenderer* renderer, int x, int y, int width, int height);
			alias DrawShapeFn = void function(PangoRenderer* renderer, PangoAttrShape* attr, int x, int y);
			alias DrawTrapeziumFn = void function(PangoRenderer* renderer, PangoRenderPart part, double y1, double x11, double x21, double y2, double x12, double x22);
			alias DrawGlyphFn = void function(PangoRenderer* renderer, PangoFont* font, PangoGlyph glyph, double x, double y);
			alias PartChangedFn = void function(PangoRenderer* renderer, PangoRenderPart part);
			alias PrepareRunFn = void function(PangoRenderer* renderer, PangoLayoutRun* run);
			alias DrawGlyphItemFn = void function(PangoRenderer* renderer, const(char)* text, PangoGlyphItem* glyphItem, int x, int y);
			alias ReservedFn = void function();
		}
		DrawGlyphsFn drawGlyphs;
		DrawRectangleFn drawRectangle;
		DrawErrorUnderlineFn drawErrorUnderline;
		DrawShapeFn drawShape;
		DrawTrapeziumFn drawTrapezium;
		DrawGlyphFn drawGlyph;
		PartChangedFn partChanged;
		GenericFn begin;
		GenericFn end;
		PrepareRunFn prepareRun;
		DrawGlyphItemFn drawGlyphItem;
		alias draw_glyphs = drawGlyphs;
		alias draw_rectangle = drawRectangle;
		alias draw_error_underline = drawErrorUnderline;
		alias draw_shape = drawShape;
		alias draw_trapezium = drawTrapezium;
		alias draw_trapezoid = drawTrapezium;
		alias drawTrapezoid  = drawTrapezium;
		alias draw_glyph = drawGlyph;
		alias part_changed = partChanged;
		alias prepare_run = prepareRun;
		alias draw_glyph_item = drawGlyphItem;
		
		private:
		ReservedFn _pango_reserved2;
		ReservedFn _pango_reserved3;
		ReservedFn _pango_reserved4;
	}
}

mixin(joinFnBinds((){
	FnBind[] ret;
	if(pangoVersion >= Version(1,8,0)){
		FnBind[] add = [
			{q{GType}, q{pango_renderer_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_TYPE_RENDERER}]},
			{q{void}, q{pango_renderer_draw_layout}, q{PangoRenderer* renderer, PangoLayout* layout, int x, int y}},
			{q{void}, q{pango_renderer_draw_layout_line}, q{PangoRenderer* renderer, PangoLayoutLine* line, int x, int y}},
			{q{void}, q{pango_renderer_draw_glyphs}, q{PangoRenderer* renderer, PangoFont* font, PangoGlyphString* glyphs, int x, int y}},
			{q{void}, q{pango_renderer_draw_rectangle}, q{PangoRenderer* renderer, PangoRenderPart part, int x, int y, int width, int height}},
			{q{void}, q{pango_renderer_draw_error_underline}, q{PangoRenderer* renderer, int x, int y, int width, int height}},
			{q{void}, q{pango_renderer_draw_trapezoid}, q{PangoRenderer* renderer, PangoRenderPart part, double y1, double x11, double x21, double y2, double x12, double x22}, aliases: [q{pango_renderer_draw_trapezium}]},
			{q{void}, q{pango_renderer_draw_glyph}, q{PangoRenderer* renderer, PangoFont* font, PangoGlyph glyph, double x, double y}},
			{q{void}, q{pango_renderer_activate}, q{PangoRenderer* renderer}},
			{q{void}, q{pango_renderer_deactivate}, q{PangoRenderer* renderer}},
			{q{void}, q{pango_renderer_part_changed}, q{PangoRenderer* renderer, PangoRenderPart part}},
			{q{void}, q{pango_renderer_set_color}, q{PangoRenderer* renderer, PangoRenderPart part, const(PangoColour)* colour}, aliases: [q{pango_renderer_set_colour}]},
			{q{PangoColour*}, q{pango_renderer_get_color}, q{PangoRenderer* renderer, PangoRenderPart part}, aliases: [q{pango_renderer_get_colour}]},
			{q{void}, q{pango_renderer_set_matrix}, q{PangoRenderer* renderer, const(PangoMatrix)* matrix}},
			{q{const(PangoMatrix)*}, q{pango_renderer_get_matrix}, q{PangoRenderer* renderer}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,20,0)){
		FnBind[] add = [
			{q{PangoLayout*}, q{pango_renderer_get_layout}, q{PangoRenderer* renderer}},
			{q{PangoLayoutLine*}, q{pango_renderer_get_layout_line}, q{PangoRenderer* renderer}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,22,0)){
		FnBind[] add = [
			{q{void}, q{pango_renderer_draw_glyph_item}, q{PangoRenderer* renderer, const(char)* text, PangoGlyphItem* glyphItem, int x, int y}},
		];
		ret ~= add;
	}
	if(pangoVersion >= Version(1,38,0)){
		FnBind[] add = [
			{q{void}, q{pango_renderer_set_alpha}, q{PangoRenderer* renderer, PangoRenderPart part, ushort alpha}},
			{q{ushort}, q{pango_renderer_get_alpha}, q{PangoRenderer* renderer, PangoRenderPart part}},
		];
		ret ~= add;
	}
	return ret;
}()));
