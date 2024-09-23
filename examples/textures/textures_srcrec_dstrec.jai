/* ******************************************************************************************
*
*   raylib [textures] example - Texture source and destination rectangles
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] examples - texture source and destination rectangles");

    scarfy := LoadTexture("resources/scarfy.png");

    frameWidth  := scarfy.width / 6;
    frameHeight := scarfy.height;

    // Source rectangle (part of the texture to use for drawing)
    sourceRec := Rectangle.{ 0.0, 0.0, cast(float)frameWidth, cast(float)frameHeight };

    // Destination rectangle (screen rectangle where drawing part of texture)
    destRec := Rectangle.{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0, frameWidth*2.0, frameHeight*2.0 };

    // Origin of the texture (rotation/scale point), it's relative to destination rectangle size
    origin := Vector2.{ cast(float)frameWidth, cast(float)frameHeight };

    rotation := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        rotation += 1;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            // NOTE: Using DrawTexturePro() we can easily rotate and scale the part of the texture we draw
            // sourceRec defines the part of the texture we use for drawing
            // destRec defines the rectangle where our texture part will fit (scaling it to fit)
            // origin defines the point of the texture used as reference for rotation and scaling
            // rotation defines the texture rotation (using origin as rotation point)
            DrawTexturePro(scarfy, sourceRec, destRec, origin, cast(float)rotation, WHITE);

            DrawLine(cast(s32) destRec.x, 0, cast(s32) destRec.x, SCREEN_HEIGHT, GRAY);
            DrawLine(0, cast(s32) destRec.y, SCREEN_WIDTH, cast(s32) destRec.y, GRAY);

            DrawText("(c) Scarfy sprite by Eiden Marsal", SCREEN_WIDTH - 200, SCREEN_HEIGHT - 20, 10, GRAY);

        EndDrawing();
    }

    UnloadTexture(scarfy);

    CloseWindow();
}