/* ******************************************************************************************
*
*   raylib [models] example - Plane rotations (yaw, pitch, roll)
*
*   Example originally created with raylib 1.8, last time updated with raylib 4.0
*
*   Example contributed by Berni (@Berni8k) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2024 Berni (@Berni8k) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    //SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT | xx ConfigFlags.WINDOW_HIGHDPI);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - plane rotations (yaw, pitch, roll)");

    camera: Camera;
    camera.position   = .{ 0.0, 50.0, -120.0 };          // Camera position perspective
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 30.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera type

    model   := LoadModel("resources/models/obj/plane.obj");            // Load model
    texture := LoadTexture("resources/models/obj/plane_diffuse.png");  // Load model texture
    model.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;            // Set map diffuse texture

    pitch := 0.0;
    roll  := 0.0;
    yaw   := 0.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // Plane pitch (x-axis) controls
        if      (IsKeyDown(xx KeyboardKey.DOWN)) pitch += 0.6;
        else if (IsKeyDown(xx KeyboardKey.UP))   pitch -= 0.6;
        else
        {
            if      (pitch >  0.3) pitch -= 0.3;
            else if (pitch < -0.3) pitch += 0.3;
        }

        // Plane yaw (y-axis) controls
        if      (IsKeyDown(xx KeyboardKey.S)) yaw -= 1.0;
        else if (IsKeyDown(xx KeyboardKey.A)) yaw += 1.0;
        else
        {
            if      (yaw > 0.0) yaw -= 0.5;
            else if (yaw < 0.0) yaw += 0.5;
        }

        // Plane roll (z-axis) controls
        if      (IsKeyDown(xx KeyboardKey.LEFT))  roll -= 1.0;
        else if (IsKeyDown(xx KeyboardKey.RIGHT)) roll += 1.0;
        else
        {
            if      (roll > 0.0) roll -= 0.5;
            else if (roll < 0.0) roll += 0.5;
        }

        // Tranformation matrix for rotations
        model.transform = MatrixRotateXYZ(Vector3.{ xx (DEG2RAD*pitch), xx (DEG2RAD*yaw), xx (DEG2RAD*roll) });

        BeginDrawing();

            ClearBackground(RAYWHITE);

            // Draw 3D model (recomended to draw 3D always before 2D)
            BeginMode3D(camera);

                DrawModel(model, .{ 0.0, -8.0, 0.0 }, 1.0, WHITE);   // Draw 3d model with texture
                DrawGrid(10, 10.0);

            EndMode3D();

            // Draw controls info
            DrawRectangle(30, 370, 260, 70, Fade(GREEN, 0.5));
            DrawRectangleLines(30, 370, 260, 70, Fade(DARKGREEN, 0.5));
            DrawText("Pitch controlled with : UP   / DOWN" , 40, 380, 10, DARKGRAY);
            DrawText("Roll  controlled with : LEFT / RIGHT", 40, 400, 10, DARKGRAY);
            DrawText("Yaw   controlled with : A    / S"    , 40, 420, 10, DARKGRAY);

            DrawText("(c) WWI Plane Model created by GiaHanLam", SCREEN_WIDTH - 240, SCREEN_HEIGHT - 20, 10, DARKGRAY);

        EndDrawing();
    }

    UnloadModel(model);
    UnloadTexture(texture);

    CloseWindow();
}