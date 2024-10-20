
# BindBC-Pango
This project provides a set of both static and dynamic bindings to [Pango](https://www.pango.org/). They are compatible with `@nogc` and `nothrow`, and can be compiled with BetterC compatibility.

| Table of Contents |
|-------------------|
|[License](#license)|
|[Pango documentation](#pango-documentation)|
|[Quickstart guide](#quickstart-guide)|
|[Binding-specific changes](#binding-specific-changes)|
|[Configurations](#configurations)|
|[Library versions](#library-versions)|

## License

BindBC-Pango&mdash;as well as every other binding in the [BindBC project](https://github.com/BindBC)&mdash;is licensed under the [Boost Software License](https://www.boost.org/LICENSE_1_0.txt).

Bear in mind that you still need to abide by [Pango' license](https://gitlab.gnome.org/GNOME/pango/-/blob/main/COPYING) if you use it through these bindings.

## Pango documentation
This readme describes how to use BindBC-Pango, *not* Pango itself. BindBC-Pango does have minor API changes from Pango, which are listed in [Binding-specific changes](#binding-specific-changes). Otherwise BindBC-Pango is a direct D binding to the Pango C API, so any existing Pango documentation and tutorials can be adapted with only minor modifications.
* [Pango's manual](https://docs.gtk.org/Pango/).

## Quickstart guide
To use BindBC-Pango in your dub project, add it and BindBC-GLib to the list of `dependencies` in your dub configuration file. The easiest way is by running `dub add bindbc-pango bindbc-glib` in your project folder. The result should look something like this:

Example __dub.json__
```json
"dependencies": {
	"bindbc-pango": "~>1.0",
	"bindbc-glib": "~>1.0",
},
```
Example __dub.sdl__
```sdl
dependency "bindbc-pango" version="~>1.0"
dependency "bindbc-glib" version="~>1.0"
```

If you want to use Pango's Fontconfig and FreeType 2 support, you'll have to add the submodules `:fontconfig` and `:freetype` as dependencies:

Example __dub.json__
```json
"dependencies": {
	"bindbc-pango": "~>1.0",
	"bindbc-pango:fontconfig": "~>1.0",
	"bindbc-pango:freetype": "~>1.0",
	"bindbc-glib": "~>1.0",
},
```
Example __dub.sdl__
```sdl
dependency "bindbc-pango" version="~>1.0"
dependency "bindbc-pango:fontconfig" version="~>1.0"
dependency "bindbc-pango:freetype" version="~>1.0"
dependency "bindbc-glib" version="~>1.0"
```

By default, BindBC-Pango is configured to compile as a dynamic binding that is not BetterC-compatible. If you prefer static bindings or need BetterC compatibility, they can be enabled via `subConfigurations` in your dub configuration file. For configuration naming & more details, see [Configurations](#configurations).

Example __dub.json__
```json
"subConfigurations": {
	"bindbc-pango": "staticBC",
},
```
Example __dub.sdl__
```sdl
subConfiguration "bindbc-pango" "staticBC"
```

If you need to use versions of Pango newer than 1.0.0, then you will have to add the appropriate version identifier to `versions` in your dub configuration. For a list of library version identifiers, see [Library versions](#library-versions).

If you're using static bindings, then you will also need to add the name of the Pango library (and the Pango FreeType library if you're using it) to `libs`.

Example __dub.json__
```json
"versions": [
	"Pango_1_40_0",
],
"libs": [
	"pango-1.0", "pangoft2-1.0",
],
```
Example __dub.sdl__
```sdl
versions "Pango_1_40_0"
libs "pango-1.0" "pangoft2-1.0"
```

**If you're using static bindings**: `import bindbc.pango` in your code, and then you can use all of Pango just like you would in C. That's it!
```d
import bindbc.pango;

void main(){
	PangoFontDescription* desc = pango_font_description_new();
	
	//etc.
	
	pango_font_description_free(desc);
}
```

**If you're using dynamic bindings**: you need to load each library you need with the appropriate load function. `loadPango` for Pango, `loadPangoFontconfig` for Pango Fontconfig, and `loadPangoFreeType` for Pango FreeType.

For most use cases, it's best to use BindBC-Loader's [error handling API](https://github.com/BindBC/bindbc-loader#error-handling) to see if there were any errors while loading the library. This information can be written to a log file before aborting the program.

The load function will also return a member of the `LoadMsg` enum, which can be used for debugging:

* `noLibrary` means the library couldn't be found.
* `badLibrary` means there was an error while loading the library.
* `success` means that the library was loaded without any errors.

Here's a simple example using only the load function's return value:

```d
import bindbc.pango;
import bindbc.loader;

/*
This code attempts to load the Pango shared library using
well-known variations of the library name for the host system.
*/
LoadMsg ret = loadPango();
if(ret != LoadMsg.success){
	/*
	Error handling. For most use cases, it's best to use the error handling API in
	BindBC-Loader to retrieve error messages for logging and then abort.
	If necessary, it's possible to determine the root cause via the return value:
	*/
	if(ret == LoadMsg.noLibrary){
		//The Pango shared library failed to load
	}else if(ret == LoadMsg.badLibrary){
		//One or more symbols failed to load.
	}
}

/*
This code attempts to load Pango using a user-supplied file name.
Usually, the name and/or path used will be platform specific, as in this
example which attempts to load `pango.dll` from the `libs` subdirectory,
relative to the executable, only on Windows.
*/
version(Windows) loadPango("libs/pango.dll");
```

[The error handling API](https://github.com/BindBC/bindbc-loader#error-handling) in BindBC-Loader can be used to log error messages:
```d
import bindbc.pango;

/*
Import the sharedlib module for error handling. Assigning an alias ensures that the
function names do not conflict with other public APIs. This isn't strictly necessary,
but the API names are common enough that they could appear in other packages.
*/
import loader = bindbc.loader.sharedlib;

bool loadLib(){
	LoadMsg ret = loadPango();
	if(ret != LoadMsg.success){
		//Log the error info
		foreach(info; loader.errors){
			/*
			A hypothetical logging function. Note that `info.error` and
			`info.message` are `const(char)*`, not `string`.
			*/
			logError(info.error, info.message);
		}
		
		//Optionally construct a user-friendly error message for the user
		string msg;
		if(ret == LoadMsg.noLibrary){
			msg = "This application requires the Pango library.";
		}else{
			const(char)* version = pango_version_string();
			msg = "Your Pango version is too low: "~version;
		}
		//A hypothetical message box function
		showMessageBox(msg);
		return false;
	}
	return true;
}
```

## Binding-specific changes

Enums are available both in their original C-style `UPPER_SNAKE_CASE` form, and as the D-style `PascalCase.camelCase`. Both variants are enabled by default, but can be selectively chosen using the version identifiers `Pango_C_Enums_Only` or `Pango_D_Enums_Only` respectively.

`camelCase`d variants are available for struct fields using `snake_case`, defines using `UPPER_SNAKE_CASE`, and other similar incongruities with D's casing, with the notable exception of any external functions.

> [!NOTE]\
> The version identifiers `BindBC_C_Enums_Only` and `BindBC_D_Enums_Only` can be used to configure all of the applicable _official_ BindBC packages used in your program. Package-specific version identifiers override this.

## Configurations
BindBC-Pango has the following configurations:

|      ┌      |  DRuntime  |   BetterC   |
|-------------|------------|-------------|
| **Dynamic** | `dynamic`  | `dynamicBC` |
| **Static**  | `static`   | `staticBC`  |

For projects that don't use dub, if BindBC-Pango is compiled for static bindings then the version identifier `BindPango_Static` must be passed to your compiler when building your project.

> [!NOTE]\
> The version identifier `BindBC_Static` can be used to configure all of the _official_ BindBC packages used in your program. (i.e. those maintained in [the BindBC GitHub organisation](https://github.com/BindBC)) Some third-party BindBC packages may support it as well.

### Dynamic bindings
The dynamic bindings have no link-time dependency on Pango, so the Pango shared library must be manually loaded at runtime from the shared library search path of the user's system.
On Windows, this is typically handled by distributing the Pango DLLs with your program.
On other systems, it usually means installing the Pango shared library through a package manager.

The function `isPangoLoaded` returns `true` if any version of the shared library has been loaded and `false` if not. `unloadPango` can be used to unload a successfully loaded shared library.

### Static bindings
Static _bindings_ do not require static _linking_. The static bindings have a link-time dependency on either the shared _or_ static Pango library. On Windows, you can link with the static library or, to use the DLLs, the import library. On other systems, you can link with either the static library or directly with the shared library.

When linking with the shared (or import) library, there is a runtime dependency on the shared library just as there is when using the dynamic bindings. The difference is that the shared library are no longer loaded manually&mdash;loading is handled automatically by the system when the program is launched. Attempting to call `loadPango` with the static bindings enabled will result in a compilation error.

Static linking requires Pango's development packages be installed on your system. The [Pango repository](https://gitlab.gnome.org/GNOME/pango/) provides the library's source code. You can also install them via your system's package manager. For example, on Debian-based Linux distributions `sudo apt install libpango-dev` will install both the development and runtime packages for Pango.

When linking with the static library, there is no runtime dependency on Pango.

## Library Versions

| Version |Version identifier|
|---------|------------------|
| 1.54.0  | `Pango_1_54_0`   |
| 1.52.0  | `Pango_1_52_0`   |
| 1.50.0  | `Pango_1_50_0`   |
| 1.48.0  | `Pango_1_48_0`   |
| 1.46.0  | `Pango_1_46_0`   |
| 1.44.0  | `Pango_1_44_0`   |
| 1.42.0  | `Pango_1_42_0`   |
| 1.40.0  | `Pango_1_40_0`   |
| 1.38.0  | `Pango_1_38_0`   |
| 1.36.7  | `Pango_1_36_7`   |
| 1.34.0  | `Pango_1_34_0`   |
| 1.32.0  | `Pango_1_32_0`   |
| 1.30.0  | `Pango_1_30_0`   |
| 1.26.0  | `Pango_1_26_0`   |
| 1.24.0  | `Pango_1_24_0`   |
| 1.22.0  | `Pango_1_22_0`   |
| 1.20.1  | `Pango_1_20_1`   |
| 1.20.0  | `Pango_1_20_0`   |
| 1.18.0  | `Pango_1_18_0`   |
| 1.16.0  | `Pango_1_16_0`   |
| 1.14.0  | `Pango_1_14_0`   |
| 1.12.0  | `Pango_1_12_0`   |
| 1.10.0  | `Pango_1_10_0`   |
| 1.8.0   | `Pango_1_8_0`    |
| 1.6.0   | `Pango_1_6_0`    |
| 1.4.0   | `Pango_1_4_0`    |
| 1.2.0   | `Pango_1_2_0`    |
