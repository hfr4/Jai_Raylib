/* ******************************************************************************************
*
*   raylib [textures] example - gif playing
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2021-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_FRAME_DELAY  ::  20;
MIN_FRAME_DELAY  ::   1;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - gif playing");

    animFrames: s32;

    // Load all GIF animation frames into a single Image
    // NOTE: GIF data is always loaded as RGBA (32bit) by default
    // NOTE: Frames are just appended one after another in image.data memory
    imScarfyAnim := LoadImageAnim("resources/scarfy_run.gif", *animFrames);

    // Load texture from image
    // NOTE: We will update this texture when required with next frame data
    // WARNING: It's not recommended to use this technique for sprites animation,
    // use spritesheets instead, like illustrated in textures_sprite_anim example
    texScarfyAnim := LoadTextureFromImage(imScarfyAnim);

    nextFrameDataOffset: u32;  // Current byte offset to next frame in image.data

    currentAnimFrame := 0;       // Current animation frame to load and draw
    frameDelay := 8;             // Frame delay to switch between animation frames
    frameCounter := 0;           // General frames counter

    SetTargetFPS(60);

    while !WindowShouldClose() {

        frameCounter += 1;
        if (frameCounter >= frameDelay) {
            // Move to next frame
            // NOTE: If final frame is reached we return to first frame
            currentAnimFrame += 1;
            if (currentAnimFrame >= animFrames) currentAnimFrame = 0;

            // Get memory offset position for next frame data in image.data
            nextFrameDataOffset = xx (imScarfyAnim.width*imScarfyAnim.height*4*currentAnimFrame);

            // Update GPU texture data with next frame image data
            // WARNING: Data size (frame size) and pixel format must match already created texture
            UpdateTexture(texScarfyAnim, (cast(*u8)imScarfyAnim.data) + nextFrameDataOffset);

            frameCounter = 0;
        }

        // Control frames delay
        if      (IsKeyPressed(xx KeyboardKey.RIGHT)) frameDelay += 1;
        else if (IsKeyPressed(xx KeyboardKey.LEFT))  frameDelay -= 1;

        if      (frameDelay > MAX_FRAME_DELAY) frameDelay = MAX_FRAME_DELAY;
        else if (frameDelay < MIN_FRAME_DELAY) frameDelay = MIN_FRAME_DELAY;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText(TextFormat("TOTAL GIF FRAMES:  %", animFrames), 50, 30, 20, LIGHTGRAY);
            DrawText(TextFormat("CURRENT FRAME: %", currentAnimFrame), 50, 60, 20, GRAY);
            DrawText(TextFormat("CURRENT FRAME IMAGE.DATA OFFSET: %", nextFrameDataOffset), 50, 90, 20, GRAY);

            DrawText("FRAMES DELAY: ", 100, 305, 10, DARKGRAY);
            DrawText(TextFormat("% frames", frameDelay), 620, 305, 10, DARKGRAY);
            DrawText("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 350, 10, DARKGRAY);

            for i: 0..MAX_FRAME_DELAY - 1
            {
                if (i < frameDelay) DrawRectangle(xx (190 + 21*i), 300, 20, 20, RED);
                DrawRectangleLines(xx (190 + 21*i), 300, 20, 20, MAROON);
            }

            DrawTexture(texScarfyAnim, GetScreenWidth()/2 - texScarfyAnim.width/2, 140, WHITE);

            DrawText("(c) Scarfy sprite by Eiden Marsal", SCREEN_WIDTH - 200, SCREEN_HEIGHT - 20, 10, GRAY);

        EndDrawing();
    }

    UnloadTexture(texScarfyAnim);
    UnloadImage(imScarfyAnim);

    CloseWindow();
}