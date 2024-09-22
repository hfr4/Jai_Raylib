/* ******************************************************************************************
*
*   raylib [core] example - World to screen
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.4
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - core world screen");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 10.0, 10.0, 10.0 };           // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    cubePosition: Vector3;
    cubeScreenPosition: Vector2;

    DisableCursor();                    // Limit cursor to relative movement inside the window

    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateCamera(*camera, xx CameraMode.THIRD_PERSON);

        // Calculate cube screen space position (with a little offset to be in top)
        cubeScreenPosition = GetWorldToScreen(.{cubePosition.x, cubePosition.y + 2.5, cubePosition.z}, camera);


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawCube(cubePosition, 2.0, 2.0, 2.0, RED);
                DrawCubeWires(cubePosition, 2.0, 2.0, 2.0, MAROON);

                DrawGrid(10, 1.0);

            EndMode3D();

            DrawText("Enemy: 100 / 100", cast(s32) cubeScreenPosition.x - MeasureText("Enemy: 100/100", 20)/2, cast(s32) cubeScreenPosition.y, 20, BLACK);

            DrawText(TextFormat("Cube position in screen space coordinates: [%, %]", cast(s32) cubeScreenPosition.x, cast(s32) cubeScreenPosition.y), 10, 10, 20, LIME);
            DrawText("Text 2d should be always on top of the cube", 10, 40, 20, GRAY);

        EndDrawing();
    }

    CloseWindow();
}