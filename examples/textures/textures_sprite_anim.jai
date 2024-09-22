/* ******************************************************************************************
*
*   raylib [textures] example - Sprite animation
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.3
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_FRAME_SPEED  :: 15;
MIN_FRAME_SPEED  ::  1;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [texture] example - sprite anim");

    // NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
    scarfy := LoadTexture("resources/scarfy.png");        // Texture loading

    position := Vector2.{ 350.0, 280.0 };
    frameRec := Rectangle.{ 0.0, 0.0, cast(float)scarfy.width/6, cast(float)scarfy.height };
    currentFrame := 0;

    framesCounter := 0;
    framesSpeed := 8;            // Number of spritesheet frames shown by second

    SetTargetFPS(60);

    while !WindowShouldClose() {

        framesCounter += 1;

        if (framesCounter >= (60/framesSpeed))
        {
            framesCounter = 0;
            currentFrame += 1;

            if (currentFrame > 5) currentFrame = 0;

            frameRec.x = cast(float)currentFrame*cast(float)scarfy.width/6;
        }

        // Control frames speed
        if      (IsKeyPressed(xx KeyboardKey.RIGHT)) framesSpeed += 1;
        else if (IsKeyPressed(xx KeyboardKey.LEFT))  framesSpeed -= 1;

        if      (framesSpeed > MAX_FRAME_SPEED) framesSpeed = MAX_FRAME_SPEED;
        else if (framesSpeed < MIN_FRAME_SPEED) framesSpeed = MIN_FRAME_SPEED;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexture(scarfy, 15, 40, WHITE);
            DrawRectangleLines(15, 40, scarfy.width, scarfy.height, LIME);
            DrawRectangleLines(15 + cast(s32) frameRec.x, 40 + cast(s32)frameRec.y, cast(s32)frameRec.width, cast(s32)frameRec.height, RED);

            DrawText("FRAME SPEED: ", 165, 210, 10, DARKGRAY);
            DrawText(TextFormat("%02i FPS", framesSpeed), 575, 210, 10, DARKGRAY);
            DrawText("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 240, 10, DARKGRAY);

            for i: 0..MAX_FRAME_SPEED - 1
            {
                if (i < framesSpeed) DrawRectangle( cast(s32) (250 + 21* i), 205, 20, 20, RED);
                DrawRectangleLines(cast(s32) (250 + 21*i), 205, 20, 20, MAROON);
            }

            DrawTextureRec(scarfy, frameRec, position, WHITE);  // Draw part of the texture

            DrawText("(c) Scarfy sprite by Eiden Marsal", SCREEN_WIDTH - 200, SCREEN_HEIGHT - 20, 10, GRAY);

        EndDrawing();
    }

    UnloadTexture(scarfy);       // Texture unloading

    CloseWindow();
}