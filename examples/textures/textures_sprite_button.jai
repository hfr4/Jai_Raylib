/* ******************************************************************************************
*
*   raylib [textures] example - sprite button
*
*   Example originally created with raylib 2.5, last time updated with raylib 2.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

NUM_FRAMES :: 3; // Number of frames (rectangles) for the button sprite texture

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - sprite button");

    InitAudioDevice();

    fxButton := LoadSound("resources/buttonfx.wav");
    button   := LoadTexture("resources/button.png");

    // Define frame rectangle for drawing
    frameHeight := cast(float) button.height / NUM_FRAMES;
    sourceRec := Rectangle.{ 0, 0, cast(float) button.width, frameHeight };

    // Define button bounds on screen
    btnBounds := Rectangle.{ SCREEN_WIDTH/2.0 - button.width/2.0, SCREEN_HEIGHT/2.0 - button.height/NUM_FRAMES/2.0, cast(float) button.width, frameHeight };

    btnState := 0;              // Button state: 0-NORMAL, 1-MOUSE_HOVER, 2-PRESSED
    btnAction := false;         // Button action should be activated

    mousePoint := Vector2.{ 0.0, 0.0 };

    SetTargetFPS(60);

    while !WindowShouldClose() {

        mousePoint = GetMousePosition();
        btnAction = false;

        // Check button state
        if (CheckCollisionPointRec(mousePoint, btnBounds))
        {
            if (IsMouseButtonDown(xx MouseButton.LEFT)) btnState = 2;
            else                                        btnState = 1;

            if (IsMouseButtonReleased(xx MouseButton.LEFT)) btnAction = true;
        }
        else btnState = 0;

        if (btnAction) PlaySound(fxButton);

        // Calculate button frame rectangle to draw depending on button state
        sourceRec.y = btnState*frameHeight;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTextureRec(button, sourceRec, .{ btnBounds.x, btnBounds.y }, WHITE); // Draw button frame

        EndDrawing();
    }

    UnloadTexture(button);
    UnloadSound(fxButton);

    CloseAudioDevice();     // Close audio device

    CloseWindow();
}