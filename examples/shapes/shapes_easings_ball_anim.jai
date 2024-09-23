/* ******************************************************************************************
*
*   raylib [shapes] example - easings ball anim
*
*   Example originally created with raylib 2.5, last time updated with raylib 2.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

#load "reasings.jai";


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - easings ball anim");

    // Ball variable value to be animated with easings
    ballPositionX : s32 = -100;
    ballRadius := 20;
    ballAlpha := 0.0;

    state := 0;
    framesCounter := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {
        if (state == 0)             // Move ball position X with easing
        {
            framesCounter+= 1;
            ballPositionX = cast(s32) EaseElasticOut(cast(float) framesCounter, -100, SCREEN_WIDTH/2.0 + 100, 120);

            if (framesCounter >= 120)
            {
                framesCounter = 0;
                state = 1;
            }
        }
        else if (state == 1)        // Increase ball radius with easing
        {
            framesCounter+= 1;
            ballRadius = cast(s32) EaseElasticIn(cast(float) framesCounter, 20, 500, 200);

            if (framesCounter >= 200)
            {
                framesCounter = 0;
                state = 2;
            }
        }
        else if (state == 2)        // Change ball alpha with easing (background color blending)
        {
            framesCounter+= 1;
            ballAlpha = EaseCubicOut(cast(float) framesCounter, 0.0, 1.0, 200);

            if (framesCounter >= 200)
            {
                framesCounter = 0;
                state = 3;
            }
        }
        else if (state == 3)        // Reset state to play again
        {
            if (IsKeyPressed(xx KeyboardKey.ENTER))
            {
                // Reset required variables to play again
                ballPositionX = -100;
                ballRadius = 20;
                ballAlpha = 0.0;
                state = 0;
            }
        }

        if (IsKeyPressed(xx KeyboardKey.R)) framesCounter = 0;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (state >= 2) DrawRectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, GREEN);
            DrawCircle(ballPositionX, 200, cast(float) ballRadius, Fade(RED, 1.0 - ballAlpha));

            if (state == 3) DrawText("PRESS [ENTER] TO PLAY AGAIN!", 240, 200, 20, BLACK);

        EndDrawing();
    }

    CloseWindow();
}