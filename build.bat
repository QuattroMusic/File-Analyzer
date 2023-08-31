@echo off
@setlocal

@rem setup
cls
SET includes=/external:W0 /cgthreads4 /MD /external:I "..\third_party\include" /DYNAMICBASE
SET libs=/link /LIBPATH:"..\third_party\lib\" raylibdll.lib raylib.lib raygui.lib
SET initial=/nologo /std:c++20 /W0 /EHsc

set opt=             -O2                 &:: Od=no optimizations, O2=full optimizations
set debug=           -FC                 &:: produce full path of the source code file
set debug=%debug%    -Z7                 &:: produce debug information

@rem execution order
call :build_client
call :start_client
goto end

:calculate_time
    @rem function used to calculate compilation time
    set options="tokens=1-4 delims=:.,"
    for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
    for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

    set /a hours=%end_h%-%start_h%
    set /a mins=%end_m%-%start_m%
    set /a secs=%end_s%-%start_s%
    set /a ms=%end_ms%-%start_ms%
    if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
    if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
    if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
    if %hours% lss 0 set /a hours = 24%hours%
    if 1%ms% lss 100 set ms=0%ms%
    set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
    exit /b

:build_client
    set start=%time%
    echo BUILDING CLIENT...
    if not exist build\ mkdir build\
    pushd build\
    cl %opt% %initial% %debug% %includes% ..\main.cpp %libs% /OUT:tool.exe
    popd
    set end=%time%
    call :calculate_time
    
    @set error1=%ERRORLEVEL%
    
    @rem Mission accomplished
    echo tool build took %hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total)
    echo.
    exit /b

:start_client
    if %error1% NEQ 0 goto end
    pushd build\
    @rem cleaning
    @REM if exist main.obj del main.obj
    @REM if exist tool.ilk del tool.ilk
    @REM if exist tool.pdb del tool.pdb
    @REM if exist vc140.pdb del vc140.pdb
    @rem starting
    start .\tool.exe
    popd
    exit /b

:end
    echo Execution terminated
