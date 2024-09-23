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
    bg := LoadTexture("resources/cyberpunk_street_background.png");
    mg := LoadTexture("resources/cyberpunk_street_midground.png");
    fg := LoadTexture("resources/cyberpunk_street_foreground.png");

    scrollingBg := 0.0;
    scrollingMg := 0.0;
    scrollingFg := 0.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {
        scrollingBg -= 0.1;
        scrollingMg -= 0.5;
        scrollingFg -= 1.0;

        // NOTE: Texture is scaled twice its size, so it sould be considered on scrolling
        if (scrollingBg <= -bg.width * 2.0) scrollingBg = 0;
        if (scrollingMg <= -mg.width * 2.0) scrollingMg = 0;
        if (scrollingFg <= -fg.width * 2.0) scrollingFg = 0;

        BeginDrawing();

            ClearBackground(GetColor(0x052c46ff));

            // Draw bg image twice
            // NOTE: Texture is scaled twice its size
            DrawTextureEx(bg, .{ scrollingBg               , 20 }, 0.0, 2.0, WHITE);
            DrawTextureEx(bg, .{ scrollingBg + bg.width * 2, 20 }, 0.0, 2.0, WHITE);

            // Draw mg image twice
            DrawTextureEx(mg, .{ scrollingMg               , 20 }, 0.0, 2.0, WHITE);
            DrawTextureEx(mg, .{ scrollingMg + mg.width * 2, 20 }, 0.0, 2.0, WHITE);

            // Draw fg image twice
            DrawTextureEx(fg, .{ scrollingFg               , 70 }, 0.0, 2.0, WHITE);
            DrawTextureEx(fg, .{ scrollingFg + fg.width * 2, 70 }, 0.0, 2.0, WHITE);

            DrawText("BACKGROUND SCROLLING & PARALLAX", 10, 10, 20, RED);
            DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)", SCREEN_WIDTH - 330, SCREEN_HEIGHT - 20, 10, RAYWHITE);

        EndDrawing();
    }

    UnloadTexture(bg);
    UnloadTexture(mg);
    UnloadTexture(fg);

    CloseWindow();
}