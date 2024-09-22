/* ******************************************************************************************
*
*   raylib [shapes] example - rectangle scaling by mouse
*
*   Example originally created with raylib 2.5, last time updated with raylib 2.5
*
*   Example contributed by Vlad Adrian (@demizdor) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2024 Vlad Adrian (@demizdor) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MOUSE_SCALE_MARK_SIZE :: 12;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - rectangle scaling mouse");

    rec := Rectangle.{ 100, 100, 200, 80 };

    mouseScaleReady := false;
    mouseScaleMode  := false;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        mousePosition := GetMousePosition();

        if (CheckCollisionPointRec(mousePosition, .{ rec.x + rec.width - MOUSE_SCALE_MARK_SIZE, rec.y + rec.height - MOUSE_SCALE_MARK_SIZE, MOUSE_SCALE_MARK_SIZE, MOUSE_SCALE_MARK_SIZE }))
        {
            mouseScaleReady = true;
            if (IsMouseButtonPressed(xx MouseButton.LEFT)) mouseScaleMode = true;
        }
        else mouseScaleReady = false;

        if (mouseScaleMode)
        {
            mouseScaleReady = true;

            rec.width  = (mousePosition.x - rec.x);
            rec.height = (mousePosition.y - rec.y);

            // Check minimum rec size
            if (rec.width  < MOUSE_SCALE_MARK_SIZE) rec.width  = MOUSE_SCALE_MARK_SIZE;
            if (rec.height < MOUSE_SCALE_MARK_SIZE) rec.height = MOUSE_SCALE_MARK_SIZE;

            // Check maximum rec size
            if (rec.width  > (GetScreenWidth()  - rec.x)) rec.width  = GetScreenWidth()  - rec.x;
            if (rec.height > (GetScreenHeight() - rec.y)) rec.height = GetScreenHeight() - rec.y;

            if (IsMouseButtonReleased(xx MouseButton.LEFT)) mouseScaleMode = false;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("Scale rectangle dragging from bottom-right corner!", 10, 10, 20, GRAY);

            DrawRectangleRec(rec, Fade(GREEN, 0.5));

            if (mouseScaleReady)
            {
                DrawRectangleLinesEx(rec, 1, RED);
                DrawTriangle(.{ rec.x + rec.width - MOUSE_SCALE_MARK_SIZE, rec.y + rec.height },
                             .{ rec.x + rec.width, rec.y + rec.height },
                             .{ rec.x + rec.width, rec.y + rec.height - MOUSE_SCALE_MARK_SIZE }, RED);
            }

        EndDrawing();
    }

    CloseWindow();
}