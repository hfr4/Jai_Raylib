/* ******************************************************************************************
*
*   raylib [shapes] example - easings rectangle array
*
*   NOTE: This example requires 'easings.h' library, provided on raylib/src. Just copy
*   the library to same directory as example or make sure it's available on include path.
*
*   Example originally created with raylib 2.0, last time updated with raylib 2.5
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

RECS_WIDTH          :: 50;
RECS_HEIGHT         :: 50;

MAX_RECS_X          :: 800/RECS_WIDTH;
MAX_RECS_Y          :: 450/RECS_HEIGHT;

PLAY_TIME_IN_FRAMES :: 240;                // At 60 fps = 4 seconds

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - easings rectangle array");

    recs: [MAX_RECS_X*MAX_RECS_Y] Rectangle;

    for y: 0..MAX_RECS_Y - 1 {
        for x: 0..MAX_RECS_X - 1 {
            recs[y * MAX_RECS_X + x].x      = RECS_WIDTH  / 2.0 + RECS_WIDTH  * x;
            recs[y * MAX_RECS_X + x].y      = RECS_HEIGHT / 2.0 + RECS_HEIGHT * y;
            recs[y * MAX_RECS_X + x].width  = RECS_WIDTH;
            recs[y * MAX_RECS_X + x].height = RECS_HEIGHT;
        }
    }

    rotation := 0.0;
    framesCounter := 0;
    state := 0;                  // Rectangles animation state: 0-Playing, 1-Finished

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (state == 0)
        {
            framesCounter += 1;

            for i: 0..MAX_RECS_X * MAX_RECS_Y - 1
            {
                recs[i].height = EaseCircOut(cast(float) framesCounter, RECS_HEIGHT, -RECS_HEIGHT, PLAY_TIME_IN_FRAMES);
                recs[i].width  = EaseCircOut(cast(float) framesCounter, RECS_WIDTH , -RECS_WIDTH , PLAY_TIME_IN_FRAMES);

                if (recs[i].height < 0) recs[i].height = 0;
                if (recs[i].width  < 0) recs[i].width  = 0;

                if ((recs[i].height == 0) && (recs[i].width == 0)) state = 1;   // Finish playing

                rotation = EaseLinearIn(cast(float) framesCounter, 0.0, 360.0, PLAY_TIME_IN_FRAMES);
            }
        }
        else if ((state == 1) && IsKeyPressed(xx KeyboardKey.SPACE))
        {
            // When animation has finished, press space to restart
            framesCounter = 0;

            for i: 0..MAX_RECS_X * MAX_RECS_Y - 1
            {
                recs[i].height = RECS_HEIGHT;
                recs[i].width  = RECS_WIDTH;
            }

            state = 0;
        }
        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (state == 0)
            {
                for i: 0..MAX_RECS_X * MAX_RECS_Y - 1
                {
                    DrawRectanglePro(recs[i], .{ recs[i].width/2, recs[i].height/2 }, rotation, RED);
                }
            }
            else if (state == 1) DrawText("PRESS [SPACE] TO PLAY AGAIN!", 240, 200, 20, GRAY);

        EndDrawing();
    }

    CloseWindow();
}