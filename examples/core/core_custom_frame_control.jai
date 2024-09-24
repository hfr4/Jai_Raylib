/* ******************************************************************************************
*
*   raylib [core] example - custom frame control
*
*   NOTE: WARNING: This is an example for advanced users willing to have full control over
*   the frame processes. By default, EndDrawing() calls the following processes:
*       1. Draw remaining batch data: rlDrawRenderBatchActive()
*       2. SwapScreenBuffer()
*       3. Frame time control: WaitTime()
*       4. PollInputEvents()
*
*   To avoid steps 2, 3 and 4, flag SUPPORT_CUSTOM_FRAME_CONTROL can be enabled in
*   config.h (it requires recompiling raylib). This way those steps are up to the user.
*
*   Note that enabling this flag invalidates some functions:
*       - GetFrameTime()
*       - SetTargetFPS()
*       - GetFPS()
*
*   Example originally created with raylib 4.0, last time updated with raylib 4.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2021-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - custom frame control");

    // Custom timming variables
    previousTime   := GetTime();  // Previous time measure
    currentTime    := 0.0;        // Current time measure
    updateDrawTime := 0.0;        // Update + Draw time
    waitTime       := 0.0;        // Wait time (if target fps required)
    deltaTime      := 0.0;        // Frame time (Update + Draw + Wait time)

    timeCounter := 0.0;           // Accumulative time counter (seconds)
    position    := 0.0;           // Circle position
    pause       := false;         // Pause control flag

    targetFPS := 60.0;              // Our initial target fps


    while !WindowShouldClose() {

        // PollInputEvents();              // Poll input events (SUPPORT_CUSTOM_FRAME_CONTROL)

        if (IsKeyPressed(xx KeyboardKey.SPACE)) pause = !pause;

        if      (IsKeyPressed(xx KeyboardKey.UP))   targetFPS += 20.0;
        else if (IsKeyPressed(xx KeyboardKey.DOWN)) targetFPS -= 20.0;

        if (targetFPS < 0) targetFPS = 0;

        if (!pause)
        {
            position += 200*deltaTime;  // We move at 200 pixels per second
            if (position >= xx GetScreenWidth()) position = 0;
            timeCounter += deltaTime;   // We count time (seconds)
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            for i: 0..GetScreenWidth()/200 - 1 DrawRectangle(xx (200*i), 0, 1, GetScreenHeight(), SKYBLUE);

            DrawCircle(cast(s32) position, GetScreenHeight()/2 - 25, 50, RED);

            DrawText(TextFormat("% ms", timeCounter*1000.0), cast(s32) position - 40, GetScreenHeight()/2 - 100, 20, MAROON);
            DrawText(TextFormat("PosX: %", position), cast(s32) position - 50, GetScreenHeight()/2 + 40, 20, BLACK);

            DrawText("Circle is moving at a constant 200 pixels/sec,\nindependently of the frame rate.", 10, 10, 20, DARKGRAY);
            DrawText("PRESS SPACE to PAUSE MOVEMENT", 10, GetScreenHeight() - 60, 20, GRAY);
            DrawText("PRESS UP | DOWN to CHANGE TARGET FPS", 10, GetScreenHeight() - 30, 20, GRAY);
            DrawText(TextFormat("TARGET FPS: %", targetFPS), GetScreenWidth() - 220, 10, 20, LIME);
            DrawText(TextFormat("CURRENT FPS: %", cast(s32) (1.0/deltaTime)), GetScreenWidth() - 220, 40, 20, GREEN);

        EndDrawing();

        // NOTE: In case raylib is configured to SUPPORT_CUSTOM_FRAME_CONTROL,
        // Events polling, screen buffer swap and frame time control must be managed by the user

        // SwapScreenBuffer();         // Flip the back buffer to screen (front buffer)

        // currentTime = xx GetTime();
        // updateDrawTime = xx (currentTime - previousTime);

        // if (targetFPS > 0.0)          // We want a fixed frame rate
        // {
        //     waitTime = (1.0/cast(float) targetFPS) - updateDrawTime;
        //     if (waitTime > 0.0)
        //     {
        //         WaitTime(cast(float) waitTime);
        //         currentTime = xx GetTime();
        //         deltaTime = cast(float) (currentTime - previousTime);
        //     }
        // }
        // else deltaTime = cast(float) updateDrawTime;    // Framerate could be variable

        // previousTime = currentTime;

    }

    CloseWindow();
}