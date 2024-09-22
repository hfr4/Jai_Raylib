/* ******************************************************************************************
*
*   raylib [textures] example - Image Rotation
*
*   Example originally created with raylib 1.0, last time updated with raylib 1.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

NUM_TEXTURES :: 3;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - texture rotation");

    // NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
    image45    := LoadImage("resources/raylib_logo.png");
    image90    := LoadImage("resources/raylib_logo.png");
    imageNeg90 := LoadImage("resources/raylib_logo.png");

    ImageRotate(*image45, 45);
    ImageRotate(*image90, 90);
    ImageRotate(*imageNeg90, -90);

    textures: [NUM_TEXTURES] Texture2D;

    textures[0] = LoadTextureFromImage(image45);
    textures[1] = LoadTextureFromImage(image90);
    textures[2] = LoadTextureFromImage(imageNeg90);

    currentTexture := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsMouseButtonPressed(xx MouseButton.LEFT) || IsKeyPressed(xx KeyboardKey.RIGHT))
        {
            currentTexture = (currentTexture + 1)%NUM_TEXTURES; // Cycle between the textures
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexture(textures[currentTexture], SCREEN_WIDTH/2 - textures[currentTexture].width/2, SCREEN_HEIGHT/2 - textures[currentTexture].height/2, WHITE);

            DrawText("Press LEFT MOUSE BUTTON to rotate the image clockwise", 250, 420, 10, DARKGRAY);

        EndDrawing();
    }
    for i: 0..NUM_TEXTURES - 1 UnloadTexture(textures[i]);

    CloseWindow();
}
