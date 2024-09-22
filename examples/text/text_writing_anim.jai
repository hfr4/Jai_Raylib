/* ******************************************************************************************
*
*   raylib [text] example - Text Writing Animation
*
*   Example originally created with raylib 1.4, last time updated with raylib 1.4
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2016-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - text writing anim");

    message :=  "This sample illustrates a text writing\nanimation effect! Check it out! ;)";

    framesCounter : s32 = 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyDown(xx KeyboardKey.SPACE)) framesCounter += 8;
        else                                 framesCounter += 1;

        if (IsKeyPressed(xx KeyboardKey.ENTER)) framesCounter = 0;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText(TextSubtext(message.data, 0, framesCounter/10), 210, 160, 20, MAROON);

            DrawText("PRESS [ENTER] to RESTART!", 240, 260, 20, LIGHTGRAY);
            DrawText("HOLD [SPACE] to SPEED UP!", 239, 300, 20, LIGHTGRAY);

        EndDrawing();
    }
    CloseWindow();
}