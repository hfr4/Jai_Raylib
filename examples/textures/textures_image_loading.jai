/* ******************************************************************************************
*
*   raylib [textures] example - Image loading and texture creation
*
*   NOTE: Images are loaded in CPU memory (RAM); textures are loaded in GPU memory (VRAM)
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.3
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - image loading");

    image   := LoadImage("resources/raylib_logo.png");
    texture := LoadTextureFromImage(image);
    UnloadImage(image);

    SetTargetFPS(60);

    while !WindowShouldClose() {

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexture(texture, SCREEN_WIDTH/2 - texture.width/2, SCREEN_HEIGHT/2 - texture.height/2, WHITE);

            DrawText("this IS a texture loaded from an image!", 300, 370, 10, GRAY);

        EndDrawing();
    }

    UnloadTexture(texture);

    CloseWindow();
}