/* ******************************************************************************************
*
*   raylib [models] example - Show the difference between perspective and orthographic projection
*
*   Example originally created with raylib 2.0, last time updated with raylib 3.7
*
*   Example contributed by Max Danielsson (@autious) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2024 Max Danielsson (@autious) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

FOVY_PERSPECTIVE   :: 45.0;
WIDTH_ORTHOGRAPHIC :: 10.0;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - geometric shapes");

    // Define the camera to look into our 3d world
    camera: Camera = .{
        .{ 0.0, 10.0, 10.0 },
        .{ 0.0, 0.0, 0.0 },
        .{ 0.0, 1.0, 0.0 },
        FOVY_PERSPECTIVE,
        xx CameraProjection.PERSPECTIVE,
    };

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyPressed(xx KeyboardKey.SPACE))
        {
            if (camera.projection == xx CameraProjection.PERSPECTIVE)
            {
                camera.fovy       = WIDTH_ORTHOGRAPHIC;
                camera.projection = xx CameraProjection.ORTHOGRAPHIC;
            }
            else
            {
                camera.fovy       = FOVY_PERSPECTIVE;
                camera.projection = xx CameraProjection.PERSPECTIVE;
            }
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawCube(.{-4.0, 0.0, 2.0}, 2.0, 5.0, 2.0, RED);
                DrawCubeWires(.{-4.0, 0.0, 2.0}, 2.0, 5.0, 2.0, GOLD);
                DrawCubeWires(.{-4.0, 0.0, -2.0}, 3.0, 6.0, 2.0, MAROON);

                DrawSphere(.{-1.0, 0.0, -2.0}, 1.0, GREEN);
                DrawSphereWires(.{1.0, 0.0, 2.0}, 2.0, 16, 16, LIME);

                DrawCylinder(.{4.0, 0.0, -2.0}, 1.0, 2.0, 3.0, 4, SKYBLUE);
                DrawCylinderWires(.{4.0, 0.0, -2.0}, 1.0, 2.0, 3.0, 4, DARKBLUE);
                DrawCylinderWires(.{4.5, -1.0, 2.0}, 1.0, 1.0, 2.0, 6, BROWN);

                DrawCylinder(.{1.0, 0.0, -4.0}, 0.0, 1.5, 3.0, 8, GOLD);
                DrawCylinderWires(.{1.0, 0.0, -4.0}, 0.0, 1.5, 3.0, 8, PINK);

                DrawGrid(10, 1.0);        // Draw a grid

            EndMode3D();

            DrawText("Press Spacebar to switch camera type", 10, GetScreenHeight() - 30, 20, DARKGRAY);

            if      (camera.projection == xx CameraProjection.ORTHOGRAPHIC) DrawText("ORTHOGRAPHIC", 10, 40, 20, BLACK);
            else if (camera.projection == xx CameraProjection.PERSPECTIVE)  DrawText("PERSPECTIVE" , 10, 40, 20, BLACK);

            DrawFPS(10, 10);

        EndDrawing();
    }
    CloseWindow();
}