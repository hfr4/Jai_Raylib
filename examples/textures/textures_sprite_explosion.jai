/* ******************************************************************************************
*
*   raylib [textures] example - sprite explosion
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Anata and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

NUM_FRAMES_PER_LINE :: 5;
NUM_LINES           :: 5;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - sprite explosion");

    InitAudioDevice();

    fxBoom := LoadSound("resources/boom.wav");

    explosion := LoadTexture("resources/explosion.png");

    // Init variables for animation
    frameWidth  := cast(float) (explosion.width/NUM_FRAMES_PER_LINE);   // Sprite one frame rectangle width
    frameHeight := cast(float) (explosion.height/NUM_LINES);            // Sprite one frame rectangle height
    currentFrame := 0;
    currentLine  := 0;

    frameRec := Rectangle.{ 0, 0, frameWidth, frameHeight };
    position := Vector2.{ 0.0, 0.0 };

    active := false;
    framesCounter := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {


        // Check for mouse button pressed and activate explosion (if not active)
        if (IsMouseButtonPressed(xx MouseButton.LEFT) && !active)
        {
            position = GetMousePosition();
            active = true;

            position.x -= frameWidth  / 2.0;
            position.y -= frameHeight / 2.0;

            PlaySound(fxBoom);
        }

        // Compute explosion animation frames
        if (active) {
            framesCounter += 1;

            if (framesCounter > 2) {
                currentFrame += 1;

                if (currentFrame >= NUM_FRAMES_PER_LINE) {
                    currentFrame = 0;
                    currentLine += 1;

                    if (currentLine >= NUM_LINES) {
                        currentLine = 0;
                        active = false;
                    }
                }

                framesCounter = 0;
            }
        }

        frameRec.x = frameWidth*currentFrame;
        frameRec.y = frameHeight*currentLine;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            // Draw explosion required frame rectangle
            if (active) DrawTextureRec(explosion, frameRec, position, WHITE);

        EndDrawing();
    }

    UnloadTexture(explosion);
    UnloadSound(fxBoom);

    CloseAudioDevice();

    CloseWindow();
}