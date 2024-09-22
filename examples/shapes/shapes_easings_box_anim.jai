/* ******************************************************************************************
*
*   raylib [shapes] example - easings box anim
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - easings box anim");

    // Box variables to be animated with easings
    rec := Rectangle.{ GetScreenWidth()/2.0, -100, 100, 100 };
    rotation := 0.0;
    alpha := 1.0;

    state := 0;
    framesCounter := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {
        if state == {
            case 0;     // Move box down to center of screen
                framesCounter+= 1;

                // NOTE: Remember that 3rd parameter of easing function refers to
                // desired value variation, do not confuse it with expected final value!
                rec.y = EaseElasticOut(cast(float) framesCounter, -100, GetScreenHeight()/2.0 + 100, 120);

                if (framesCounter >= 120)
                {
                    framesCounter = 0;
                    state = 1;
                }

            case 1;     // Scale box to an horizontal bar
                framesCounter+= 1;
                rec.height = EaseBounceOut(cast(float) framesCounter, 100, -90, 120);
                rec.width = EaseBounceOut(cast(float) framesCounter, 100, cast(float) GetScreenWidth(), 120);

                if (framesCounter >= 120)
                {
                    framesCounter = 0;
                    state = 2;
                }

            case 2;     // Rotate horizontal bar rectangle
                framesCounter+= 1;
                rotation = EaseQuadOut(cast(float) framesCounter, 0.0, 270.0, 240);

                if (framesCounter >= 240)
                {
                    framesCounter = 0;
                    state = 3;
                }

            case 3;     // Increase bar size to fill all screen
                framesCounter+= 1;
                rec.height = EaseCircOut(cast(float) framesCounter, 10, cast(float) GetScreenWidth(), 120);

                if (framesCounter >= 120)
                {
                    framesCounter = 0;
                    state = 4;
                }

            case 4;     // Fade out animation
                framesCounter+= 1;
                alpha = EaseSineOut(cast(float) framesCounter, 1.0, -1.0, 160);

                if (framesCounter >= 160)
                {
                    framesCounter = 0;
                    state = 5;
                }
        }

        // Reset animation at any moment
        if (IsKeyPressed(xx KeyboardKey.SPACE))
        {
            rec           = .{ GetScreenWidth()/2.0, -100, 100, 100 };
            rotation      = 0.0;
            alpha         = 1.0;
            state         = 0;
            framesCounter = 0;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawRectanglePro(rec, .{ rec.width/2, rec.height/2 }, rotation, Fade(BLACK, alpha));

            DrawText("PRESS [SPACE] TO RESET BOX ANIMATION!", 10, GetScreenHeight() - 25, 20, LIGHTGRAY);

        EndDrawing();
    }

    CloseWindow();
}