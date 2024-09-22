/* ******************************************************************************************
*
*   raylib [shapes] example - Draw raylib logo using basic shapes
*
*   Example originally created with raylib 1.0, last time updated with raylib 1.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - raylib logo using shapes");

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // TODO: Update your variables here


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawRectangle(SCREEN_WIDTH/2 - 128, SCREEN_HEIGHT/2 - 128, 256, 256, BLACK);
            DrawRectangle(SCREEN_WIDTH/2 - 112, SCREEN_HEIGHT/2 - 112, 224, 224, RAYWHITE);
            DrawText("raylib", SCREEN_WIDTH/2 - 44, SCREEN_HEIGHT/2 + 48, 50, BLACK);

            DrawText("this is NOT a texture!", 350, 370, 10, GRAY);

        EndDrawing();
    }

    CloseWindow();
}