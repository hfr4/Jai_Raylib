/* ******************************************************************************************
*
*   raylib [text] example - Sprite font loading
*
*   NOTE: Sprite fonts should be generated following this conventions:
*
*     - Characters must be ordered starting with character 32 (Space)
*     - Every character must be contained within the same Rectangle height
*     - Every character and every line must be separated by the same distance (margin/padding)
*     - Rectangles must be defined by a MAGENTA color background
*
*   Following those constraints, a font can be provided just by an image,
*   this is quite handy to avoid additional font descriptor files (like BMFonts use).
*
*   Example originally created with raylib 1.0, last time updated with raylib 1.0
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - sprite font loading");

    msg1 := "THIS IS A custom SPRITE FONT...";
    msg2 := "...and this is ANOTHER CUSTOM font...";
    msg3 := "...and a THIRD one! GREAT! :D";

    font1 := LoadFont("resources/custom_mecha.png");
    font2 := LoadFont("resources/custom_alagard.png");
    font3 := LoadFont("resources/custom_jupiter_crash.png");

    fontPosition1 := Vector2.{
        SCREEN_WIDTH  / 2.0 - MeasureTextEx(font1, msg1.data, cast(float) font1.baseSize, -3.0).x / 2.0,
        SCREEN_HEIGHT / 2.0 - font1.baseSize / 2.0 - 80.0,
    };

    fontPosition2 := Vector2.{
        SCREEN_WIDTH  / 2.0 - MeasureTextEx(font2, msg2.data, cast(float) font2.baseSize, -2.0).x / 2.0,
        SCREEN_HEIGHT / 2.0 - font2.baseSize / 2.0 - 10.0,
    };

    fontPosition3 := Vector2.{
        SCREEN_WIDTH  / 2.0 - MeasureTextEx(font3, msg3.data, cast(float) font3.baseSize,  2.0).x / 2.0,
        SCREEN_HEIGHT / 2.0 - font3.baseSize / 2.0 + 50.0,
    };

    SetTargetFPS(60);

    while !WindowShouldClose() {

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTextEx(font1, msg1.data, fontPosition1, cast(float) font1.baseSize, -3, WHITE);
            DrawTextEx(font2, msg2.data, fontPosition2, cast(float) font2.baseSize, -2, WHITE);
            DrawTextEx(font3, msg3.data, fontPosition3, cast(float) font3.baseSize,  2, WHITE);

        EndDrawing();
    }
    UnloadFont(font1);
    UnloadFont(font2);
    UnloadFont(font3);

    CloseWindow();
}