/* ******************************************************************************************
*
*   raylib [shapes] example - following eyes
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

Math :: #import "Math";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - following eyes");

    scleraLeftPosition  := Vector2.{ GetScreenWidth()/2.0 - 100.0, GetScreenHeight()/2.0 };
    scleraRightPosition := Vector2.{ GetScreenWidth()/2.0 + 100.0, GetScreenHeight()/2.0 };
    scleraRadius := 80.0;

    irisLeftPosition  := Vector2.{ GetScreenWidth()/2.0 - 100.0, GetScreenHeight()/2.0 };
    irisRightPosition := Vector2.{ GetScreenWidth()/2.0 + 100.0, GetScreenHeight()/2.0 };
    irisRadius := 24.0;

    angle := 0.0;
    dx    := 0.0;
    dy    := 0.0;
    dxx   := 0.0;
    dyy   := 0.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        irisLeftPosition  = GetMousePosition();
        irisRightPosition = GetMousePosition();

        // Check not inside the left eye sclera
        if (!CheckCollisionPointCircle(irisLeftPosition, scleraLeftPosition, scleraRadius - irisRadius))
        {
            dx = irisLeftPosition.x - scleraLeftPosition.x;
            dy = irisLeftPosition.y - scleraLeftPosition.y;

            angle = Math.atan2(dy, dx);

            dxx = (scleraRadius - irisRadius)*Math.cos(angle);
            dyy = (scleraRadius - irisRadius)*Math.sin(angle);

            irisLeftPosition.x = scleraLeftPosition.x + dxx;
            irisLeftPosition.y = scleraLeftPosition.y + dyy;
        }

        // Check not inside the right eye sclera
        if (!CheckCollisionPointCircle(irisRightPosition, scleraRightPosition, scleraRadius - irisRadius))
        {
            dx = irisRightPosition.x - scleraRightPosition.x;
            dy = irisRightPosition.y - scleraRightPosition.y;

            angle = Math.atan2(dy, dx);

            dxx = (scleraRadius - irisRadius)*Math.cos(angle);
            dyy = (scleraRadius - irisRadius)*Math.sin(angle);

            irisRightPosition.x = scleraRightPosition.x + dxx;
            irisRightPosition.y = scleraRightPosition.y + dyy;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawCircleV(scleraLeftPosition, scleraRadius, LIGHTGRAY);
            DrawCircleV(irisLeftPosition, irisRadius, BROWN);
            DrawCircleV(irisLeftPosition, 10, BLACK);

            DrawCircleV(scleraRightPosition, scleraRadius, LIGHTGRAY);
            DrawCircleV(irisRightPosition, irisRadius, DARKGREEN);
            DrawCircleV(irisRightPosition, 10, BLACK);

            DrawFPS(10, 10);

        EndDrawing();
    }

    CloseWindow();
}