/* ******************************************************************************************
*
*   raylib [textures] example - blend modes
*
*   NOTE: Images are loaded in CPU memory (RAM); textures are loaded in GPU memory (VRAM)
*
*   Example originally created with raylib 3.5, last time updated with raylib 3.5
*
*   Example contributed by Karlo Licudine (@accidentalrebel) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2020-2024 Karlo Licudine (@accidentalrebel)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - blend modes");

    // NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
    bgImage   := LoadImage("resources/cyberpunk_street_background.png");     // Loaded in CPU memory (RAM)
    bgTexture := LoadTextureFromImage(bgImage);                              // Image converted to texture, GPU memory (VRAM)

    fgImage   := LoadImage("resources/cyberpunk_street_foreground.png");     // Loaded in CPU memory (RAM)
    fgTexture := LoadTextureFromImage(fgImage);                              // Image converted to texture, GPU memory (VRAM)

    // Once image has been converted to texture and uploaded to VRAM, it can be unloaded from RAM
    UnloadImage(bgImage);
    UnloadImage(fgImage);

    blendCountMax := 4;
    blendMode: BlendMode;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyPressed(xx KeyboardKey.SPACE))
        {
            if (xx blendMode >= (blendCountMax - 1)) blendMode =  xx 0;
            else                                     blendMode += xx 1;
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexture(bgTexture, SCREEN_WIDTH/2 - bgTexture.width/2, SCREEN_HEIGHT/2 - bgTexture.height/2, WHITE);

            // Apply the blend mode and then draw the foreground texture
            BeginBlendMode(xx blendMode);
                DrawTexture(fgTexture, SCREEN_WIDTH/2 - fgTexture.width/2, SCREEN_HEIGHT/2 - fgTexture.height/2, WHITE);
            EndBlendMode();

            // Draw the texts
            DrawText("Press SPACE to change blend modes.", 310, 350, 10, GRAY);

            if blendMode == {
                case .ALPHA;      DrawText("Current: BLEND_ALPHA"     , (SCREEN_WIDTH / 2) - 60, 370, 10, GRAY);
                case .ADDITIVE;   DrawText("Current: BLEND_ADDITIVE"  , (SCREEN_WIDTH / 2) - 60, 370, 10, GRAY);
                case .MULTIPLIED; DrawText("Current: BLEND_MULTIPLIED", (SCREEN_WIDTH / 2) - 60, 370, 10, GRAY);
                case .ADD_COLORS; DrawText("Current: BLEND_ADD_COLORS", (SCREEN_WIDTH / 2) - 60, 370, 10, GRAY);
            }

            DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", SCREEN_WIDTH - 330, SCREEN_HEIGHT - 20, 10, GRAY);

        EndDrawing();
    }

    UnloadTexture(fgTexture); // Unload foreground texture
    UnloadTexture(bgTexture); // Unload background texture

    CloseWindow();
}
