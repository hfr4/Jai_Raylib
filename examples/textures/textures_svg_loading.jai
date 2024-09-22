/* ******************************************************************************************
*
*   raylib [textures] example - SVG loading and texture creation
*
*   NOTE: Images are loaded in CPU memory (RAM); textures are loaded in GPU memory (VRAM)
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022 Dennis Meinen (@bixxy#4258 on Discord)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - svg loading");

    // NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)

    image := LoadImageSvg("resources/test.svg", 400, 350);     // Loaded in CPU memory (RAM)
    texture := LoadTextureFromImage(image);          // Image converted to texture, GPU memory (VRAM)
    UnloadImage(image);   // Once image has been converted to texture and uploaded to VRAM, it can be unloaded from RAM

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // TODO: Update your variables here


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexture(texture, SCREEN_WIDTH/2 - texture.width/2, SCREEN_HEIGHT/2 - texture.height/2, BLACK);

            //Red border to illustrate how the SVG is centered within the specified dimensions
            DrawRectangleLines((SCREEN_WIDTH / 2 - texture.width / 2) - 1, (SCREEN_HEIGHT / 2 - texture.height / 2) - 1, texture.width + 2, texture.height + 2, RED);

            DrawText("this IS a texture loaded from an SVG file!", 300, 410, 10, GRAY);

        EndDrawing();
    }

    UnloadTexture(texture);       // Texture unloading

    CloseWindow();
}