/* ******************************************************************************************
*
*   raylib [text] example - Codepoints loading
*
*   Example originally created with raylib 4.2, last time updated with raylib 2.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

// Text to be displayed, must be UTF-8 (save this code file as UTF-8)
// NOTE: It can contain all the required text for the game,
// this text will be scanned to get all the required codepoints
text :: "いろはにほへと　ちりぬるを\nわかよたれそ　つねならむ\nうゐのおくやま　けふこえて\nあさきゆめみし　ゑひもせす";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - codepoints loading");

    // Get codepoints from text
    codepointCount : s32 = 0;
    codepoints := LoadCodepoints(text, *codepointCount);

    // Removed duplicate codepoints to generate smaller font atlas
    codepointsNoDupsCount : s32 = 0;
    codepointsNoDups := CodepointRemoveDuplicates(codepoints, codepointCount, *codepointsNoDupsCount);
    UnloadCodepoints(codepoints);

    // Load font containing all the provided codepoint glyphs
    // A texture font atlas is automatically generated
    font := LoadFontEx("resources/DotGothic16-Regular.ttf", 36, codepointsNoDups, codepointsNoDupsCount);

    // Set bilinear scale filter for better font scaling
    SetTextureFilter(font.texture, xx TextureFilter.BILINEAR);

    // Set line spacing for multiline text when line breaks are included \n
    SetTextLineSpacing(20);

    // Free codepoints, atlas has already been generated
    free(codepointsNoDups);

    showFontAtlas := false;

    codepointSize : s32 = 0;
    ptr := text.data;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyPressed(xx KeyboardKey.SPACE)) showFontAtlas = !showFontAtlas;

        // Testing code: getting next and previous codepoints on provided text
        if (IsKeyPressed(xx KeyboardKey.RIGHT))
        {
            // Get next codepoint in string and move pointer
            GetCodepointNext(ptr, *codepointSize);
            ptr += codepointSize;
        }
        else if (IsKeyPressed(xx KeyboardKey.LEFT))
        {
            // Get previous codepoint in string and move pointer
            GetCodepointPrevious(ptr, *codepointSize);
            ptr -= codepointSize;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawRectangle(0, 0, GetScreenWidth(), 70, BLACK);
            DrawText(TextFormat("Total codepoints contained in provided text: %", codepointCount), 10, 10, 20, GREEN);
            DrawText(TextFormat("Total codepoints required for font atlas (duplicates excluded): %", codepointsNoDupsCount), 10, 40, 20, GREEN);

            if (showFontAtlas)
            {
                // Draw generated font texture atlas containing provided codepoints
                DrawTexture(font.texture, 150, 100, BLACK);
                DrawRectangleLines(150, 100, font.texture.width, font.texture.height, BLACK);
            }
            else
            {
                // Draw provided text with loaded font, containing all required codepoint glyphs
                DrawTextEx(font, text, .{ 160, 110 }, 48, 5, BLACK);
            }

            DrawText("Press SPACE to toggle font atlas view!", 10, GetScreenHeight() - 30, 20, GRAY);

        EndDrawing();
    }
    UnloadFont(font);     // Unload font

    CloseWindow();
}

// Remove codepoint duplicates if requested
// WARNING: This process could be a bit slow if there text to process is very long
CodepointRemoveDuplicates :: (codepoints: *s32, codepointCount: s32, codepointsResultCount: *s32) -> *s32 {
    codepointsNoDupsCount := codepointCount;
    codepointsNoDups := cast(*s32) alloc(codepointCount * size_of(s32));
    memcpy(codepointsNoDups, codepoints, codepointCount * size_of(s32));

    // Remove duplicates
    for i: 0..codepointsNoDupsCount - 1
    {
        for j: i + 1..codepointsNoDupsCount - 2
        {
            if codepointsNoDups[i] == codepointsNoDups[j]
            {
                for k: j..codepointsNoDupsCount - 1 codepointsNoDups[k] = codepointsNoDups[k + 1];

                codepointsNoDupsCount -= 1;
                j -= 1;
            }
        }
    }

    // NOTE: The size of codepointsNoDups is the same as original array but
    // only required positions are filled (codepointsNoDupsCount)

    codepointsResultCount.* = codepointsNoDupsCount;
    return codepointsNoDups;
}