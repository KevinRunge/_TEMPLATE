@ECHO OFF
PUSHD temp

REM ==================================================================
REM Simple Build script - for use in combination with 4coder
REM For larger projects use a proper build system!
REM By Kevin Runge 
REM Date 24-1-2021
REM ==================================================================

REM Project Settings
REM ----------------
set PROJECT_NAME=
set INCLUDES=
set LIBS=

REM ======================== DEBUG BUILD ============================= 
ECHO === Windows x64 Debug Build ===
cl /nologo /FC /Z7 /Fe..\build\debug\%PROJECT_NAME%.exe /I%INCLUDES% /Od ..\src\*.cpp /link %LIBS% /DEBUG:FULL /incremental:no /opt:ref /SUBSYSTEM:CONSOLE
REM ======================== DEBUG BUILD ============================= 
REM
REM ======================= RELEASE BUILD ============================ 
REM ECHO === Windows x64 Release build ===
REM CALL ..\version.bat ..\src\version.h
REM cl /nologo /FC /Fe..\build\win64\%PROJECT_NAME%.exe /DNDEBUG /I%INCLUDES% /Oi /O2 ..\src\*.cpp /link %LIBS% /incremental:no /opt:ref /SUBSYSTEM:WINDOWS
REM ======================= RELEASE BUILD ============================ 
POPD

REM cl Compiler Flags:
REM ------------------
REM Zi         : debug info (use Z7 for older debug format for complex builds)
REM Zo         : More debug info for optimized builds
REM FC         : Full path on errors
REM Oi         : Always use intrinsics when possible
REM Od         : No optimizations
REM OZ         : Full optimizations
REM MT         : Use c static runtime instead of searching for dll at run-time
REM MTd        : Same as MT but use the debug version of crt
REM GR-        : Turn off C++ runtime type info
REM Gm-        : Turn off incremental build (depreciated)
REM EHa-       : Turn off exception handling
REM WX         : Treat warnings as errors
REM W4         : Set warning level to 4
REM wd         : Ignore warning 
REM fp:fast    : Ignores the rules sometimes to optimize fp operations
REM Fmfile.map : Outputs a file map (mapping of the functions in an exe)
REM Feout.exe  : Specifies exe name and directory
REM c          : Only compile do not link; user needs to call LINK

REM Linker options:
REM ---------------
REM /link                : link commands
REM subsytem:windows,5.1 : make exe compatible with Windows XP (only in x86 mode)
REM OPT:REF              : do not put unused things in the exe
REM incremental:no       : do not build incremental
REM LD                   : build DLL
REM PDB:file.pdb         : change the .pdb's path


REM SDL2 example:
REM -------------
REM
REM SDL2 depends on shell32.lib see: https://hg.libsdl.org/SDL/rev/a1917148d38a
REM
REM set PROJECT_NAME=SDL_test
REM set INCLUDES=..\3rdparty\SDL2-2.0.14\include
REM set LIBS=shell32.lib ..\3rdparty\SDL2-2.0.14\lib\x64\SDL2.lib ..\3rdparty\SDL2-2.0.14\lib\x64\SDL2main.lib 
REM ======================== DEBUG BUILD ============================= 
REM ECHO === Windows x64 Debug Build ===
REM cl /nologo /FC /Z7 /Fe..\build\debug\%PROJECT_NAME%.exe /I%INCLUDES% /Od ..\src\*.cpp /link %LIBS% /DEBUG:FULL /incremental:no /opt:ref /SUBSYSTEM:CONSOLE
REM copy ..\3rdparty\SDL2-2.0.14\lib\x64\SDL2.dll ..\build\debug /Y
REM ======================== DEBUG BUILD ============================= 
REM
REM ======================= RELEASE BUILD ============================ 
REM ECHO === Windows x64 Release build ===
REM CALL ..\version.bat ..\src\version.h
REM cl /nologo /FC /Fe..\build\win64\%PROJECT_NAME%.exe /I%INCLUDES% /Oi /O2 ..\src\*.cpp /link %LIBS% /incremental:no /opt:ref /SUBSYSTEM:WINDOWS
REM copy ..\3rdparty\SDL2-2.0.14\lib\x64\SDL2.dll ..\build\win64 /Y
REM ======================= RELEASE BUILD ============================ 
