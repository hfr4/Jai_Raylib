/* ******************************************************************************************
*
*   raylib [audio] example - Music playing (streaming)
*
*   Example originally created with raylib 1.3, last time updated with raylib 4.0
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [audio] example - music playing (streaming)");

    InitAudioDevice();

    music := LoadMusicStream("resources/country.mp3");

    PlayMusicStream(music);

    timePlayed := 0.0;          // Time played normalized [0.0..1.0]
    pause := false;             // Music playing paused

    SetTargetFPS(30);


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

        // Get normalized time played for current music stream
        timePlayed = GetMusicTimePlayed(music)/GetMusicTimeLength(music);

        if (timePlayed > 1.0) timePlayed = 1.0;   // Make sure time played is no longer than music

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, LIGHTGRAY);

            DrawRectangle(200, 200, 400, 12, LIGHTGRAY);
            DrawRectangle(200, 200, cast(s32) (timePlayed * 400.0), 12, MAROON);
            DrawRectangleLines(200, 200, 400, 12, GRAY);

            DrawText("PRESS SPACE TO RESTART MUSIC", 215, 250, 20, LIGHTGRAY);
            DrawText("PRESS P TO PAUSE/RESUME MUSIC", 208, 280, 20, LIGHTGRAY);

        EndDrawing();
    }
    UnloadMusicStream(music);

    CloseAudioDevice();

    CloseWindow();
}