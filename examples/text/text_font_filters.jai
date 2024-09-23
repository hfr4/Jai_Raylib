/* ******************************************************************************************
*
*   raylib [text] example - Font filters
*
*   NOTE: After font loading, font texture atlas filter could be configured for a softer
*   display of the font when scaling it to different sizes, that way, it's not required
*   to generate multiple fonts at multiple sizes (as long as the scaling is not very different)
*
*   Example originally created with raylib 1.3, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - font filters");

    msg := "Loaded Font";

    // TTF Font loading with custom generation parameters
    font := LoadFontEx("resources/KAISG.ttf", 96, null, 0);

    // Generate mipmap levels to use trilinear filtering
    // NOTE: On 2D drawing it won't be noticeable, it looks like FILTER_BILINEAR
    GenTextureMipmaps(*font.texture);

    fontSize     := cast(float) font.baseSize;
    fontPosition := Vector2.{ 40.0, SCREEN_HEIGHT/2.0 - 80.0 };
    textSize     := Vector2.{ 0.0, 0.0 };

    // Setup texture scaling filter
    SetTextureFilter(font.texture, xx TextureFilter.POINT);
    currentFontFilter := 0;      // TEXTURE_FILTER_POINT

    SetTargetFPS(60);

    while !WindowShouldClose() {
        fontSize += GetMouseWheelMove() * 4.0;

        // Choose font texture filter method
        if (IsKeyPressed(xx KeyboardKey.ONE))
        {
            SetTextureFilter(font.texture, xx TextureFilter.POINT);
            currentFontFilter = 0;
        }
        else if (IsKeyPressed(xx KeyboardKey.TWO))
        {
            SetTextureFilter(font.texture, xx TextureFilter.BILINEAR);
            currentFontFilter = 1;
        }
        else if (IsKeyPressed(xx KeyboardKey.THREE))
        {
            // NOTE: Trilinear filter won't be noticed on 2D drawing
            SetTextureFilter(font.texture, xx TextureFilter.TRILINEAR);
            currentFontFilter = 2;
        }

        textSize = MeasureTextEx(font, msg.data, fontSize, 0);

        if      (IsKeyDown(xx KeyboardKey.LEFT))  fontPosition.x -= 10;
        else if (IsKeyDown(xx KeyboardKey.RIGHT)) fontPosition.x += 10;

        // Load a dropped TTF file dynamically (at current fontSize)
        if (IsFileDropped())
        {
            droppedFiles := LoadDroppedFiles();

            // NOTE: We only support first ttf file dropped
            if (IsFileExtension(droppedFiles.paths[0], ".ttf"))
            {
                UnloadFont(font);
                font = LoadFontEx(droppedFiles.paths[0], cast(s32) fontSize, null, 0);
            }

            UnloadDroppedFiles(droppedFiles);
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("Use mouse wheel to change font size", 20, 20, 10, GRAY);
            DrawText("Use xx KeyboardKey.RIGHT and xx KeyboardKey.LEFT to move text", 20, 40, 10, GRAY);
            DrawText("Use 1, 2, 3 to change texture filter", 20, 60, 10, GRAY);
            DrawText("Drop a new TTF font for dynamic loading", 20, 80, 10, DARKGRAY);

            DrawTextEx(font, msg.data, fontPosition, fontSize, 0, BLACK);

            // TODO: It seems texSize measurement is not accurate due to chars offsets...
            //DrawRectangleLines(fontPosition.x, fontPosition.y, textSize.x, textSize.y, RED);

            DrawRectangle(0, SCREEN_HEIGHT - 80, SCREEN_WIDTH, 80, LIGHTGRAY);
            DrawText(TextFormat("Font size: %02.02", fontSize), 20, SCREEN_HEIGHT - 50, 10, DARKGRAY);
            DrawText(TextFormat("Text size: [%02.02, %02.02]", textSize.x, textSize.y), 20, SCREEN_HEIGHT - 30, 10, DARKGRAY);
            DrawText("CURRENT TEXTURE FILTER:", 250, 400, 20, GRAY);

            if      (currentFontFilter == 0) DrawText("POINT"    , 570, 400, 20, BLACK);
            else if (currentFontFilter == 1) DrawText("BILINEAR" , 570, 400, 20, BLACK);
            else if (currentFontFilter == 2) DrawText("TRILINEAR", 570, 400, 20, BLACK);

        EndDrawing();
    }

    UnloadFont(font);

    CloseWindow();
}