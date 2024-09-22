/* ******************************************************************************************
*
*   raylib [textures] example - Background scrolling
*
*   Example originally created with raylib 2.0, last time updated with raylib 2.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - background scrolling");

    // NOTE: Be careful, background width must be equal or bigger than screen width
    // if not, texture should be draw more than two times for scrolling effect
    background := LoadTexture("resources/cyberpunk_street_background.png");
    midground  := LoadTexture("resources/cyberpunk_street_midground.png");
    foreground := LoadTexture("resources/cyberpunk_street_foreground.png");

    scrollingBack := 0.0;
    scrollingMid  := 0.0;
    scrollingFore := 0.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        scrollingBack -= 0.1;
        scrollingMid  -= 0.5;
        scrollingFore -= 1.0;

        // NOTE: Texture is scaled twice its size, so it sould be considered on scrolling
        if (scrollingBack <= -background.width * 2.0) scrollingBack = 0;
        if (scrollingMid  <= -midground.width  * 2.0) scrollingMid  = 0;
        if (scrollingFore <= -foreground.width * 2.0) scrollingFore = 0;


        // Draw

        BeginDrawing();

            ClearBackground(GetColor(0x052c46ff));

            // Draw background image twice
            // NOTE: Texture is scaled twice its size
            DrawTextureEx(background, .{ scrollingBack, 20 }, 0.0, 2.0, WHITE);
            DrawTextureEx(background, .{ background.width*2 + scrollingBack, 20 }, 0.0, 2.0, WHITE);

            // Draw midground image twice
            DrawTextureEx(midground, .{ scrollingMid, 20 }, 0.0, 2.0, WHITE);
            DrawTextureEx(midground, .{ midground.width*2 + scrollingMid, 20 }, 0.0, 2.0, WHITE);

            // Draw foreground image twice
            DrawTextureEx(foreground, .{ scrollingFore, 70 }, 0.0, 2.0, WHITE);
            DrawTextureEx(foreground, .{ foreground.width*2 + scrollingFore, 70 }, 0.0, 2.0, WHITE);

            DrawText("BACKGROUND SCROLLING & PARALLAX", 10, 10, 20, RED);
            DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", SCREEN_WIDTH - 330, SCREEN_HEIGHT - 20, 10, RAYWHITE);

        EndDrawing();
    }
    // De-Initialization
    UnloadTexture(background);  // Unload background texture
    UnloadTexture(midground);   // Unload midground texture
    UnloadTexture(foreground);  // Unload foreground texture

    CloseWindow();              // Close window and OpenGL context
}