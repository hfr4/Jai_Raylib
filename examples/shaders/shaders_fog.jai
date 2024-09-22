/* ******************************************************************************************
*
*   raylib [shaders] example - fog
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3).
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.7
*
*   Example contributed by Chris Camacho (@chriscamacho) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 Chris Camacho (@chriscamacho) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

#load "rlights.jai";

GLSL_VERSION :: 330;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);  // Enable Multi Sampling Anti Aliasing 4x (if available)
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - fog");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 2.0, 2.0, 6.0 };              // Camera position
    camera.target     = .{ 0.0, 0.5, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Load models and texture
    modelA := LoadModelFromMesh(GenMeshTorus(0.4, 1.0, 16, 32));
    modelB := LoadModelFromMesh(GenMeshCube(1.0, 1.0, 1.0));
    modelC := LoadModelFromMesh(GenMeshSphere(0.5, 32, 32));
    texture := LoadTexture("resources/texel_checker.png");

    // Assign texture to default model material
    modelA.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;
    modelB.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;
    modelC.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;

    // Load shader and set up some uniforms
    shader := LoadShader(TextFormat("resources/shaders/glsl%/lighting.vs", GLSL_VERSION),
                               TextFormat("resources/shaders/glsl%/fog.fs", GLSL_VERSION));
    shader.locs[xx ShaderLocationIndex.MATRIX_MODEL] = GetShaderLocation(shader, "matModel");
    shader.locs[xx ShaderLocationIndex.VECTOR_VIEW]  = GetShaderLocation(shader, "viewPos");

    // Ambient light level
    ambientLoc := GetShaderLocation(shader, "ambient");
    ambientVec := float.[ 0.2, 0.2, 0.2, 1.0 ];
    SetShaderValue(shader, ambientLoc, *ambientVec, xx ShaderUniformDataType.VEC4);

    fogDensity := 0.15;
    fogDensityLoc := GetShaderLocation(shader, "fogDensity");
    SetShaderValue(shader, fogDensityLoc, *fogDensity, xx ShaderUniformDataType.FLOAT);

    // NOTE: All models share the same shader
    modelA.materials[0].shader = shader;
    modelB.materials[0].shader = shader;
    modelC.materials[0].shader = shader;

    // Using just 1 point lights
    CreateLight(.POINT, .{ 0, 2, 6 }, Vector3Zero(), WHITE, *shader);

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.ORBITAL);

        if (IsKeyDown(xx KeyboardKey.UP))
        {
            fogDensity += 0.001;
            if (fogDensity > 1.0) fogDensity = 1.0;
        }

        if (IsKeyDown(xx KeyboardKey.DOWN))
        {
            fogDensity -= 0.001;
            if (fogDensity < 0.0) fogDensity = 0.0;
        }

        SetShaderValue(shader, fogDensityLoc, *fogDensity, xx ShaderUniformDataType.FLOAT);

        // Rotate the torus
        modelA.transform = MatrixMultiply(modelA.transform, MatrixRotateX(-0.025));
        modelA.transform = MatrixMultiply(modelA.transform, MatrixRotateZ( 0.012));

        // Update the light shader with the camera view position
        SetShaderValue(shader, shader.locs[xx ShaderLocationIndex.VECTOR_VIEW], *camera.position, xx ShaderUniformDataType.VEC3);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(GRAY);

            BeginMode3D(camera);

                // Draw the three models
                DrawModel(modelA, Vector3Zero()  , 1.0, WHITE);
                DrawModel(modelB, .{ -2.6, 0, 0 }, 1.0, WHITE);
                DrawModel(modelC, .{  2.6, 0, 0 }, 1.0, WHITE);

                for i: -10..9 DrawModel(modelA, .{ i * 2.0, 0, 2 }, 1.0, WHITE);

            EndMode3D();

            DrawText(TextFormat("Use KEY_UP/KEY_DOWN to change fog density [%]", fogDensity), 10, 10, 20, RAYWHITE);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadModel(modelA);        // Unload the model A
    UnloadModel(modelB);        // Unload the model B
    UnloadModel(modelC);        // Unload the model C
    UnloadTexture(texture);     // Unload the texture
    UnloadShader(shader);       // Unload shader

    CloseWindow();}
