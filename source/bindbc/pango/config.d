/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module bindbc.pango.config;

public import bindbc.common.versions: Version;

//GLib
alias gboolean = int;
alias GType = size_t;
alias GQuark = uint;
struct GBytes;
struct GData;
struct GSList{
	void* data;
	GSList* next;
}
struct GList{
	void* data;
	GList* next;
	GList* prev;
}
struct GValue;
struct GParamSpec;
struct GObjectConstructParam;
struct GTypeClass{
	private GType gType;
}
struct GTypeInstance{
	private GTypeClass* gClass;
}
struct GObject{
	GTypeInstance gTypeInstance;
	alias g_type_instance = gTypeInstance;
	private:
	uint refCount;
	GData* qData;
}
struct GObjectClass{
	GTypeClass gTypeClass;
	alias g_type_class = gTypeClass;
	private GSList* constructProperties;
	
	extern(C) nothrow{
		alias GenericFn = void function(GObject* object);
		alias ConstructorFn = GObject* function(GType type, uint nConstructProperties, GObjectConstructParam* constructProperties);
		alias SetPropertyFn = void function(GObject* object, uint propertyID, const(GValue)* value, GParamSpec* pSpec);
		alias GetPropertyFn = void function(GObject* object, uint propertyID, GValue* value, GParamSpec* pSpec);
		alias DispatchPropertiesChangedFn = void function(GObject* object, uint nPSpecs, GParamSpec** pSpecs);
		alias NotifyFn = void function(GObject* object, GParamSpec* pSpec);
	}
	ConstructorFn constructor;
	SetPropertyFn setProperty;
	GetPropertyFn getProperty;
	GenericFn dispose;
	GenericFn finalise;
	DispatchPropertiesChangedFn dispatchPropertiesChanged;
	NotifyFn notify;
	GenericFn constructed;
	alias set_property = setProperty;
	alias get_property = getProperty;
	alias finalize = finalise;
	alias dispatch_properties_changed = dispatchPropertiesChanged;
	
	private:
	size_t flags;
	size_t nConstructProperties;
	void* pSpecs;
	size_t nPSpecs;
	void*[3] pDummy;
}
struct GError{
	GQuark domain;
	int code;
	char* message;
}
alias GDestroyNotify = extern(C) void function(void* data);
//HarfBuzz
struct hb_feature_t;
struct hb_font_t;

enum staticBinding = (){
	version(BindBC_Static)         return true;
	else version(BindPango_Static) return true;
	else return false;
}();

enum cStyleEnums = (){
	version(Pango_D_Enums_Only) return false;
	else return true;
}();

enum dStyleEnums = (){
	version(Pango_C_Enums_Only) return false;
	else return true;
}();

enum pangoVersion = (){
	version(Pango_1_54)         return Version(1,54,0);//not seen yet
	else version(Pango_1_52_0)  return Version(1,52,0);
	else version(Pango_1_50_0)  return Version(1,50,0);
	else version(Pango_1_48_0)  return Version(1,48,0);//not seen yet
	else version(Pango_1_46_0)  return Version(1,46,0);
	else version(Pango_1_44_0)  return Version(1,44,0);
	else version(Pango_1_42_0)  return Version(1,42,0);
	else version(Pango_1_40_0)  return Version(1,40,0);
	else version(Pango_1_38_0)  return Version(1,38,0);
	else version(Pango_1_36_7)  return Version(1,36,7);
	else version(Pango_1_36_0)  return Version(1,36,0);//not seen yet
	else version(Pango_1_34_0)  return Version(1,34,0);
	else version(Pango_1_32_0)  return Version(1,32,0);
	else version(Pango_1_30_0)  return Version(1,30,0);
	else version(Pango_1_28_0)  return Version(1,28,0);//not seen yet
	else version(Pango_1_26_0)  return Version(1,26,0);
	else version(Pango_1_24_0)  return Version(1,24,0);
	else version(Pango_1_22_0)  return Version(1,22,0);
	else version(Pango_1_20_1)  return Version(1,20,1);
	else version(Pango_1_20_0)  return Version(1,20,0);
	else version(Pango_1_18_0)  return Version(1,18,0);
	else version(Pango_1_16_0)  return Version(1,16,0);
	else version(Pango_1_14_0)  return Version(1,14,0);
	else version(Pango_1_12_0)  return Version(1,12,0);
	else version(Pango_1_10_0)  return Version(1,10,0);
	else version(Pango_1_8_0)   return Version(1,8,0);
	else version(Pango_1_6_0)   return Version(1,6,0);
	else version(Pango_1_4_0)   return Version(1,4,0);
	else version(Pango_1_2_0)   return Version(1,2,0);
	else                        return Version(1,0,0);
}();
