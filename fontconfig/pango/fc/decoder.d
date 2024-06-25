/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.fc.decoder;

import bindbc.pango.config;
import bindbc.pango.codegen;

import pango.types;
import pango.fc.font;

import bindbc.fontconfig;

static if(pangoVersion >= Version(1,6,0)){
	struct PangoFcDecoder{
		private GObject parentInstance;
	}
	
	struct PangoFcDecoderClass{
		private GObjectClass parentClass;
		
		extern(C) nothrow{
			alias GetCharsetFn = FcCharSet* function(PangoFcDecoder* decoder, PangoFcFont* fcFont);
			alias GetGlyphFn = PangoGlyph function(PangoFcDecoder* decoder, PangoFcFont* fcFont, uint wc);
			alias ReservedFn = void function();
		}
		GetCharsetFn getCharset;
		GetGlyphFn getGlyph;
		alias get_charset = getCharset;
		alias get_glyph = getGlyph;
		
		private:
		ReservedFn _pango_reserved1;
		ReservedFn _pango_reserved2;
		ReservedFn _pango_reserved3;
		ReservedFn _pango_reserved4;
	}
}

mixin(joinFnBinds((){
	FnBind[] ret;
	if(pangoVersion >= Version(1,6,0)){
		FnBind[] add = [
			{q{GType}, q{pango_fc_decoder_get_type}, q{}, attr: q{pure}, aliases: [q{PANGO_FC_TYPE_DECODER}]},
			{q{FcCharSet*}, q{pango_fc_decoder_get_charset}, q{PangoFcDecoder* decoder, PangoFcFont* fcFont}},
			{q{PangoGlyph}, q{pango_fc_decoder_get_glyph}, q{PangoFcDecoder* decoder, PangoFcFont* fcFont, uint wc}},
		];
		ret ~= add;
	}
	return ret;
}()));
