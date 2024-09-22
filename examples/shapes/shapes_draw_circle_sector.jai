/* ******************************************************************************************
*
*   raylib [shapes] example - draw circle sector (with gui options)
*
*   Example originally created with raylib 2.5, last time updated with raylib 2.5
*
*   Example contributed by Vlad Adrian (@demizdor) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2024 Vlad Adrian (@demizdor) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - draw circle sector");

    center := Vector2.{ (GetScreenWidth() - 300)/2.0, GetScreenHeight()/2.0 };

    outerRadius := 180.0;
    startAngle := 0.0;
    endAngle := 180.0;
    segments := 10.0;
    minSegments : s32 = 4;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // NOTE: All variables update happens inside GUI control functions


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawLine(500, 0, 500, GetScreenHeight(), Fade(LIGHTGRAY, 0.6));
            DrawRectangle(500, 0, GetScreenWidth() - 500, GetScreenHeight(), Fade(LIGHTGRAY, 0.3));

            DrawCircleSector(center, outerRadius, startAngle, endAngle, cast(s32) segments, Fade(MAROON, 0.3));
            DrawCircleSectorLines(center, outerRadius, startAngle, endAngle, cast(s32) segments, Fade(MAROON, 0.6));

            // Draw GUI controls
            //------------------------------------------------------------------------------
            GuiSliderBar(.{ 600, 40 , 120, 20}, "StartAngle", TextFormat("%", startAngle) , *startAngle , 0, 720);
            GuiSliderBar(.{ 600, 70 , 120, 20}, "EndAngle"  , TextFormat("%", endAngle)   , *endAngle   , 0, 720);
            GuiSliderBar(.{ 600, 140, 120, 20}, "Radius"    , TextFormat("%", outerRadius), *outerRadius, 0, 200);
            GuiSliderBar(.{ 600, 170, 120, 20}, "Segments"  , TextFormat("%", segments)   , *segments   , 0, 100);
            //------------------------------------------------------------------------------

            minSegments = cast,trunc(s32) Math.ceil((endAngle - startAngle) / 90);
            DrawText(TextFormat("MODE: %", ifx (segments >= xx minSegments) then "MANUAL" else "AUTO"), 600, 200, 10, ifx (segments >= xx minSegments) then MAROON else DARKGRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }

    CloseWindow();
}