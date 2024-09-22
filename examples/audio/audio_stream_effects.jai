/* ******************************************************************************************
*
*   raylib [audio] example - Music stream processing effects
*
*   Example originally created with raylib 4.2, last time updated with raylib 5.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

// Required delay effect variables
delayBuffer: *float;
delayBufferSize := 0;
delayReadIndex := 2;
delayWriteIndex := 0;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [audio] example - stream effects");

    InitAudioDevice();

    music := LoadMusicStream("resources/country.mp3");

    // Allocate buffer for the delay effect
    delayBufferSize = 48000 * 2;      // 1 second delay (device sampleRate*channels)
    delayBuffer = cast (*float) alloc(delayBufferSize * size_of(float));

    PlayMusicStream(music);

    timePlayed := 0.0;          // Time played normalized [0.0..1.0]
    pause := false;             // Music playing paused

    enableEffectLPF   := false; // Enable effect low-pass-filter
    enableEffectDelay := false; // Enable effect delay (1 second)

    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateMusicStream(music);   // Update music buffer with new stream data

        // Restart music playing (stop and play)
        if (IsKeyPressed(xx KeyboardKey.SPACE))
        {
            StopMusicStream(music);
            PlayMusicStream(music);
        }

        // Pause/Resume music playing
        if (IsKeyPressed(xx KeyboardKey.P))
        {
            pause = !pause;

            if (pause) PauseMusicStream(music);
            else       ResumeMusicStream(music);
        }

        // Add/Remove effect: lowpass filter
        if (IsKeyPressed(xx KeyboardKey.F))
        {
            enableEffectLPF = !enableEffectLPF;
            if (enableEffectLPF) AttachAudioStreamProcessor(music.stream, AudioProcessEffectLPF);
            else                 DetachAudioStreamProcessor(music.stream, AudioProcessEffectLPF);
        }

        // Add/Remove effect: delay
        if (IsKeyPressed(xx KeyboardKey.D))
        {
            enableEffectDelay = !enableEffectDelay;
            if (enableEffectDelay) AttachAudioStreamProcessor(music.stream, AudioProcessEffectDelay);
            else                   DetachAudioStreamProcessor(music.stream, AudioProcessEffectDelay);
        }

        // Get normalized time played for current music stream
        timePlayed = GetMusicTimePlayed(music)/GetMusicTimeLength(music);

        if (timePlayed > 1.0) timePlayed = 1.0;   // Make sure time played is no longer than music


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("MUSIC SHOULD BE PLAYING!", 245, 150, 20, LIGHTGRAY);

            DrawRectangle(200, 180, 400, 12, LIGHTGRAY);
            DrawRectangle(200, 180, cast(s32)(timePlayed*400.0), 12, MAROON);
            DrawRectangleLines(200, 180, 400, 12, GRAY);

            DrawText("PRESS SPACE TO RESTART MUSIC", 215, 230, 20, LIGHTGRAY);
            DrawText("PRESS P TO PAUSE/RESUME MUSIC", 208, 260, 20, LIGHTGRAY);

            DrawText(TextFormat("PRESS F TO TOGGLE LPF EFFECT: %"  , ifx enableEffectLPF   then "ON" else "OFF"), 200, 320, 20, GRAY);
            DrawText(TextFormat("PRESS D TO TOGGLE DELAY EFFECT: %", ifx enableEffectDelay then "ON" else "OFF"), 180, 350, 20, GRAY);

        EndDrawing();
    }

    UnloadMusicStream(music);

    CloseAudioDevice();

    free(delayBuffer);       // Free delay buffer

    CloseWindow();
}

// Audio effect: lowpass filter
low: [2] float;
AudioProcessEffectLPF :: (buffer: *void, frames: u32) #c_call {
    CUTOFF :: 70.0 / 44100.0;                   // 70 Hz lowpass filter
    K      :: CUTOFF / (CUTOFF + 0.1591549431); // RC filter formula

    samples := cast(*float) buffer;
    for 0..frames - 1 {
        left  := *samples[it * 2];
        right := *samples[it * 2 + 1];

        low[0] += cast(float) K * (left.*  - low[0]);
        low[1] += cast(float) K * (right.* - low[1]);

        left.*  = low[0];
        right.* = low[1];
    }
}

// Audio effect: delay
AudioProcessEffectDelay :: (buffer: *void, frames: u32) #c_call {
    samples := cast(*float) buffer;   // Samples internally stored as <float>s

    for 0..frames - 1 {
        leftDelay  := delayBuffer[delayReadIndex]; // ERROR: Reading buffer -> WHY??? Maybe thread related???
        delayReadIndex += 1;
        rightDelay := delayBuffer[delayReadIndex];
        delayReadIndex += 1;

        if (delayReadIndex == delayBufferSize) delayReadIndex = 0;

        left  := *samples[it * 2];
        right := *samples[it * 2 + 1];

        left.*  = 0.5 * left.*  + 0.5 * leftDelay;
        right.* = 0.5 * right.* + 0.5 * rightDelay;

        delayBuffer[delayWriteIndex] = left.*;
        delayWriteIndex += 1;
        delayBuffer[delayWriteIndex] = right.*;
        delayWriteIndex += 1;

        if (delayWriteIndex == delayBufferSize) delayWriteIndex = 0;
    }
}
