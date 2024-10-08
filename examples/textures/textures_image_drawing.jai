/* ******************************************************************************************
*
*   raylib [textures] example - Image loading and drawing on it
*
*   NOTE: Images are loaded in CPU memory (RAM); textures are loaded in GPU memory (VRAM)
*
*   Example originally created with raylib 1.4, last time updated with raylib 1.4
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2016-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - image drawing");

    cat := LoadImage("resources/cat.png");
    ImageCrop(*cat, .{ 100, 10, 280, 380 });
    ImageFlipHorizontal(*cat);
    ImageResize(*cat, 150, 200);

    parrots := LoadImage("resources/parrots.png");

    // Draw one image over the other with a scaling of 1.5
    ImageDraw(*parrots, cat, .{ 0, 0, cast(float) cat.width, cast(float) cat.height }, .{ 30, 40, cat.width*1.5, cat.height*1.5 }, WHITE);
    ImageCrop(*parrots, .{ 0, 50, cast(float) parrots.width, cast(float) parrots.height - 100 });

    // Draw on the image with a few image draw methods
    ImageDrawPixel(*parrots, 10, 10, RAYWHITE);
    ImageDrawCircleLines(*parrots, 10, 10, 5, RAYWHITE);
    ImageDrawRectangle(*parrots, 5, 20, 10, 10, RAYWHITE);

    UnloadImage(cat);

    // Load custom font for frawing on image
    font := LoadFont("resources/custom_jupiter_crash.png");

    // Draw over image using custom font
    ImageDrawTextEx(*parrots, font, "PARROTS & CAT", .{ 300, 230 }, cast(float) font.baseSize, -2, WHITE);

    UnloadFont(font);

    texture := LoadTextureFromImage(parrots);
    UnloadImage(parrots);

    SetTargetFPS(60);

    while !WindowShouldClose() {

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexture(texture, SCREEN_WIDTH/2 - texture.width/2, SCREEN_HEIGHT/2 - texture.height/2 - 40, WHITE);
            DrawRectangleLines(SCREEN_WIDTH/2 - texture.width/2, SCREEN_HEIGHT/2 - texture.height/2 - 40, texture.width, texture.height, DARKGRAY);

            DrawText("We are drawing only one texture from various images composed!", 240, 350, 10, DARKGRAY);
            DrawText("Source images have been cropped, scaled, flipped and copied one over the other.", 190, 370, 10, DARKGRAY);

        EndDrawing();
    }

    UnloadTexture(texture);

    CloseWindow();
}