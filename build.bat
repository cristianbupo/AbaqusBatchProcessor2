@echo off
REM Batch file to compile and link the project.

REM ---
REM --- Configuration: Set your library paths here
REM ---
set CXX=g++
set EXECUTABLE=batchgenerator.exe

REM --- set GMSH_API_INCLUDE=C:/Users/crist/git/gmsh/api
REM --- set GMSH_LIB_PATH=C:/Users/crist/git/gmsh/build

set GMSH_API_INCLUDE=C:/gmsh-4.14.0-Windows64-sdk/include
set GMSH_LIB_PATH=C:/gmsh-4.14.0-Windows64-sdk/lib

set EIGEN_INCLUDE=C:/Users/crist/git/eigen

set SPDLOG_INCLUDE=C:/Users/crist/git/spdlog/include
set SPDLOG_LIB_PATH=C:/Users/crist/git/spdlog/build

set QT_INCLUDE=C:/Qt/6.9.1/mingw_64/include
set QT_LIB_PATH=C:/Qt/6.9.1/mingw_64/lib


REM ---
REM --- Build process begins
REM ---
echo ===================================
echo Starting project build...
echo ===================================
echo.

REM --- Compiler and Linker Flags ---
set INCLUDE_FLAGS=-I. -I./geometry2d -I%GMSH_API_INCLUDE% -I%EIGEN_INCLUDE% -I%SPDLOG_INCLUDE% -I%QT_INCLUDE% -I%QT_INCLUDE%\QtCore
set LINKER_FLAGS=-L%GMSH_LIB_PATH% -L%SPDLOG_LIB_PATH% -L%QT_LIB_PATH% -l:gmsh.dll.lib -lspdlog -lQt6Core

REM --- Source and Object Files ---
set OBJECTS=main.o generator.o node2d.o mesh2d.o element2d.o czinsertiontool2d.o cohesivezone2d.o

REM --- Compile ---
echo Compiling source files...
%CXX% -c main.cpp -o main.o %INCLUDE_FLAGS%
if %errorlevel% neq 0 goto :error
%CXX% -c generator.cpp -o generator.o %INCLUDE_FLAGS%
if %errorlevel% neq 0 goto :error
%CXX% -c geometry2d/node2d.cpp -o node2d.o %INCLUDE_FLAGS%
if %errorlevel% neq 0 goto :error
%CXX% -c geometry2d/mesh2d.cpp -o mesh2d.o %INCLUDE_FLAGS%
if %errorlevel% neq 0 goto :error
%CXX% -c geometry2d/element2d.cpp -o element2d.o %INCLUDE_FLAGS%
if %errorlevel% neq 0 goto :error
%CXX% -c geometry2d/czinsertiontool2d.cpp -o czinsertiontool2d.o %INCLUDE_FLAGS%
if %errorlevel% neq 0 goto :error
%CXX% -c geometry2d/cohesivezone2d.cpp -o cohesivezone2d.o %INCLUDE_FLAGS%
if %errorlevel% neq 0 goto :error
echo Compilation successful.
echo.

REM --- Link ---
echo Linking object files...
%CXX% %OBJECTS% -o %EXECUTABLE% %LINKER_FLAGS%
if %errorlevel% neq 0 goto :error
echo Linking successful.
echo.

REM --- Cleanup ---
echo Cleaning up object files...
del %OBJECTS%
echo.

echo ===================================
echo Build finished successfully!
echo Executable: %EXECUTABLE%
echo ===================================
goto :end

:error
echo.
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo !        BUILD FAILED             !
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
pause

:end
