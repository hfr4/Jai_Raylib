@echo off

if defined VSINSTALLDIR (
    if exist "vendors" ( rmdir /s /q "vendors" )
    mkdir vendors

    cd vendors
        if exist "raylib" ( rmdir /s /q "raylib" )
        if exist "raygui" ( rmdir /s /q "raygui" )

        git clone --depth 1 --branch 5.0 "https://github.com/raysan5/raylib"
        git clone --depth 1 --branch 4.0 "https://github.com/raysan5/raygui"

        cd raylib
            mkdir build
            cd build
                cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=FALSE
                cmake --build .
            cd ..
        cd ..

        cd raygui
            copy src\raygui.h src\raygui.c
            mkdir build
            cd build
                set INCLUDE_DIR=../../raylib/src/
                set OUTPUT_FILE=raygui.dll
                set SOURCE_FILE=../src/raygui.c
                set RAYLIB_PATH=../../raylib/build/raylib/Debug/raylib.lib
                set DEFS=/D_USRDLL /D_WINDLL /DRAYGUI_IMPLEMENTATION /DBUILD_LIBTYPE_SHARED

                cl /O2 /I%INCLUDE_DIR% %DEFS% %SOURCE_FILE% /LD /Fe%OUTPUT_FILE% /link /LIBPATH %RAYLIB_PATH% /subsystem:windows /machine:x64
            cd ..
            rm src\raygui.c
        cd ..
    cd ..
) else (
    echo Run this script from Visual Studio command prompt.
)