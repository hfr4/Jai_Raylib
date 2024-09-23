/* ******************************************************************************************
*
*   raylib [core] example - Gamepad input
*
*   NOTE: This example requires a Gamepad connected to the system
*         raylib is configured to work with the following gamepads:
*                - Xbox 360 Controller (Xbox 360, Xbox One)
*                - PLAYSTATION(R)3 Controller
*         Check raylib.h for buttons configuration
*
*   Example originally created with raylib 1.1, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2013-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

// NOTE: Gamepad name ID depends on drivers and OS
XBOX360_LEGACY_NAME_ID  ::  "Xbox Controller";
XBOX360_NAME_ID         ::  "Xbox 360 Controller";
PS3_NAME_ID             ::  "Sony PLAYSTATION(R)3 Controller";


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);  // Set MSAA 4X hint before windows creation

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - gamepad input");

    texPs3Pad := LoadTexture("resources/ps3.png");
    texXboxPad := LoadTexture("resources/xbox.png");

    SetTargetFPS(60);

    gamepad : s32 = 0; // which gamepad to display


    while !WindowShouldClose() {

        // ...

        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (IsKeyPressed(xx KeyboardKey.LEFT) && gamepad > 0) gamepad -= 1;
            if (IsKeyPressed(xx KeyboardKey.RIGHT))               gamepad+= 1;

            if (IsGamepadAvailable(gamepad))
            {
                DrawText(TextFormat("GP%d: %", gamepad, GetGamepadName(gamepad)), 10, 10, 10, BLACK);

                if (TextIsEqual(GetGamepadName(gamepad), XBOX360_LEGACY_NAME_ID) || TextIsEqual(GetGamepadName(gamepad), XBOX360_NAME_ID))
                {
                    DrawTexture(texXboxPad, 0, 0, DARKGRAY);

                    // Draw buttons: xbox home
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.MIDDLE)) DrawCircle(394, 89, 19, RED);

                    // Draw buttons: basic
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.MIDDLE_RIGHT)) DrawCircle(436, 150, 9, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.MIDDLE_LEFT)) DrawCircle(352, 150, 9, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_FACE_LEFT)) DrawCircle(501, 151, 15, BLUE);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_FACE_DOWN)) DrawCircle(536, 187, 15, LIME);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_FACE_RIGHT)) DrawCircle(572, 151, 15, MAROON);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_FACE_UP)) DrawCircle(536, 115, 15, GOLD);

                    // Draw buttons: d-pad
                    DrawRectangle(317, 202, 19, 71, BLACK);
                    DrawRectangle(293, 228, 69, 19, BLACK);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_FACE_UP)) DrawRectangle(317, 202, 19, 26, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_FACE_DOWN)) DrawRectangle(317, 202 + 45, 19, 26, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_FACE_LEFT)) DrawRectangle(292, 228, 25, 19, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_FACE_RIGHT)) DrawRectangle(292 + 44, 228, 26, 19, RED);

                    // Draw buttons: left-right back
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_TRIGGER_1)) DrawCircle(259, 61, 20, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_TRIGGER_1)) DrawCircle(536, 61, 20, RED);

                    // Draw axis: left joystick

                    leftGamepadColor := BLACK;
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_THUMB)) leftGamepadColor = RED;
                    DrawCircle(259, 152, 39, BLACK);
                    DrawCircle(259, 152, 34, LIGHTGRAY);
                    DrawCircle(259 + cast(s32) (GetGamepadAxisMovement(gamepad, xx GamepadAxis.LEFT_X)*20),
                               152 + cast(s32) (GetGamepadAxisMovement(gamepad, xx GamepadAxis.LEFT_Y)*20), 25, leftGamepadColor);

                    // Draw axis: right joystick
                    rightGamepadColor := BLACK;
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_THUMB)) rightGamepadColor = RED;
                    DrawCircle(461, 237, 38, BLACK);
                    DrawCircle(461, 237, 33, LIGHTGRAY);
                    DrawCircle(461 + cast(s32) (GetGamepadAxisMovement(gamepad, xx GamepadAxis.RIGHT_X)*20),
                               237 + cast(s32) (GetGamepadAxisMovement(gamepad, xx GamepadAxis.RIGHT_Y)*20), 25, rightGamepadColor);

                    // Draw axis: left-right triggers
                    DrawRectangle(170, 30, 15, 70, GRAY);
                    DrawRectangle(604, 30, 15, 70, GRAY);
                    DrawRectangle(170, 30, 15, cast(s32) (((1 + GetGamepadAxisMovement(gamepad, xx GamepadAxis.LEFT_TRIGGER))/2)*70), RED);
                    DrawRectangle(604, 30, 15, cast(s32) (((1 + GetGamepadAxisMovement(gamepad, xx GamepadAxis.RIGHT_TRIGGER))/2)*70), RED);

                    //DrawText(TextFormat("Xbox axis LT: %02.02", GetGamepadAxisMovement(gamepad, xx GamepadAxis.LEFT_TRIGGER)), 10, 40, 10, BLACK);
                    //DrawText(TextFormat("Xbox axis RT: %02.02", GetGamepadAxisMovement(gamepad, xx GamepadAxis.RIGHT_TRIGGER)), 10, 60, 10, BLACK);
                }
                else if (TextIsEqual(GetGamepadName(gamepad), PS3_NAME_ID))
                {
                    DrawTexture(texPs3Pad, 0, 0, DARKGRAY);

                    // Draw buttons: ps
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.MIDDLE)) DrawCircle(396, 222, 13, RED);

                    // Draw buttons: basic
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.MIDDLE_LEFT)) DrawRectangle(328, 170, 32, 13, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.MIDDLE_RIGHT)) DrawTriangle(.{ 436, 168 }, .{ 436, 185 }, .{ 464, 177 }, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_FACE_UP)) DrawCircle(557, 144, 13, LIME);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_FACE_RIGHT)) DrawCircle(586, 173, 13, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_FACE_DOWN)) DrawCircle(557, 203, 13, VIOLET);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_FACE_LEFT)) DrawCircle(527, 173, 13, PINK);

                    // Draw buttons: d-pad
                    DrawRectangle(225, 132, 24, 84, BLACK);
                    DrawRectangle(195, 161, 84, 25, BLACK);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_FACE_UP)) DrawRectangle(225, 132, 24, 29, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_FACE_DOWN)) DrawRectangle(225, 132 + 54, 24, 30, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_FACE_LEFT)) DrawRectangle(195, 161, 30, 25, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_FACE_RIGHT)) DrawRectangle(195 + 54, 161, 30, 25, RED);

                    // Draw buttons: left-right back buttons
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_TRIGGER_1)) DrawCircle(239, 82, 20, RED);
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_TRIGGER_1)) DrawCircle(557, 82, 20, RED);

                    // Draw axis: left joystick
                    leftGamepadColor := BLACK;
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.LEFT_THUMB)) leftGamepadColor = RED;
                    DrawCircle(319, 255, 35, leftGamepadColor);
                    DrawCircle(319, 255, 31, LIGHTGRAY);
                    DrawCircle(319 + cast(s32) (GetGamepadAxisMovement(gamepad, xx GamepadAxis.LEFT_X) * 20),
                               255 + cast(s32) (GetGamepadAxisMovement(gamepad, xx GamepadAxis.LEFT_Y) * 20), 25, leftGamepadColor);

                    // Draw axis: right joystick
                    rightGamepadColor := BLACK;
                    if (IsGamepadButtonDown(gamepad, xx GamepadButton.RIGHT_THUMB)) rightGamepadColor = RED;
                    DrawCircle(475, 255, 35, BLACK);
                    DrawCircle(475, 255, 31, LIGHTGRAY);
                    DrawCircle(475 + cast(s32) (GetGamepadAxisMovement(gamepad, xx GamepadAxis.RIGHT_X) * 20),
                               255 + cast(s32) (GetGamepadAxisMovement(gamepad, xx GamepadAxis.RIGHT_Y) * 20), 25, rightGamepadColor);

                    // Draw axis: left-right triggers
                    DrawRectangle(169, 48, 15, 70, GRAY);
                    DrawRectangle(611, 48, 15, 70, GRAY);
                    DrawRectangle(169, 48, 15, cast(s32) (((1 - GetGamepadAxisMovement(gamepad, xx GamepadAxis.LEFT_TRIGGER)) / 2) * 70), RED);
                    DrawRectangle(611, 48, 15, cast(s32) (((1 - GetGamepadAxisMovement(gamepad, xx GamepadAxis.RIGHT_TRIGGER)) / 2) * 70), RED);
                }
                else
                {
                    DrawText("- GENERIC GAMEPAD -", 280, 180, 20, GRAY);

                    // TODO: Draw generic gamepad
                }

                DrawText(TextFormat("DETECTED AXIS [%]:", GetGamepadAxisCount(0)), 10, 50, 10, MAROON);

                for i: 0..GetGamepadAxisCount(0) - 1
                {
                    DrawText(TextFormat("AXIS %: %", i, GetGamepadAxisMovement(0, xx i)), 20, xx(70 + 20*i), 10, DARKGRAY);
                }

                if (GetGamepadButtonPressed() != xx GamepadButton.UNKNOWN) DrawText(TextFormat("DETECTED BUTTON: %", GetGamepadButtonPressed()), 10, 430, 10, RED);
                else DrawText("DETECTED BUTTON: NONE", 10, 430, 10, GRAY);
            }
            else
            {
                DrawText(TextFormat("GP%d: NOT DETECTED", gamepad), 10, 10, 10, GRAY);

                DrawTexture(texXboxPad, 0, 0, LIGHTGRAY);
            }

        EndDrawing();
    }

    UnloadTexture(texPs3Pad);
    UnloadTexture(texXboxPad);

    CloseWindow();
}