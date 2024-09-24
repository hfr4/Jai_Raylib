/* ******************************************************************************************
*
*   raylib [core] example - 2d camera mouse zoom
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022-2023 Jeffery Myers (@JeffM2501)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera mouse zoom");
    SetTargetFPS(60);

    camera: Camera2D;
    camera.zoom = 1.0;

    zoomMode: enum {
        MOUSE_WHEEL;
        MOUSE_MOVE;
    } = .MOUSE_WHEEL;

    while !WindowShouldClose() {

        if      IsKeyPressed(xx KeyboardKey.ONE) zoomMode = .MOUSE_WHEEL;
        else if IsKeyPressed(xx KeyboardKey.TWO) zoomMode = .MOUSE_MOVE;

        // Translate based on mouse right click
        if IsMouseButtonDown(xx MouseButton.RIGHT)
        {
            delta := GetMouseDelta();
            delta = Vector2Scale(delta, -1.0/camera.zoom);
            camera.target = Vector2Add(camera.target, delta);
        }

        if zoomMode == .MOUSE_WHEEL
        {
            // Zoom based on mouse wheel
            wheel := GetMouseWheelMove();
            if wheel != 0
            {
                // Get the world point that is under the mouse
                mouseWorldPos := GetScreenToWorld2D(GetMousePosition(), camera);

                // Set the offset to where the mouse is
                camera.offset = GetMousePosition();

                // Set the target to match, so that the camera maps the world space point
                // under the cursor to the screen space point under the cursor at any zoom
                camera.target = mouseWorldPos;

                // Zoom increment
                scaleFactor := 1.0 + (0.25 * Math.abs(wheel));
                if (wheel < 0) scaleFactor = 1.0/scaleFactor;
                camera.zoom = Clamp(camera.zoom*scaleFactor, 0.125, 64.0);
            }
        }
        else
        {
            // Zoom based on mouse left click
            if IsMouseButtonPressed(xx MouseButton.LEFT)
            {
                // Get the world point that is under the mouse
                mouseWorldPos := GetScreenToWorld2D(GetMousePosition(), camera);

                // Set the offset to where the mouse is
                camera.offset = GetMousePosition();

                // Set the target to match, so that the camera maps the world space point
                // under the cursor to the screen space point under the cursor at any zoom
                camera.target = mouseWorldPos;
            }
            if IsMouseButtonDown(xx MouseButton.LEFT)
            {
                // Zoom increment
                deltaX := GetMouseDelta().x;
                scaleFactor := 1.0 + (0.01*Math.abs(deltaX));
                if (deltaX < 0) scaleFactor = 1.0/scaleFactor;
                camera.zoom = Clamp(camera.zoom*scaleFactor, 0.125, 64.0);
            }
        }

        {
            BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode2D(camera);

                // Draw the 3d grid, rotated 90 degrees and centered around 0,0
                // just so we have something in the XY plane
                rlPushMatrix();
                    rlTranslatef(0, 25*50, 0);
                    rlRotatef(90, 1, 0, 0);
                    DrawGrid(100, 50);
                rlPopMatrix();

                // Draw a reference circle
                DrawCircle(GetScreenWidth()/2, GetScreenHeight()/2, 50, MAROON);

            EndMode2D();

            DrawText("[1][2] Select mouse zoom mode (Wheel or Move)", 20, 20, 20, DARKGRAY);
            if zoomMode == .MOUSE_WHEEL DrawText("Mouse right button drag to move, mouse wheel to zoom"         , 20, 50, 20, DARKGRAY);
            else                        DrawText("Mouse right button drag to move, mouse press and move to zoom", 20, 50, 20, DARKGRAY);

            EndDrawing();
        }
    }

    CloseWindow();
}