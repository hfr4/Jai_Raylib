/* ******************************************************************************************
*
*   raylib [core] example - Basic window (adapted for HTML5 platform)
*
*   NOTE: This example is prepared to compile for PLATFORM_WEB, and PLATFORM_DESKTOP
*   As you will notice, code structure is slightly diferent to the other examples...
*   To compile it for PLATFORM_WEB just uncomment #define PLATFORM_WEB at beginning
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.3
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

PLATFORM_WEB :: false;

#if PLATFORM_WEB {
//     #include <emscripten/emscripten.h>
}


SCREEN_WIDTH  :: 800;
SCREEN_HEIGHT :: 450;

main :: () {

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - basic window");

#if PLATFORM_WEB {
//     emscripten_set_main_loop(UpdateDrawFrame, 0, 1);
} else {
        SetTargetFPS(60);

        while !WindowShouldClose() {
            UpdateDrawFrame();
        }
}

    CloseWindow();
}


UpdateDrawFrame :: ()
{

    // TODO: Update your variables here


    // Draw

    BeginDrawing();

        ClearBackground(RAYWHITE);

        DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

    EndDrawing();

}