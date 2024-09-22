/* ******************************************************************************************
*
*   raylib [texture] example - Image text drawing using TTF generated font
*
*   Example originally created with raylib 1.8, last time updated with raylib 4.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [texture] example - image text drawing");

    parrots := LoadImage("resources/parrots.png"); // Load image in CPU memory (RAM)

    // TTF Font loading with custom generation parameters
    font := LoadFontEx("resources/KAISG.ttf", 64, null, 0);

    // Draw over image using custom font
    ImageDrawTextEx(*parrots, font, "[Parrots font drawing]", .{ 20.0, 20.0 }, cast(float)font.baseSize, 0.0, RED);

    texture := LoadTextureFromImage(parrots);  // Image converted to texture, uploaded to GPU memory (VRAM)
    UnloadImage(parrots);   // Once image has been converted to texture and uploaded to VRAM, it can be unloaded from RAM

    position := Vector2.{ cast(float)(SCREEN_WIDTH/2 - texture.width/2), cast(float)(SCREEN_HEIGHT/2 - texture.height/2 - 20) };

    showFont := false;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyDown(xx KeyboardKey.SPACE)) showFont = true;
        else                                 showFont = false;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (!showFont)
            {
                // Draw texture with text already drawn inside
                DrawTextureV(texture, position, WHITE);

                // Draw text directly using sprite font
                DrawTextEx(font, "[Parrots font drawing]", .{ position.x + 20,
                           position.y + 20 + 280 }, cast(float)font.baseSize, 0.0, WHITE);
            }
            else DrawTexture(font.texture, SCREEN_WIDTH/2 - font.texture.width/2, 50, BLACK);

            DrawText("PRESS SPACE to SHOW FONT ATLAS USED", 290, 420, 10, DARKGRAY);

        EndDrawing();
    }
    UnloadTexture(texture);     // Texture unloading

    UnloadFont(font);           // Unload custom font

    CloseWindow();
}