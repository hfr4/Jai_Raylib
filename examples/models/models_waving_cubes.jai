/* ******************************************************************************************
*
*   raylib [models] example - Waving cubes
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.7
*
*   Example contributed by Codecat (@codecat) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Codecat (@codecat) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - waving cubes");

    // Initialize the camera
    camera: Camera3D;
    camera.position   = .{ 30.0, 20.0, 30.0 };           // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 70.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Specify the amount of blocks in each direction
    numBlocks := 15;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        time := GetTime();

        // Calculate time scale for cube position and size
        scale := (2.0 + cast(float) Math.sin(time))*0.7;

        // Move camera around the scene
        cameraTime := time*0.3;
        camera.position.x = cast(float) Math.cos(cameraTime)*40.0;
        camera.position.z = cast(float) Math.sin(cameraTime)*40.0;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawGrid(10, 5.0);

                for x: 0..numBlocks - 1
                {
                    for y: 0..numBlocks - 1
                    {
                        for z: 0..numBlocks - 1
                        {
                            // Scale of the blocks depends on x/y/z positions
                            blockScale := (x + y + z)/30.0;

                            // Scatter makes the waving effect by adding blockScale over time
                            scatter := Math.sin(blockScale*20.0 + cast(float) (time*4.0));

                            // Calculate the cube position
                            cubePos := Vector3.{
                                cast(float) (x - numBlocks/2)*(scale*3.0) + scatter,
                                cast(float) (y - numBlocks/2)*(scale*2.0) + scatter,
                                cast(float) (z - numBlocks/2)*(scale*3.0) + scatter
                            };

                            // Pick a color with a hue depending on cube position for the rainbow color effect
                            // NOTE: This function is quite costly to be done per cube and frame,
                            // pre-catching the results into a separate array could improve performance
                            cubeColor := ColorFromHSV(cast(float) (((x + y + z)*18)%360), 0.75, 0.9);

                            // Calculate cube size
                            cubeSize := (2.4 - scale)*blockScale;

                            // And finally, draw the cube!
                            DrawCube(cubePos, cubeSize, cubeSize, cubeSize, cubeColor);
                        }
                    }
                }

            EndMode3D();

            DrawFPS(10, 10);

        EndDrawing();
    }
    CloseWindow();
}