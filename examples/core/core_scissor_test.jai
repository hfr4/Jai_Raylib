/* ******************************************************************************************
*
*   raylib [core] example - Scissor test
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.0
*
*   Example contributed by Chris Dill (@MysteriousSpace) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Chris Dill (@MysteriousSpace)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - scissor test");

    scissorArea := Rectangle.{ 0, 0, 300, 300 };
    scissorMode := true;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyPressed(xx KeyboardKey.S)) scissorMode = !scissorMode;

        // Centre the scissor area around the mouse position
        scissorArea.x = GetMouseX() - scissorArea.width/2;
        scissorArea.y = GetMouseY() - scissorArea.height/2;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (scissorMode) BeginScissorMode(cast(s32) scissorArea.x, cast(s32) scissorArea.y, cast(s32) scissorArea.width, cast(s32) scissorArea.height);

            // Draw full screen rectangle and some text
            // NOTE: Only part defined by scissor area will be rendered
            DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), RED);
            DrawText("Move the mouse around to reveal this text!", 190, 200, 20, LIGHTGRAY);

            if (scissorMode) EndScissorMode();

            DrawRectangleLinesEx(scissorArea, 1, BLACK);
            DrawText("Press S to toggle scissor test", 10, 10, 20, BLACK);

        EndDrawing();
    }
    CloseWindow();
}
