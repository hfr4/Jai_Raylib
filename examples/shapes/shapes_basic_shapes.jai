/* ******************************************************************************************
*
*   raylib [shapes] example - Draw basic shapes 2d (rectangle, circle, line...)
*
*   Example originally created with raylib 1.0, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - basic shapes drawing");

    rotation := 0.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {
        rotation += 0.2;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("some basic shapes available on raylib", 20, 20, 20, DARKGRAY);

            // Circle shapes and lines
            DrawCircle(SCREEN_WIDTH/5, 120, 35, DARKBLUE);
            DrawCircleGradient(SCREEN_WIDTH/5, 220, 60, GREEN, SKYBLUE);
            DrawCircleLines(SCREEN_WIDTH/5, 340, 80, DARKBLUE);

            // Rectangle shapes and lines
            DrawRectangle(SCREEN_WIDTH/4*2 - 60, 100, 120, 60, RED);
            DrawRectangleGradientH(SCREEN_WIDTH/4*2 - 90, 170, 180, 130, MAROON, GOLD);
            DrawRectangleLines(SCREEN_WIDTH/4*2 - 40, 320, 80, 60, ORANGE);  // NOTE: Uses QUADS internally, not lines

            // Triangle shapes and lines
            DrawTriangle(.{ SCREEN_WIDTH/4.0 *3.0, 80.0 },
                         .{ SCREEN_WIDTH/4.0 *3.0 - 60.0, 150.0 },
                         .{ SCREEN_WIDTH/4.0 *3.0 + 60.0, 150.0 }, VIOLET);

            DrawTriangleLines(.{ SCREEN_WIDTH/4.0*3.0, 160.0 },
                              .{ SCREEN_WIDTH/4.0*3.0 - 20.0, 230.0 },
                              .{ SCREEN_WIDTH/4.0*3.0 + 20.0, 230.0 }, DARKBLUE);

            // Polygon shapes and lines
            DrawPoly(.{ SCREEN_WIDTH/4.0*3, 330 }, 6, 80, rotation, BROWN);
            DrawPolyLines(.{ SCREEN_WIDTH/4.0*3, 330 }, 6, 90, rotation, BROWN);
            DrawPolyLinesEx(.{ SCREEN_WIDTH/4.0*3, 330 }, 6, 85, rotation, 6, BEIGE);

            // NOTE: We draw all LINES based shapes together to optimize internal drawing,
            // this way, all LINES are rendered in a single draw pass
            DrawLine(18, 42, SCREEN_WIDTH - 18, 42, BLACK);
        EndDrawing();
    }
    CloseWindow();
}