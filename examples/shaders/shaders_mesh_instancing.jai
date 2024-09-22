/* ******************************************************************************************
*
*   raylib [shaders] example - Mesh instancing
*
*   Example originally created with raylib 3.7, last time updated with raylib 4.2
*
*   Example contributed by @seanpringle and reviewed by Max (@moliad) and Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2020-2023 @seanpringle, Max (@moliad) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

#load "rlights.jai";

GLSL_VERSION :: 330;

MAX_INSTANCES :: 10000;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - mesh instancing");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ -125.0, 125.0, -125.0 };      // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Define mesh to be instanced
    cube := GenMeshCube(1.0, 1.0, 1.0);

    // Define transforms to be uploaded to GPU for instances
    transforms := cast(*Matrix) alloc(MAX_INSTANCES * size_of(Matrix));   // Pre-multiplied transformations passed to rlgl

    // Translate and rotate cubes randomly
    for i: 0..MAX_INSTANCES - 1
    {
        translation := MatrixTranslate(cast(float) GetRandomValue(-50, 50), cast(float) GetRandomValue(-50, 50), cast(float) GetRandomValue(-50, 50));
        axis        := Vector3Normalize(.{ cast(float) GetRandomValue(0, 360), cast(float) GetRandomValue(0, 360), cast(float) GetRandomValue(0, 360) });
        angle       := cast(float) (GetRandomValue(0, 10)*DEG2RAD);
        rotation    := MatrixRotate(axis, angle);

        transforms[i] = MatrixMultiply(rotation, translation);
    }

    // Load lighting shader
    shader := LoadShader(TextFormat("resources/shaders/glsl%/lighting_instancing.vs", GLSL_VERSION),
                               TextFormat("resources/shaders/glsl%/lighting.fs", GLSL_VERSION));
    // Get shader locations
    shader.locs[xx ShaderLocationIndex.MATRIX_MVP]   = GetShaderLocation(shader, "mvp");
    shader.locs[xx ShaderLocationIndex.VECTOR_VIEW]  = GetShaderLocation(shader, "viewPos");
    shader.locs[xx ShaderLocationIndex.MATRIX_MODEL] = GetShaderLocationAttrib(shader, "instanceTransform");

    // Set shader value: ambient light level
    ambientLoc := GetShaderLocation(shader, "ambient");
    ambientVec := float.[ 0.2, 0.2, 0.2, 1.0 ];
    SetShaderValue(shader, ambientLoc, *ambientVec, xx ShaderUniformDataType.VEC4);

    // Create one light
    CreateLight(.DIRECTIONAL, .{ 50.0, 50.0, 0.0 }, Vector3Zero(), WHITE, *shader);

    // NOTE: We are assigning the intancing shader to material.shader
    // to be used on mesh drawing with DrawMeshInstanced()
    matInstances := LoadMaterialDefault();
    matInstances.shader = shader;
    matInstances.maps[xx MaterialMapIndex.ALBEDO].color = RED;

    // Load default material (using raylib intenral default shader) for non-instanced mesh drawing
    // WARNING: Default shader enables vertex color attribute BUT GenMeshCube() does not generate vertex colors, so,
    // when drawing the color attribute is disabled and a default color value is provided as input for thevertex attribute
    matDefault := LoadMaterialDefault();
    matDefault.maps[xx MaterialMapIndex.ALBEDO].color = BLUE;

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.ORBITAL);

        // Update the light shader with the camera view position
         cameraPos := float.[ camera.position.x, camera.position.y, camera.position.z ];
        SetShaderValue(shader, shader.locs[xx ShaderLocationIndex.VECTOR_VIEW], *cameraPos, xx ShaderUniformDataType.VEC3);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                // Draw cube mesh with default material (BLUE)
                DrawMesh(cube, matDefault, MatrixTranslate(-10.0, 0.0, 0.0));

                // Draw meshes instanced using material containing instancing shader (RED + lighting),
                // transforms[] for the instances should be provided, they are dynamically
                // updated in GPU every frame, so we can animate the different mesh instances
                DrawMeshInstanced(cube, matInstances, transforms, MAX_INSTANCES);

                // Draw cube mesh with default material (BLUE)
                DrawMesh(cube, matDefault, MatrixTranslate(10.0, 0.0, 0.0));

            EndMode3D();

            DrawFPS(10, 10);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    free(transforms);    // Free transforms

    CloseWindow();          // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

}
