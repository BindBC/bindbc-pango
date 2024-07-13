/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.direction;

import bindbc.pango.config;
import bindbc.pango.codegen;
import bindbc.glib, bindbc.gobject;

mixin(makeEnumBind(q{PangoDirection}, members: (){
	EnumMember[] ret = [
		{{q{ltr},      q{PANGO_DIRECTION_LTR}}},
		{{q{rtl},      q{PANGO_DIRECTION_RTL}}},
		{{q{ttbLTR},   q{PANGO_DIRECTION_TTB_LTR}}},
		{{q{ttbRTL},   q{PANGO_DIRECTION_TTB_RTL}}},
		{{q{weakLTR},  q{PANGO_DIRECTION_WEAK_LTR}}},
		{{q{weakRTL},  q{PANGO_DIRECTION_WEAK_RTL}}},
		{{q{neutral},  q{PANGO_DIRECTION_NEUTRAL}}},
	];
	return ret;
}()));
