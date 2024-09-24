/* ******************************************************************************************
*
*   raylib [text] example - Text formatting
*
*   Example originally created with raylib 1.1, last time updated with raylib 3.0
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - text formatting");

    score   := 100020;
    hiscore := 200450;
    lives   := 5;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText(TextFormat("Score: %", score), 200, 80, 20, RED);

            DrawText(TextFormat("HiScore: %", hiscore), 200, 120, 20, GREEN);

            DrawText(TextFormat("Lives: %", lives), 200, 160, 40, BLUE);

            DrawText(TextFormat("Elapsed Time: % ms", GetFrameTime()*1000), 200, 220, 20, BLACK);

        EndDrawing();
    }

    CloseWindow();
}