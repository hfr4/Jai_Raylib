/* ******************************************************************************************
*
*   raylib [text] example - Font SDF loading
*
*   Example originally created with raylib 1.3, last time updated with raylib 4.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - SDF fonts");

    msg := "Signed Distance Fields";

    fileSize : s32 = 0;
    fileData := LoadFileData("resources/anonymous_pro_bold.ttf", *fileSize);

    fontDefault: Font;
    fontDefault.baseSize   = 16;
    fontDefault.glyphCount = 95;

    // Loading font data from memory data
    // Parameters > font size: 16, no glyphs array provided (0), glyphs count: 95 (autogenerate chars array)
    fontDefault.glyphs = LoadFontData(fileData, fileSize, 16, null, 95, xx FontType.DEFAULT);
    // Parameters > glyphs count: 95, font size: 16, glyphs padding in image: 4 px, pack method: 0 (default)
    atlas := GenImageFontAtlas(fontDefault.glyphs, *fontDefault.recs, 95, 16, 4, 0);
    fontDefault.texture = LoadTextureFromImage(atlas);
    UnloadImage(atlas);

    // SDF font generation from TTF font
    fontSDF: Font;
    fontSDF.baseSize   = 16;
    fontSDF.glyphCount = 95;
    // Parameters > font size: 16, no glyphs array provided (0), glyphs count: 0 (defaults to 95)
    fontSDF.glyphs = LoadFontData(fileData, fileSize, 16, null, 0, xx FontType.SDF);
    // Parameters > glyphs count: 95, font size: 16, glyphs padding in image: 0 px, pack method: 1 (Skyline algorythm)
    atlas = GenImageFontAtlas(fontSDF.glyphs, *fontSDF.recs, 95, 16, 0, 1);
    fontSDF.texture = LoadTextureFromImage(atlas);
    UnloadImage(atlas);

    UnloadFileData(fileData);

    // Load SDF required shader (we use default vertex shader)
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/sdf.fs", GLSL_VERSION));
    SetTextureFilter(fontSDF.texture, xx TextureFilter.BILINEAR);    // Required for SDF font

    fontPosition := Vector2.{ 40, SCREEN_HEIGHT/2.0 - 50 };
    textSize := Vector2.{ 0.0, 0.0 };
    fontSize := 16.0;
    currentFont := 0;            // 0 - fontDefault, 1 - fontSDF

    SetTargetFPS(60);

    while !WindowShouldClose() {
        fontSize += GetMouseWheelMove()*8.0;

        if (fontSize < 6) fontSize = 6;

        if (IsKeyDown(xx KeyboardKey.SPACE)) currentFont = 1;
        else                                 currentFont = 0;

        if (currentFont == 0) textSize = MeasureTextEx(fontDefault, msg.data, fontSize, 0);
        else                  textSize = MeasureTextEx(fontSDF    , msg.data, fontSize, 0);

        fontPosition.x = GetScreenWidth() / 2  - textSize.x / 2;
        fontPosition.y = GetScreenHeight() / 2 - textSize.y / 2 + 80;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (currentFont == 1) {
                // NOTE: SDF fonts require a custom SDf shader to compute fragment color
                BeginShaderMode(shader);    // Activate SDF font shader
                    DrawTextEx(fontSDF, msg.data, fontPosition, fontSize, 0, BLACK);
                EndShaderMode();            // Activate our default shader for next drawings

                DrawTexture(fontSDF.texture, 10, 10, BLACK);
            } else {
                DrawTextEx(fontDefault, msg.data, fontPosition, fontSize, 0, BLACK);
                DrawTexture(fontDefault.texture, 10, 10, BLACK);
            }

            if (currentFont == 1) DrawText("SDF!"        , 320, 20, 80, RED);
            else                  DrawText("default font", 315, 40, 30, GRAY);

            DrawText("FONT SIZE: 16.0", GetScreenWidth() - 240, 20, 20, DARKGRAY);
            DrawText(TextFormat("RENDER SIZE: %", fontSize), GetScreenWidth() - 240, 50, 20, DARKGRAY);
            DrawText("Use MOUSE WHEEL to SCALE TEXT!", GetScreenWidth() - 240, 90, 10, DARKGRAY);

            DrawText("HOLD SPACE to USE SDF FONT VERSION!", 340, GetScreenHeight() - 30, 20, MAROON);

        EndDrawing();
    }
    UnloadFont(fontDefault);
    UnloadFont(fontSDF);

    UnloadShader(shader);

    CloseWindow();
}