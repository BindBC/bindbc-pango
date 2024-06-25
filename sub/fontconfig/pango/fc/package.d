/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module pango.fc;

import bindbc.pango.config;
import bindbc.pango.codegen;

public import
	pango.fc.decoder,  pango.fc.font,  pango.fc.fontmap;

static if(!staticBinding):
import bindbc.loader;

mixin(makeDynloadFns("PangoFontconfig", makeLibPaths(["pangofc-1.0"]), [
	"pango.fc.decoder",  "pango.fc.font",  "pango.fc.fontmap",
]));
