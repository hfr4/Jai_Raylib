/* ******************************************************************************************
*
*   raylib [audio] example - Playing sound multiple times
*
*   Example originally created with raylib 4.6
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 Jeffery Myers (@JeffM2501)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_SOUNDS  :: 10;
soundArray: [MAX_SOUNDS] Sound;
currentSound: int;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [audio] example - playing sound multiple times");

    InitAudioDevice();

    // load the sound list
    soundArray[0] = LoadSound("resources/sound.wav");         // Load WAV audio file into the first slot as the 'source' sound
                                                              // this sound owns the sample data
    for i: 1..MAX_SOUNDS - 1
    {
        soundArray[i] = LoadSoundAlias(soundArray[0]);        // Load an alias of the sound into slots 1-9. These do not own the sound data, but can be played
    }
    currentSound = 0;                                         // set the sound list to the start

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyPressed(xx KeyboardKey.SPACE))
        {
            PlaySound(soundArray[currentSound]);            // play the next open sound slot
            currentSound += 1;                                 // increment the sound slot
            if (currentSound >= MAX_SOUNDS)                 // if the sound slot is out of bounds, go back to 0
                currentSound = 0;

            // Note: a better way would be to look at the list for the first sound that is not playing and use that slot
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("Press SPACE to PLAY a WAV sound!", 200, 180, 20, LIGHTGRAY);

        EndDrawing();
    }

    for i: 1..MAX_SOUNDS - 1
        UnloadSoundAlias(soundArray[i]);     // Unload sound aliases
    UnloadSound(soundArray[0]);              // Unload source sound data

    CloseAudioDevice();     // Close audio device

    CloseWindow();
}