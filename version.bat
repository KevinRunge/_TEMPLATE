@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem // Define constants here:
set "FILE=%~1" & rem // (provide the target file as command line argument)
set "DIRECTIVE=#define" & rem // (name of the directive to search)
set "DEFINITION=VERSION_BUILD" & rem // (name of the definition to search)
set "CASESENS=" & rem // (set to non-empty for case-sensitive searches)
set "QUOTED=" & rem // (set to non-empty for quoting returned number)

rem // Resolve arguments and options:
if not defined FILE ((>&2 echo ERROR: no file specified!) & exit /B 1)
if defined CASESENS (set "CASESENS=") else (set "CASESENS=/I")
if defined QUOTED (set "QUOTED="^") else (set "QUOTED=")

rem // Loop through all lines in the target file:
setlocal EnableDelayedExpansion
for /F delims^=^ eol^= %%L in ('
    rem/ /* Prefix lines with line numbers to not lose empty ones; ^& ^
    rem/    after having read file, deplete its entire content: */ ^& ^
    findstr /N /R "^^" "!FILE!" ^& ^> "!FILE!" break
') do (
    endlocal
    set "FLAG="
    set "LINE=%%L"
    rem // Split line into three tokens:
    for /F "tokens=1-3 eol= " %%I in ("%%L") do (
        set "FIELD1=%%I"
        set "FIELD2=%%J"
        set "NUMBER=%%~K"
        setlocal EnableDelayedExpansion
        rem // Check first token for matching directive name:
        if %CASESENS% "!FIELD1:*:=!"=="!DIRECTIVE!" (
        rem // Check second token for matching definition name:
            if %CASESENS% "!FIELD2!"=="!DEFINITION!" (
                endlocal
                rem // Increment number of third token:
                set /A "NUMBER+=1"
                set "FLAG=#"
                setlocal EnableDelayedExpansion
            )
        )
        endlocal
    )
    setlocal EnableDelayedExpansion
    rem // Write output line into target file:
    >> "!FILE!" (
        rem // Check whether dirctive and definition matched:
        if defined FLAG (
            rem // Match found, so write new line with incremented number:
            echo(!DIRECTIVE! !DEFINITION! %QUOTED%!NUMBER!%QUOTED%
        ) else (
            rem // No match found, so write original line:
            echo(!LINE:*:=!
        )
    )
)
endlocal

endlocal
exit /B