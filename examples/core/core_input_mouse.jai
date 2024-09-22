/* ******************************************************************************************
*
*   raylib [core] example - Mouse input
*
*   Example originally created with raylib 1.0, last time updated with raylib 4.0
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - mouse input");

    ballPosition := Vector2.{ -100.0, -100.0 };
    ballColor := DARKBLUE;

    SetTargetFPS(60);


    while !WindowShouldClose() {

        ballPosition = GetMousePosition();

        if      (IsMouseButtonPressed(xx MouseButton.LEFT))    ballColor = MAROON;
        else if (IsMouseButtonPressed(xx MouseButton.MIDDLE))  ballColor = LIME;
        else if (IsMouseButtonPressed(xx MouseButton.RIGHT))   ballColor = DARKBLUE;
        else if (IsMouseButtonPressed(xx MouseButton.SIDE))    ballColor = PURPLE;
        else if (IsMouseButtonPressed(xx MouseButton.EXTRA))   ballColor = YELLOW;
        else if (IsMouseButtonPressed(xx MouseButton.FORWARD)) ballColor = ORANGE;
        else if (IsMouseButtonPressed(xx MouseButton.BACK))    ballColor = BEIGE;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawCircleV(ballPosition, 40, ballColor);

            DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, DARKGRAY);

        EndDrawing();
    }

    CloseWindow();
}