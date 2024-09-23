/* ******************************************************************************************
*
*   raylib [shapes] example - Cubic-bezier lines
*
*   Example originally created with raylib 1.7, last time updated with raylib 1.7
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - cubic-bezier lines");

    startPoint := Vector2.{ 30, 30 };
    endPoint   := Vector2.{ cast(float) SCREEN_WIDTH - 30, cast(float) SCREEN_HEIGHT - 30 };
    moveStartPoint := false;
    moveEndPoint   := false;

    SetTargetFPS(60);

    while !WindowShouldClose() {
        mouse := GetMousePosition();

        if      (CheckCollisionPointCircle(mouse, startPoint, 10.0) && IsMouseButtonDown(xx MouseButton.LEFT)) moveStartPoint = true;
        else if (CheckCollisionPointCircle(mouse, endPoint  , 10.0) && IsMouseButtonDown(xx MouseButton.LEFT)) moveEndPoint   = true;

        if (moveStartPoint) {
            startPoint = mouse;
            if (IsMouseButtonReleased(xx MouseButton.LEFT)) moveStartPoint = false;
        }

        if (moveEndPoint) {
            endPoint = mouse;
            if (IsMouseButtonReleased(xx MouseButton.LEFT)) moveEndPoint = false;
        }
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("MOVE START-END POINTS WITH MOUSE", 15, 20, 20, GRAY);

            // Draw line Cubic Bezier, in-out interpolation (easing), no control points
            DrawLineBezier(startPoint, endPoint, 4.0, BLUE);

            // Draw start-end spline circles with some details
            DrawCircleV(startPoint, ifx CheckCollisionPointCircle(mouse, startPoint, 10.0) then 14.0 else 8.0, ifx moveStartPoint then RED else BLUE);
            DrawCircleV(endPoint  , ifx CheckCollisionPointCircle(mouse, endPoint  , 10.0) then 14.0 else 8.0, ifx moveEndPoint   then RED else BLUE);

        EndDrawing();
    }

    CloseWindow();
}