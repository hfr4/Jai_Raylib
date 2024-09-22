/* ******************************************************************************************
*
*   raylib [models] example - Load models M3D
*
*   Example originally created with raylib 4.5, last time updated with raylib 4.5
*
*   Example contributed by bzt (@bztsrc) and reviewed by Ramon Santamaria (@raysan5)
*
*   NOTES:
*     - Model3D (M3D) fileformat specs: https://gitlab.com/bztsrc/model3d
*     - Bender M3D exported: https://gitlab.com/bztsrc/model3d/-/tree/master/blender
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022-2024 bzt (@bztsrc)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - M3D model loading");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 1.5, 1.5, 1.5 };              // Camera position
    camera.target     = .{ 0.0, 0.4, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    position := Vector3.{ 0.0, 0.0, 0.0 };            // Set model position

    modelFileName := "resources/models/m3d/cesium_man.m3d";
    drawMesh := 1;
    drawSkeleton := 1;
    animPlaying := false;   // Store anim state, what to draw

    // Load model
    model := LoadModel(modelFileName.data); // Load the bind-pose model mesh and basic data

    // Load animations
    animsCount : s32 = 0;
    animFrameCounter : s32 = 0;
    animId := 0;
    anims := LoadModelAnimations(modelFileName.data, *animsCount); // Load skeletal animation data

    DisableCursor();                    // Limit cursor to relative movement inside the window

    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);

        if (animsCount)
        {
            // Play animation when spacebar is held down (or step one frame with N)
            if (IsKeyDown(xx KeyboardKey.SPACE) || IsKeyPressed(xx KeyboardKey.N))
            {
                animFrameCounter+= 1;

                if (animFrameCounter >= anims[animId].frameCount) animFrameCounter = 0;

                UpdateModelAnimation(model, anims[animId], animFrameCounter);
                animPlaying = true;
            }

            // Select animation by pressing C
            if (IsKeyPressed(xx KeyboardKey.C))
            {
                animFrameCounter = 0;
                animId+= 1;

                if (animId >= cast(s32) animsCount) animId = 0;
                UpdateModelAnimation(model, anims[animId], 0);
                animPlaying = true;
            }
        }

        // Toggle skeleton drawing
        if (IsKeyPressed(xx KeyboardKey.B)) drawSkeleton ^= 1;

        // Toggle mesh drawing
        if (IsKeyPressed(xx KeyboardKey.M)) drawMesh ^= 1;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                // Draw 3d model with texture
                if (drawMesh) DrawModel(model, position, 1.0, WHITE);

                // Draw the animated skeleton
                if (drawSkeleton)
                {
                    // Loop to (boneCount - 1) because the last one is a special "no bone" bone,
                    // needed to workaround buggy models
                    // without a -1, we would always draw a cube at the origin
                    for i: 0..model.boneCount - 1
                    {
                        // By default the model is loaded in bind-pose by LoadModel().
                        // But if UpdateModelAnimation() has been called at least once
                        // then the model is already in animation pose, so we need the animated skeleton
                        if (!animPlaying || !animsCount)
                        {
                            // Display the bind-pose skeleton
                            DrawCube(model.bindPose[i].translation, 0.04, 0.04, 0.04, RED);

                            if (model.bones[i].parent >= 0)
                            {
                                DrawLine3D(model.bindPose[i].translation,
                                    model.bindPose[model.bones[i].parent].translation, RED);
                            }
                        }
                        else
                        {
                            // Display the frame-pose skeleton
                            DrawCube(anims[animId].framePoses[animFrameCounter][i].translation, 0.05, 0.05, 0.05, RED);

                            if (anims[animId].bones[i].parent >= 0)
                            {
                                DrawLine3D(anims[animId].framePoses[animFrameCounter][i].translation,
                                    anims[animId].framePoses[animFrameCounter][anims[animId].bones[i].parent].translation, RED);
                            }
                        }
                    }
                }

                DrawGrid(10, 1.0);         // Draw a grid

            EndMode3D();

            DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, GetScreenHeight() - 80, 10, MAROON);
            DrawText("PRESS N to STEP ONE ANIMATION FRAME", 10, GetScreenHeight() - 60, 10, DARKGRAY);
            DrawText("PRESS C to CYCLE THROUGH ANIMATIONS", 10, GetScreenHeight() - 40, 10, DARKGRAY);
            DrawText("PRESS M to toggle MESH, B to toggle SKELETON DRAWING", 10, GetScreenHeight() - 20, 10, DARKGRAY);
            DrawText("(c) CesiumMan model by KhronosGroup", GetScreenWidth() - 210, GetScreenHeight() - 20, 10, GRAY);

        EndDrawing();
    }


    // Unload model animations data
    UnloadModelAnimations(anims, animsCount);

    UnloadModel(model);         // Unload model

    CloseWindow();
}
