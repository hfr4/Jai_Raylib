/* ******************************************************************************************
*
*   raylib [core] example - window flags
*
*   Example originally created with raylib 3.5, last time updated with raylib 3.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2020-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    // Possible window flags
    /*
    xx ConfigFlags.VSYNC_HINT
    xx ConfigFlags.FULLSCREEN_MODE    -> not working properly -> wrong scaling!
    xx ConfigFlags.WINDOW_RESIZABLE
    xx ConfigFlags.WINDOW_UNDECORATED
    xx ConfigFlags.WINDOW_TRANSPARENT
    xx ConfigFlags.WINDOW_HIDDEN
    xx ConfigFlags.WINDOW_MINIMIZED   -> Not supported on window creation
    xx ConfigFlags.WINDOW_MAXIMIZED   -> Not supported on window creation
    xx ConfigFlags.WINDOW_UNFOCUSED
    xx ConfigFlags.WINDOW_TOPMOST
    xx ConfigFlags.WINDOW_HIGHDPI     -> errors after minimize-resize, fb size is recalculated
    xx ConfigFlags.WINDOW_ALWAYS_RUN
    xx ConfigFlags.MSAA_4X_HINT
    */

    // Set configuration flags for window creation
    //SetConfigFlags(xx ConfigFlags.VSYNC_HINT | xx ConfigFlags.MSAA_4X_HINT | xx ConfigFlags.WINDOW_HIGHDPI);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - window flags");

    ballPosition := Vector2.{ GetScreenWidth() / 2.0, GetScreenHeight() / 2.0 };
    ballSpeed := Vector2.{ 5.0, 4.0 };
    ballRadius := 20;

    framesCounter := 0;

    //SetTargetFPS(60);
    //----------------------------------------------------------


    while !WindowShouldClose() {
                //-----------------------------------------------------
        if (IsKeyPressed(xx KeyboardKey.F)) ToggleFullscreen();  // modifies window size when scaling!

        if (IsKeyPressed(xx KeyboardKey.R))
        {
            if (IsWindowState(xx ConfigFlags.WINDOW_RESIZABLE)) ClearWindowState(xx ConfigFlags.WINDOW_RESIZABLE);
            else SetWindowState(xx ConfigFlags.WINDOW_RESIZABLE);
        }

        if (IsKeyPressed(xx KeyboardKey.D))
        {
            if (IsWindowState(xx ConfigFlags.WINDOW_UNDECORATED)) ClearWindowState(xx ConfigFlags.WINDOW_UNDECORATED);
            else SetWindowState(xx ConfigFlags.WINDOW_UNDECORATED);
        }

        if (IsKeyPressed(xx KeyboardKey.H))
        {
            if (!IsWindowState(xx ConfigFlags.WINDOW_HIDDEN)) SetWindowState(xx ConfigFlags.WINDOW_HIDDEN);

            framesCounter = 0;
        }

        if (IsWindowState(xx ConfigFlags.WINDOW_HIDDEN))
        {
            framesCounter+= 1;
            if (framesCounter >= 240) ClearWindowState(xx ConfigFlags.WINDOW_HIDDEN); // Show window after 3 seconds
        }

        if (IsKeyPressed(xx KeyboardKey.N))
        {
            if (!IsWindowState(xx ConfigFlags.WINDOW_MINIMIZED)) MinimizeWindow();

            framesCounter = 0;
        }

        if (IsWindowState(xx ConfigFlags.WINDOW_MINIMIZED))
        {
            framesCounter+= 1;
            if (framesCounter >= 240) RestoreWindow(); // Restore window after 3 seconds
        }

        if (IsKeyPressed(xx KeyboardKey.M))
        {
            // NOTE: Requires xx ConfigFlags.WINDOW_RESIZABLE enabled!
            if (IsWindowState(xx ConfigFlags.WINDOW_MAXIMIZED)) RestoreWindow();
            else MaximizeWindow();
        }

        if (IsKeyPressed(xx KeyboardKey.U))
        {
            if (IsWindowState(xx ConfigFlags.WINDOW_UNFOCUSED)) ClearWindowState(xx ConfigFlags.WINDOW_UNFOCUSED);
            else SetWindowState(xx ConfigFlags.WINDOW_UNFOCUSED);
        }

        if (IsKeyPressed(xx KeyboardKey.T))
        {
            if (IsWindowState(xx ConfigFlags.WINDOW_TOPMOST)) ClearWindowState(xx ConfigFlags.WINDOW_TOPMOST);
            else SetWindowState(xx ConfigFlags.WINDOW_TOPMOST);
        }

        if (IsKeyPressed(xx KeyboardKey.A))
        {
            if (IsWindowState(xx ConfigFlags.WINDOW_ALWAYS_RUN)) ClearWindowState(xx ConfigFlags.WINDOW_ALWAYS_RUN);
            else SetWindowState(xx ConfigFlags.WINDOW_ALWAYS_RUN);
        }

        if (IsKeyPressed(xx KeyboardKey.V))
        {
            if (IsWindowState(xx ConfigFlags.VSYNC_HINT)) ClearWindowState(xx ConfigFlags.VSYNC_HINT);
            else SetWindowState(xx ConfigFlags.VSYNC_HINT);
        }

        // Bouncing ball logic
        ballPosition.x += ballSpeed.x;
        ballPosition.y += ballSpeed.y;
        if ((ballPosition.x >= xx (GetScreenWidth() - ballRadius))  || (ballPosition.x <= xx ballRadius)) ballSpeed.x *= -1.0;
        if ((ballPosition.y >= xx (GetScreenHeight() - ballRadius)) || (ballPosition.y <= xx ballRadius)) ballSpeed.y *= -1.0;
        //-----------------------------------------------------
        //-----------------------------------------------------
        BeginDrawing();

        if (IsWindowState(xx ConfigFlags.WINDOW_TRANSPARENT)) ClearBackground(BLANK);
        else ClearBackground(RAYWHITE);

        DrawCircleV(ballPosition, xx ballRadius, MAROON);
        DrawRectangleLinesEx(.{ 0, 0, cast(float) GetScreenWidth(), cast(float) GetScreenHeight() }, 4, RAYWHITE);

        DrawCircleV(GetMousePosition(), 10, DARKBLUE);

        DrawFPS(10, 10);

        DrawText(TextFormat("Screen Size: [%, %]", GetScreenWidth(), GetScreenHeight()), 10, 40, 10, GREEN);

        // Draw window state info
        DrawText("Following flags can be set after window creation:", 10, 60, 10, GRAY);
        if (IsWindowState(xx ConfigFlags.FULLSCREEN_MODE))    DrawText("[F] xx ConfigFlags.FULLSCREEN_MODE: on"     , 10, 80, 10, LIME);
        else                                                  DrawText("[F] xx ConfigFlags.FULLSCREEN_MODE: off"    , 10, 80, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_RESIZABLE))   DrawText("[R] xx ConfigFlags.WINDOW_RESIZABLE: on"    , 10, 100, 10, LIME);
        else                                                  DrawText("[R] xx ConfigFlags.WINDOW_RESIZABLE: off"   , 10, 100, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_UNDECORATED)) DrawText("[D] xx ConfigFlags.WINDOW_UNDECORATED: on"  , 10, 120, 10, LIME);
        else                                                  DrawText("[D] xx ConfigFlags.WINDOW_UNDECORATED: off" , 10, 120, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_HIDDEN))      DrawText("[H] xx ConfigFlags.WINDOW_HIDDEN: on"       , 10, 140, 10, LIME);
        else                                                  DrawText("[H] xx ConfigFlags.WINDOW_HIDDEN: off"      , 10, 140, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_MINIMIZED))   DrawText("[N] xx ConfigFlags.WINDOW_MINIMIZED: on"    , 10, 160, 10, LIME);
        else                                                  DrawText("[N] xx ConfigFlags.WINDOW_MINIMIZED: off"   , 10, 160, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_MAXIMIZED))   DrawText("[M] xx ConfigFlags.WINDOW_MAXIMIZED: on"    , 10, 180, 10, LIME);
        else                                                  DrawText("[M] xx ConfigFlags.WINDOW_MAXIMIZED: off"   , 10, 180, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_UNFOCUSED))          DrawText("[G] xx ConfigFlags.WINDOW_UNFOCUSED: on"           , 10, 200, 10, LIME);
        else                                                  DrawText("[U] xx ConfigFlags.WINDOW_UNFOCUSED: off"          , 10, 200, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_TOPMOST))     DrawText("[T] xx ConfigFlags.WINDOW_TOPMOST: on"      , 10, 220, 10, LIME);
        else                                                  DrawText("[T] xx ConfigFlags.WINDOW_TOPMOST: off"     , 10, 220, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_ALWAYS_RUN))  DrawText("[A] xx ConfigFlags.WINDOW_ALWAYS_RUN: on"   , 10, 240, 10, LIME);
        else                                                  DrawText("[A] xx ConfigFlags.WINDOW_ALWAYS_RUN: off"  , 10, 240, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.VSYNC_HINT))         DrawText("[V] xx ConfigFlags.VSYNC_HINT: on"          , 10, 260, 10, LIME);
        else                                                  DrawText("[V] xx ConfigFlags.VSYNC_HINT: off"         , 10, 260, 10, MAROON);

        DrawText("Following flags can only be set before window creation:", 10, 300, 10, GRAY);
        if (IsWindowState(xx ConfigFlags.WINDOW_HIGHDPI))     DrawText("xx ConfigFlags.WINDOW_HIGHDPI: on"          , 10, 320, 10, LIME);
        else                                                  DrawText("xx ConfigFlags.WINDOW_HIGHDPI: off"         , 10, 320, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.WINDOW_TRANSPARENT)) DrawText("xx ConfigFlags.WINDOW_TRANSPARENT: on"      , 10, 340, 10, LIME);
        else                                                  DrawText("xx ConfigFlags.WINDOW_TRANSPARENT: off"     , 10, 340, 10, MAROON);
        if (IsWindowState(xx ConfigFlags.MSAA_4X_HINT))       DrawText("xx ConfigFlags.MSAA_4X_HINT: on"            , 10, 360, 10, LIME);
        else                                                  DrawText("xx ConfigFlags.MSAA_4X_HINT: off"           , 10, 360, 10, MAROON);

        EndDrawing();
    }

    CloseWindow();
}