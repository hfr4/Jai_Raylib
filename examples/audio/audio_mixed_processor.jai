/* ******************************************************************************************
*
*   raylib [audio] example - Mixed audio processing
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
*
*   Example contributed by hkc (@hatkidchan) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 hkc (@hatkidchan)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

average_volume: [400] float;   // Average volume history
exponent := 1.0;               // Audio exponentiation value

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [audio] example - processing mixed output");

    InitAudioDevice();

    AttachAudioMixedProcessor(ProcessAudio);

    music := LoadMusicStream("resources/country.mp3");
    sound := LoadSound("resources/coin.wav");

    PlayMusicStream(music);

    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateMusicStream(music);   // Update music buffer with new stream data

        // Modify processing variables

        if (IsKeyPressed(xx KeyboardKey.LEFT))  exponent -= 0.05;
        if (IsKeyPressed(xx KeyboardKey.RIGHT)) exponent += 0.05;

        if (exponent <= 0.5) exponent = 0.5;
        if (exponent >= 3.0) exponent = 3.0;

        if (IsKeyPressed(xx KeyboardKey.SPACE)) PlaySound(sound);

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, LIGHTGRAY);

            DrawText(TextFormat("exponent = %.2", exponent), 215, 180, 20, LIGHTGRAY);

            DrawRectangle(199, 199, 402, 34, LIGHTGRAY);
            for i: 0..399
            {
                DrawLine(cast(s32)(201 + i), cast(s32)(232 - average_volume[i] * 32), cast(s32)(201 + i), 232, MAROON);
            }
            DrawRectangleLines(199, 199, 402, 34, GRAY);

            DrawText("PRESS SPACE TO PLAY OTHER SOUND", 200, 250, 20, LIGHTGRAY);
            DrawText("USE LEFT AND RIGHT ARROWS TO ALTER DISTORTION", 140, 280, 20, LIGHTGRAY);

        EndDrawing();
    }

    UnloadMusicStream(music);

    DetachAudioMixedProcessor(ProcessAudio);  // Disconnect audio processor

    CloseAudioDevice();

    CloseWindow();
}
// Audio processing function
ProcessAudio :: (buffer: *void, frames: u32) #c_call {
    new_context: Context;
    push_context new_context {
        samples := cast(*float) buffer;   // Samples internally stored as <float>s
        average := 0.0;                   // Temporary average volume

        for 0..frames - 1 {
            left  := *samples[it * 2 + 0];
            right := *samples[it * 2 + 1];

            left.*  = Math.pow(Math.abs(left.*) , exponent) * (ifx left.*  < 0.0 then -1.0 else 1.0);
            right.* = Math.pow(Math.abs(right.*), exponent) * (ifx right.* < 0.0 then -1.0 else 1.0);

            average += Math.abs(left.*)  / frames;   // accumulating average volume
            average += Math.abs(right.*) / frames;
        }

        // Moving history to the left
        for i: 0..398 average_volume[i] = average_volume[i + 1];
        average_volume[399] = average; // Adding last average value
    }
}