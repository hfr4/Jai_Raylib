/* ******************************************************************************************
*
*   raylib [models] example - Load 3d model with animations and play them
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.5
*
*   Example contributed by Culacant (@culacant) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Culacant (@culacant) and Ramon Santamaria (@raysan5)
*
********************************************************************************************
*
*   NOTE: To export a model from blender, make sure it is not posed, the vertices need to be
*         in the same position as they would be in edit mode and the scale of your models is
*         set to 0. Scaling can be done from the export menu.
*
********************************************************************************************/

#import "Basic";
#import "Raylib";


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - model animation");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 10.0, 10.0, 10.0 };           // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera mode type

    model   := LoadModel("resources/models/iqm/guy.iqm");              // Load the animated model mesh and basic data
    texture := LoadTexture("resources/models/iqm/guytex.png");         // Load model texture and set material
    SetMaterialTexture(*model.materials[0], xx MaterialMapIndex.ALBEDO, texture);     // Set model material map texture

    position := Vector3.{ 0.0, 0.0, 0.0 };            // Set model position

    // Load animation data
    animsCount : s32 = 0;
    anims := LoadModelAnimations("resources/models/iqm/guyanim.iqm", *animsCount);
    animFrameCounter : s32 = 0;

    DisableCursor();                    // Catch cursor
    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);

        // Play animation when spacebar is held down
        if (IsKeyDown(xx KeyboardKey.SPACE))
        {
            animFrameCounter += 1;
            UpdateModelAnimation(model, anims[0], animFrameCounter);
            if (animFrameCounter >= anims[0].frameCount) animFrameCounter = 0;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawModelEx(model, position, .{ 1.0, 0.0, 0.0 }, -90.0, .{ 1.0, 1.0, 1.0 }, WHITE);

                for i: 0..model.boneCount - 1
                {
                    DrawCube(anims[0].framePoses[animFrameCounter][i].translation, 0.2, 0.2, 0.2, RED);
                }

                DrawGrid(10, 1.0);         // Draw a grid

            EndMode3D();

            DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, 10, 20, MAROON);
            DrawText("(c) Guy IQM 3D model by @culacant", SCREEN_WIDTH - 200, SCREEN_HEIGHT - 20, 10, GRAY);

        EndDrawing();
    }

    UnloadTexture(texture);                     // Unload texture
    UnloadModelAnimations(anims, animsCount);   // Unload model animations data
    UnloadModel(model);                         // Unload model

    CloseWindow();
}
