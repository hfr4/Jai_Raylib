/* ******************************************************************************************
*
*   raylib [core] example - Window should close
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - window should close");

    SetExitKey(xx KeyboardKey.NULL);       // Disable xx KeyboardKey.ESCAPE to close window, X-button still works

    exitWindowRequested := false;   // Flag to request window to exit
    exitWindow := false;    // Flag to set window to exit

    SetTargetFPS(60);


    while (!exitWindow)
    {

        // Detect if X-button or xx KeyboardKey.ESCAPE have been pressed to close window
        if (WindowShouldClose() || IsKeyPressed(xx KeyboardKey.ESCAPE)) exitWindowRequested = true;

        if (exitWindowRequested)
        {
            // A request for close window has been issued, we can save data before closing
            // or just show a message asking for confirmation

            if      (IsKeyPressed(xx KeyboardKey.Y)) exitWindow = true;
            else if (IsKeyPressed(xx KeyboardKey.N)) exitWindowRequested = false;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (exitWindowRequested)
            {
                DrawRectangle(0, 100, SCREEN_WIDTH, 200, BLACK);
                DrawText("Are you sure you want to exit program? [Y/N]", 40, 180, 30, WHITE);
            }
            else DrawText("Try to close the window to get confirmation message!", 120, 200, 20, LIGHTGRAY);

        EndDrawing();
    }
    CloseWindow();
}
