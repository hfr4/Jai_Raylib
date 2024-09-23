/* ******************************************************************************************
*
*   raylib [shapes] example - Colors palette
*
*   Example originally created with raylib 1.0, last time updated with raylib 2.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_COLORS_COUNT :: 21;          // Number of colors available

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - colors palette");

    colors: [MAX_COLORS_COUNT] Color = .[
        DARKGRAY, MAROON, ORANGE, DARKGREEN, DARKBLUE, DARKPURPLE, DARKBROWN,
        GRAY, RED, GOLD, LIME, BLUE, VIOLET, BROWN, LIGHTGRAY, PINK, YELLOW,
        GREEN, SKYBLUE, PURPLE, BEIGE ];

    colorNames: [MAX_COLORS_COUNT] string = .[
        "DARKGRAY", "MAROON", "ORANGE", "DARKGREEN", "DARKBLUE", "DARKPURPLE",
        "DARKBROWN", "GRAY", "RED", "GOLD", "LIME", "BLUE", "VIOLET", "BROWN",
        "LIGHTGRAY", "PINK", "YELLOW", "GREEN", "SKYBLUE", "PURPLE", "BEIGE" ];

    colorsRecs: [MAX_COLORS_COUNT] Rectangle;     // Rectangles array

    // Fills colorsRecs data (for every rectangle)
    for i: 0..MAX_COLORS_COUNT - 1
    {
        colorsRecs[i].x      = 20.0 + 100.0 *(i%7) + 10.0 *(i%7);
        colorsRecs[i].y      = 80.0 + 100.0 *(i/7) + 10.0 *(i/7);
        colorsRecs[i].width  = 100.0;
        colorsRecs[i].height = 100.0;
    }

    colorState: [MAX_COLORS_COUNT] int;           // Color state: 0-DEFAULT, 1-MOUSE_HOVER

    SetTargetFPS(60);

    while !WindowShouldClose() {

        mousePoint := GetMousePosition();

        for i: 0..MAX_COLORS_COUNT - 1
        {
            if (CheckCollisionPointRec(mousePoint, colorsRecs[i])) colorState[i] = 1;
            else colorState[i] = 0;
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("raylib colors palette", 28, 42, 20, BLACK);
            DrawText("press SPACE to see all colors", GetScreenWidth() - 180, GetScreenHeight() - 40, 10, GRAY);

            for i: 0..MAX_COLORS_COUNT - 1    // Draw all rectangles
            {
                DrawRectangleRec(colorsRecs[i], Fade(colors[i], ifx colorState[i] then 0.6 else 1.0));

                if (IsKeyDown(xx KeyboardKey.SPACE) || colorState[i])
                {
                    DrawRectangle(cast(s32) colorsRecs[i].x, cast(s32) (colorsRecs[i].y + colorsRecs[i].height - 26), cast(s32) colorsRecs[i].width, 20, BLACK);
                    DrawRectangleLinesEx(colorsRecs[i], 6, Fade(BLACK, 0.3));
                    DrawText(colorNames[i].data, cast(s32) (colorsRecs[i].x + colorsRecs[i].width - MeasureText(colorNames[i].data, 10) - 12),
                        cast(s32) (colorsRecs[i].y + colorsRecs[i].height - 20), 10, colors[i]);
                }
            }

        EndDrawing();
    }

    CloseWindow();
}