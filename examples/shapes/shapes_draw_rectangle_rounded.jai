/* ******************************************************************************************
*
*   raylib [shapes] example - draw rectangle rounded (with gui options)
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

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - draw rectangle rounded");

    roundness := 0.2;
    width := 200.0;
    height := 100.0;
    segments := 0.0;
    lineThick := 1.0;

    drawRect := false;
    drawRoundedRect := true;
    drawRoundedLines := false;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        rec := Rectangle.{ (cast(float) GetScreenWidth() - width - 250)/2, (GetScreenHeight() - height)/2.0, cast(float) width, cast(float) height };

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawLine(560, 0, 560, GetScreenHeight(), Fade(LIGHTGRAY, 0.6));
            DrawRectangle(560, 0, GetScreenWidth() - 500, GetScreenHeight(), Fade(LIGHTGRAY, 0.3));

            if (drawRect)         DrawRectangleRec(rec, Fade(GOLD, 0.6));
            if (drawRoundedRect)  DrawRectangleRounded(rec, roundness, cast(s32) segments, Fade(MAROON, 0.2));
            // if (drawRoundedLines) DrawRectangleRoundedLinesEx(rec, roundness, cast(s32) segments, lineThick, Fade(MAROON, 0.4));

            // Draw GUI controls
            //------------------------------------------------------------------------------
            GuiSliderBar(.{ 640, 40 , 105, 20 }, "Width"    , TextFormat("%", width)    , *width    , 0, cast(float) GetScreenWidth() - 300);
            GuiSliderBar(.{ 640, 70 , 105, 20 }, "Height"   , TextFormat("%", height)   , *height   , 0, cast(float) GetScreenHeight() - 50);
            GuiSliderBar(.{ 640, 140, 105, 20 }, "Roundness", TextFormat("%", roundness), *roundness, 0.0, 1.0);
            GuiSliderBar(.{ 640, 170, 105, 20 }, "Thickness", TextFormat("%", lineThick), *lineThick, 0, 20);
            GuiSliderBar(.{ 640, 240, 105, 20 }, "Segments" , TextFormat("%", segments) , *segments , 0, 60);

            GuiCheckBox(.{ 640, 320, 20, 20 }, "DrawRoundedRect" , *drawRoundedRect);
            GuiCheckBox(.{ 640, 350, 20, 20 }, "DrawRoundedLines", *drawRoundedLines);
            GuiCheckBox(.{ 640, 380, 20, 20 }, "DrawRect"        , *drawRect);
            //------------------------------------------------------------------------------

            DrawText(TextFormat("MODE: %", ifx (segments >= 4) then "MANUAL" else "AUTO"), 640, 280, 10, ifx (segments >= 4) then MAROON else DARKGRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }
    CloseWindow();
}