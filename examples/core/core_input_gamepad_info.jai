/* ******************************************************************************************
*
*   raylib [core] example - Gamepad information
*
*   NOTE: This example requires a Gamepad connected to the system
*         Check raylib.h for buttons configuration
*
*   Example originally created with raylib 4.6, last time updated with raylib 4.6
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2013-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);  // Set MSAA 4X hint before windows creation

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - gamepad information");

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // TODO: Update your variables here

        BeginDrawing();

            ClearBackground(RAYWHITE);

            y : s32 = 5;

            // MAX_GAMEPADS = 4
            for i: 0..3 {
                if (IsGamepadAvailable(xx i)) {
                    DrawText(TextFormat("Gamepad name: %", GetGamepadName(xx i)), 10, y, 10, BLACK);
                    y += 11;
                    DrawText(TextFormat("\tAxis count:   %", GetGamepadAxisCount(xx i)), 10, y, 10, BLACK);
                    y += 11;

                    for axis: 0..GetGamepadAxisCount(xx i) - 1 {
                        DrawText(TextFormat("\tAxis % = %", axis, GetGamepadAxisMovement(xx i, xx axis)), 10, y, 10, BLACK);
                        y += 11;
                    }

                    for button: 0..31 {
                        DrawText(TextFormat("\tButton % = %", button, IsGamepadButtonDown(xx i, xx button)), 10, y, 10, BLACK);
                        y += 11;
                    }
                }
            }

            DrawFPS(GetScreenWidth() - 100, 100);

        EndDrawing();
    }
    CloseWindow();
}