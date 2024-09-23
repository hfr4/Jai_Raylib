/* ******************************************************************************************
*
*   raylib [shaders] example - texture tiling
*
*   Example demonstrates how to tile a texture on a 3D model using raylib.
*
*   Example contributed by Luis Almeida (@luis605) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 Luis Almeida (@luis605)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - texture tiling");

    // Define the camera to look into our 3d world
    camera: Camera3D;
    camera.position   = .{ 4.0, 4.0, 4.0 };              // Camera position
    camera.target     = .{ 0.0, 0.5, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Load a cube model
    cube := GenMeshCube(1.0, 1.0, 1.0);
    model := LoadModelFromMesh(cube);

    // Load a texture and assign to cube model
    texture := LoadTexture("resources/cubicmap_atlas.png");
    model.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;

    // Set the texture tiling using a shader
    tiling : [2] float = .[ 3.0, 3.0 ];
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/tiling.fs", GLSL_VERSION));
    SetShaderValue(shader, GetShaderLocation(shader, "tiling"), *tiling, xx ShaderUniformDataType.VEC2);
    model.materials[0].shader = shader;

    DisableCursor();                    // Limit cursor to relative movement inside the window

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.FREE);

        if (IsKeyPressed(xx KeyboardKey.Z)) camera.target = .{ 0.0, 0.5, 0.0 };
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                BeginShaderMode(shader);
                    DrawModel(model, .{ 0.0, 0.0, 0.0 }, 2.0, WHITE);
                EndShaderMode();

                DrawGrid(10, 1.0);

            EndMode3D();

            DrawText("Use mouse to rotate the camera", 10, 10, 20, DARKGRAY);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadModel(model);
    UnloadShader(shader);
    UnloadTexture(texture);

    CloseWindow();
}
