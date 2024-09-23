/* ******************************************************************************************
*
*   raylib [core] example - Initialize 3d camera mode
*
*   Example originally created with raylib 1.0, last time updated with raylib 1.0
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 3d camera mode");

    // Define the camera to look into our 3d world
    camera: Camera3D;
    camera.position   = .{ 0.0, 10.0, 10.0 };            // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera mode type

    cubePosition := Vector3.{ 0.0, 0.0, 0.0 };

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // TODO: Update your variables here

        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawCube(cubePosition, 2.0, 2.0, 2.0, RED);
                DrawCubeWires(cubePosition, 2.0, 2.0, 2.0, MAROON);

                DrawGrid(10, 1.0);

            EndMode3D();

            DrawText("Welcome to the third dimension!", 10, 40, 20, DARKGRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }

    CloseWindow();
}