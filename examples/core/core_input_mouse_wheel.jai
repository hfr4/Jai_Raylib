/* ******************************************************************************************
*
*   raylib [core] examples - Mouse wheel input
*
*   Example originally created with raylib 1.1, last time updated with raylib 1.3
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - input mouse wheel");

    boxPositionY := SCREEN_HEIGHT/2 - 40;
    scrollSpeed := 4;            // Scrolling speed in pixels

    SetTargetFPS(60);

    while !WindowShouldClose() {

        boxPositionY -= cast(s32) (GetMouseWheelMove()*scrollSpeed);


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawRectangle(xx (SCREEN_WIDTH/2 - 40), xx boxPositionY, 80, 80, MAROON);

            DrawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, GRAY);
            DrawText(TextFormat("Box position Y: %", boxPositionY), 10, 40, 20, LIGHTGRAY);

        EndDrawing();
    }

    CloseWindow();
}