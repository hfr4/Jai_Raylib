/* ******************************************************************************************
*
*   raylib [core] examples - basic screen manager
*
*   NOTE: This example illustrates a very simple screen manager based on a states machines
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

GameScreen :: enum {
    LOGO :: 0;
    TITLE;
    GAMEPLAY;
    ENDING;
}

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - basic screen manager");

    currentScreen: GameScreen = .LOGO;

    // TODO: Initialize all required variables and load all required data here!

    framesCounter := 0;          // Useful to count frames

    SetTargetFPS(60);               // Set desired framerate (frames-per-second)


    while !WindowShouldClose() {

        if currentScreen == {
            case .LOGO;
                // TODO: Update LOGO screen variables here!

                framesCounter += 1;    // Count frames

                // Wait for 2 seconds (120 frames) before jumping to TITLE screen
                if (framesCounter > 120)
                {
                    currentScreen = .TITLE;
                }

            case .TITLE;
                // TODO: Update TITLE screen variables here!

                // Press enter to change to GAMEPLAY screen
                if (IsKeyPressed(xx KeyboardKey.ENTER) || IsGestureDetected(xx Gesture.TAP))
                {
                    currentScreen = .GAMEPLAY;
                }

            case .GAMEPLAY;
                // TODO: Update GAMEPLAY screen variables here!

                // Press enter to change to ENDING screen
                if (IsKeyPressed(xx KeyboardKey.ENTER) || IsGestureDetected(xx Gesture.TAP))
                {
                    currentScreen = .ENDING;
                }

            case .ENDING;
                // TODO: Update ENDING screen variables here!

                // Press enter to return to TITLE screen
                if (IsKeyPressed(xx KeyboardKey.ENTER) || IsGestureDetected(xx Gesture.TAP))
                {
                    currentScreen = .TITLE;
                }
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            if currentScreen == {
                case .LOGO;
                    // TODO: Draw LOGO screen here!
                    DrawText("LOGO SCREEN", 20, 20, 40, LIGHTGRAY);
                    DrawText("WAIT for 2 SECONDS...", 290, 220, 20, GRAY);

                case .TITLE;
                    // TODO: Draw TITLE screen here!
                    DrawRectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, GREEN);
                    DrawText("TITLE SCREEN", 20, 20, 40, DARKGREEN);
                    DrawText("PRESS ENTER or TAP to JUMP to GAMEPLAY SCREEN", 120, 220, 20, DARKGREEN);

                case .GAMEPLAY;
                    // TODO: Draw GAMEPLAY screen here!
                    DrawRectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, PURPLE);
                    DrawText("GAMEPLAY SCREEN", 20, 20, 40, MAROON);
                    DrawText("PRESS ENTER or TAP to JUMP to ENDING SCREEN", 130, 220, 20, MAROON);

                case .ENDING;
                    // TODO: Draw ENDING screen here!
                    DrawRectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, BLUE);
                    DrawText("ENDING SCREEN", 20, 20, 40, DARKBLUE);
                    DrawText("PRESS ENTER or TAP to RETURN to TITLE SCREEN", 120, 220, 20, DARKBLUE);

            }

        EndDrawing();
    }


    // TODO: Unload all loaded data (textures, fonts, audio) here!

    CloseWindow();
}