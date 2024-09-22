/* ******************************************************************************************
*
*   raylib [shapes] example - bouncing ball
*
*   Example originally created with raylib 2.5, last time updated with raylib 2.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2013-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - bouncing ball");

    ballPosition := Vector2.{ GetScreenWidth()/2.0, GetScreenHeight()/2.0 };
    ballSpeed    := Vector2.{ 5.0, 4.0 };
    ballRadius := 20;

    pause := false;
    framesCounter := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {
        if (IsKeyPressed(xx KeyboardKey.SPACE)) pause = !pause;

        if (!pause)
        {
            ballPosition.x += ballSpeed.x;
            ballPosition.y += ballSpeed.y;

            // Check walls collision for bouncing
            if ((ballPosition.x >= xx (GetScreenWidth()  - ballRadius)) || (ballPosition.x <= xx ballRadius)) ballSpeed.x *= -1.0;
            if ((ballPosition.y >= xx (GetScreenHeight() - ballRadius)) || (ballPosition.y <= xx ballRadius)) ballSpeed.y *= -1.0;
        }
        else framesCounter += 1;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawCircleV(ballPosition, cast(float) ballRadius, MAROON);
            DrawText("PRESS SPACE to PAUSE BALL MOVEMENT", 10, GetScreenHeight() - 25, 20, LIGHTGRAY);

            // On pause, we draw a blinking message
            if (pause && ((framesCounter/30)%2)) DrawText("PAUSED", 350, 200, 30, GRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }

    CloseWindow();
}