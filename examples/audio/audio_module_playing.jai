/* ******************************************************************************************
*
*   raylib [audio] example - Module playing (streaming)
*
*   Example originally created with raylib 1.5, last time updated with raylib 3.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2016-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_CIRCLES :: 64;

CircleWave :: struct {
    position: Vector2;
    radius:   float;
    alpha:    float;
    speed:    float;
    color:    Color;
}

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);  // NOTE: Try to enable MSAA 4X

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [audio] example - module playing (streaming)");

    InitAudioDevice();

    colors := Color.[ ORANGE, RED, GOLD, LIME, BLUE, VIOLET, BROWN, LIGHTGRAY, PINK, YELLOW, GREEN, SKYBLUE, PURPLE, BEIGE ];

    // Creates some circles for visual effect
    circles: [MAX_CIRCLES] CircleWave;

    for * circles {
        it.alpha      = 0.0;
        it.radius     = cast(float) GetRandomValue(10, 40);
        it.position.x = cast(float) GetRandomValue(cast(s32) it.radius, cast(s32) (SCREEN_WIDTH  - it.radius));
        it.position.y = cast(float) GetRandomValue(cast(s32) it.radius, cast(s32) (SCREEN_HEIGHT - it.radius));
        it.speed      = cast(float) GetRandomValue(1, 100)/2000.0;
        it.color      = colors[GetRandomValue(0, 13)];
    }

    music := LoadMusicStream("resources/mini1111.xm");
    music.looping = false;
    pitch := 1.0;

    PlayMusicStream(music);

    timePlayed := 0.0;
    pause := false;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateMusicStream(music);      // Update music buffer with new stream data

        // Restart music playing (stop and play)
        if (IsKeyPressed(xx KeyboardKey.SPACE))
        {
            StopMusicStream(music);
            PlayMusicStream(music);
            pause = false;
        }

        // Pause/Resume music playing
        if (IsKeyPressed(xx KeyboardKey.P))
        {
            pause = !pause;

            if (pause) PauseMusicStream(music);
            else       ResumeMusicStream(music);
        }

        if      (IsKeyDown(xx KeyboardKey.DOWN)) pitch -= 0.01;
        else if (IsKeyDown(xx KeyboardKey.UP))   pitch += 0.01;

        SetMusicPitch(music, pitch);

        // Get timePlayed scaled to bar dimensions
        timePlayed = GetMusicTimePlayed(music)/GetMusicTimeLength(music)*(SCREEN_WIDTH - 40);

        // Color circles animation
        if !pause for * circles {
            it.alpha  += it.speed;
            it.radius += it.speed*10.0;

            if (it.alpha > 1.0) it.speed *= -1;

            if (it.alpha <= 0.0)
            {
                it.alpha      = 0.0;
                it.radius     = cast(float) GetRandomValue(10, 40);
                it.position.x = cast(float) GetRandomValue(cast(s32) it.radius, cast(s32) (SCREEN_WIDTH  - it.radius));
                it.position.y = cast(float) GetRandomValue(cast(s32) it.radius, cast(s32) (SCREEN_HEIGHT - it.radius));
                it.color      = colors[GetRandomValue(0, 13)];
                it.speed      = cast(float) GetRandomValue(1, 100)/2000.0;
            }
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            for < circles {
                DrawCircleV(it.position, it.radius, Fade(it.color, it.alpha));
            }

            // Draw time bar
            DrawRectangle(20, SCREEN_HEIGHT - 20 - 12, SCREEN_WIDTH - 40   , 12, LIGHTGRAY);
            DrawRectangle(20, SCREEN_HEIGHT - 20 - 12, cast(s32) timePlayed, 12, MAROON);
            DrawRectangleLines(20, SCREEN_HEIGHT - 20 - 12, SCREEN_WIDTH - 40, 12, GRAY);

            // Draw help instructions
            DrawRectangle(20, 20, 425, 145, WHITE);
            DrawRectangleLines(20, 20, 425, 145, GRAY);
            DrawText("PRESS SPACE TO RESTART MUSIC", 40, 40, 20, BLACK);
            DrawText("PRESS P TO PAUSE/RESUME", 40, 70, 20, BLACK);
            DrawText("PRESS UP/DOWN TO CHANGE SPEED", 40, 100, 20, BLACK);
            DrawText(TextFormat("SPEED: %", pitch), 40, 130, 20, MAROON);

        EndDrawing();
    }
    UnloadMusicStream(music);

    CloseAudioDevice();

    CloseWindow();
}
