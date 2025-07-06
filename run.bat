@echo off
REM This script runs the application after setting the necessary paths for the DLLs.

REM --- Configuration: Set the paths to your DLLs here ---
set QT_BIN_PATH=C:\Qt\6.9.1\mingw_64\bin
set GMSH_LIB_PATH=C:\gmsh-4.14.0-Windows64-sdk\lib

REM --- Add the DLL paths to the PATH environment variable for this command session ---
echo Adding DLL directories to PATH...
set PATH=%QT_BIN_PATH%;%GMSH_LIB_PATH%;%PATH%
echo.

REM --- Run the executable ---
echo Starting application...
echo ===================================
call .\batchgenerator.exe
echo ===================================
echo Application finished.
echo.

pause