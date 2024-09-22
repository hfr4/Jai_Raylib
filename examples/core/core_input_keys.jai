/* ******************************************************************************************
*
*   raylib [core] example - Keyboard input
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - keyboard input");

    ballPosition := Vector2.{ cast(float) SCREEN_WIDTH/2, cast(float) SCREEN_HEIGHT/2 };

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyDown(xx KeyboardKey.RIGHT)) ballPosition.x += 2.0;
        if (IsKeyDown(xx KeyboardKey.LEFT))  ballPosition.x -= 2.0;
        if (IsKeyDown(xx KeyboardKey.UP))    ballPosition.y -= 2.0;
        if (IsKeyDown(xx KeyboardKey.DOWN))  ballPosition.y += 2.0;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("move the ball with arrow keys", 10, 10, 20, DARKGRAY);

            DrawCircleV(ballPosition, 50, MAROON);

        EndDrawing();
    }

    CloseWindow();
}