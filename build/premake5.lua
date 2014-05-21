solution "xlnt"
    configurations { "Debug", "Release" }
    platforms { "x64" }
    location ("./" .. _ACTION)
    configuration "Debug"
        flags { "Symbols" }
	optimize "Off"
    configuration "Release"
        optimize "Full"

project "xlnt.test"
    kind "ConsoleApp"
    language "C++"
    targetname "xlnt.test"
    includedirs { 
       "$(cxxtest_prefix)",
       "../include",
       "../third-party/pugixml/src",
       "../third-party/zlib",
       "../third-party/zlib/contrib/minizip"
    }
    files { 
       "../source/tests/**.h",
       "../source/tests/runner-autogen.cpp"
    }
    links { "xlnt" }
    prebuildcommands { "cxxtestgen --runner=ErrorPrinter -o ../../source/tests/runner-autogen.cpp ../../source/tests/*.h" }
    flags { 
       "Unicode",
       "NoEditAndContinue",
       "NoManifest",
       "NoPCH"
    }
    configuration "Debug"
	targetdir "../bin"
    configuration "Release"
        flags { "LinkTimeOptimization" }
	targetdir "../bin"
    configuration "windows"
        defines { "WIN32" }
	links { "Shlwapi" }
    configuration "not windows"
        buildoptions { 
            "-std=c++11",
            "-Wno-unknown-pragmas"
        }

project "xlnt"
    kind "StaticLib"
    language "C++"
    warnings "Extra"
    targetdir "../lib/"
    links { 
        "zlib",
	"pugixml"
    }
    includedirs { 
       "../source/",
       "../third-party/pugixml/src",
       "../third-party/zlib/",
       "../third-party/zlib/contrib/minizip"
    }
    files {
       "../source/*.cpp",
       "../source/*.h"
    }
    flags { 
       "Unicode",
       "NoEditAndContinue",
       "NoManifest",
       "NoPCH"
    }
    configuration "Debug"
        flags { "FatalWarnings" }
    configuration "windows"
        defines { "WIN32" }
    configuration "not windows"
        buildoptions { 
            "-std=c++11",
            "-Wno-unknown-pragmas"
        }

project "pugixml"
    kind "StaticLib"
    language "C++"
    warnings "Off"
    targetdir "../lib/"
    includedirs { 
       "../third-party/pugixml/src"
    }
    files {
       "../third-party/pugixml/src/pugixml.cpp"
    }
    flags { 
       "Unicode",
       "NoEditAndContinue",
       "NoManifest",
       "NoPCH"
    }
    configuration "windows"
        defines { "WIN32" }

project "zlib"
    kind "StaticLib"
    language "C"
    warnings "Off"
    targetdir "../lib/"
    includedirs { 
       "../third-party/zlib/",
       "../third-party/zlib/contrib/minizip"
    }
    files {
       "../third-party/zlib/*.c",
       "../third-party/zlib/contrib/minizip/*.c"
    }
    excludes {
       "../third-party/zlib/contrib/minizip/miniunz.c",
       "../third-party/zlib/contrib/minizip/minizip.c",
       "../third-party/zlib/contrib/minizip/iowin32.c",
       "../third-party/zlib/gz*.c"
    }
    flags { 
       "Unicode",
       "NoEditAndContinue",
       "NoManifest",
       "NoPCH"
    }
    configuration "windows"
        defines { "WIN32" }
