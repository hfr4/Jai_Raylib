/* ******************************************************************************************
*
*   raylib [core] example - Picking in 3d mode
*
*   Example originally created with raylib 1.3, last time updated with raylib 4.0
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 3d picking");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 10.0, 10.0, 10.0 };           // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    cubePosition := Vector3.{ 0.0, 1.0, 0.0 };
    cubeSize     := Vector3.{ 2.0, 2.0, 2.0 };

    ray: Ray;                    // Picking line ray
    collision: RayCollision;     // Ray collision hit info

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsCursorHidden()) UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);

        // Toggle camera controls
        if (IsMouseButtonPressed(xx MouseButton.RIGHT))
        {
            if (IsCursorHidden()) EnableCursor();
            else DisableCursor();
        }

        if (IsMouseButtonPressed(xx MouseButton.LEFT))
        {
            if (!collision.hit)
            {
                ray = GetMouseRay(GetMousePosition(), camera);

                // Check collision between ray and box
                bb := BoundingBox.{
                    .{ cubePosition.x - cubeSize.x/2, cubePosition.y - cubeSize.y/2, cubePosition.z - cubeSize.z/2 },
                    .{ cubePosition.x + cubeSize.x/2, cubePosition.y + cubeSize.y/2, cubePosition.z + cubeSize.z/2 },
                };
                collision = GetRayCollisionBox(ray, bb);
            }
            else collision.hit = false;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                if (collision.hit)
                {
                    DrawCube(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, RED);
                    DrawCubeWires(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, MAROON);

                    DrawCubeWires(cubePosition, cubeSize.x + 0.2, cubeSize.y + 0.2, cubeSize.z + 0.2, GREEN);
                }
                else
                {
                    DrawCube(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, GRAY);
                    DrawCubeWires(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, DARKGRAY);
                }

                DrawRay(ray, MAROON);
                DrawGrid(10, 1.0);

            EndMode3D();

            DrawText("Try clicking on the box with your mouse!", 240, 10, 20, DARKGRAY);

            if (collision.hit) DrawText("BOX SELECTED", (SCREEN_WIDTH - MeasureText("BOX SELECTED", 30)) / 2, cast(s32) (SCREEN_HEIGHT * 0.1), 30, GREEN);

            DrawText("Right click mouse to toggle camera controls", 10, 430, 10, GRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }
    CloseWindow();
}
