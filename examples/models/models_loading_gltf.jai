/* ******************************************************************************************
*
*   raylib [models] example - loading gltf with animations
*
*   LIMITATIONS:
*     - Only supports 1 armature per file, and skips loading it if there are multiple armatures
*     - Only supports linear interpolation (default method in Blender when checked
*       "Always Sample Animations" when exporting a GLTF file)
*     - Only supports translation/rotation/scale animation channel.path,
*       weights not considered (i.e. morph targets)
*
*   Example originally created with raylib 3.7, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2020-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - loading gltf animations");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 6.0, 6.0, 6.0 };               // Camera position
    camera.target     = .{ 0.0, 2.0, 0.0 };               // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };               // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                             // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE;  // Camera projection type

    // Load gltf model
    model := LoadModel("resources/models/gltf/robot.glb");
    position := Vector3.{ 0.0, 0.0, 0.0 }; // Set model position

    // Load gltf model animations
    animsCount : s32 = 0;
    animIndex := 0;
    animCurrentFrame : s32 = 0;
    modelAnimations := LoadModelAnimations("resources/models/gltf/robot.glb", *animsCount);

    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateCamera(*camera, xx CameraMode.ORBITAL);

        // Select current animation
        if      (IsMouseButtonPressed(xx MouseButton.RIGHT)) animIndex = (animIndex + 1)              % animsCount;
        else if (IsMouseButtonPressed(xx MouseButton.LEFT))  animIndex = (animIndex + animsCount - 1) % animsCount;

        // Update model animation
        anim := modelAnimations[animIndex];
        animCurrentFrame = (animCurrentFrame + 1) % anim.frameCount;
        UpdateModelAnimation(model, anim, animCurrentFrame);

        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);
                DrawModel(model, position, 1.0, WHITE);    // Draw animated model
                DrawGrid(10, 1.0);
            EndMode3D();

            DrawText("Use the LEFT/RIGHT mouse buttons to switch animation", 10, 10, 20, GRAY);
            DrawText(TextFormat("Animation: %", anim.name), 10, GetScreenHeight() - 20, 10, DARKGRAY);

        EndDrawing();
    }

    UnloadModel(model);

    CloseWindow();
}


