/* ******************************************************************************************
*
*   raylib [shaders] example - basic lighting
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3).
*
*   Example originally created with raylib 3.0, last time updated with raylib 4.2
*
*   Example contributed by Chris Camacho (@codifies) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 Chris Camacho (@codifies) and Ramon Santamaria (@raysan5)
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
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - basic lighting");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 2.0, 4.0, 6.0 };              // Camera position
    camera.target     = .{ 0.0, 0.5, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Load plane model from a generated mesh
    model := LoadModelFromMesh(GenMeshPlane(10.0, 10.0, 3, 3));
    cube  := LoadModelFromMesh(GenMeshCube(2.0, 4.0, 2.0));

    // Load basic lighting shader
    shader := LoadShader(TextFormat("resources/shaders/glsl%/lighting.vs", GLSL_VERSION),
                               TextFormat("resources/shaders/glsl%/lighting.fs", GLSL_VERSION));
    // Get some required shader locations
    shader.locs[xx ShaderLocationIndex.VECTOR_VIEW] = GetShaderLocation(shader, "viewPos");
    // NOTE: "matModel" location name is automatically assigned on shader loading,
    // no need to get the location again if using that uniform name
    //shader.locs[xx ShaderLocationIndex.MATRIX_MODEL] = GetShaderLocation(shader, "matModel");

    // Ambient light level (some basic lighting)
    ambientLoc := GetShaderLocation(shader, "ambient");
    ambientFloats := float.[ 0.1, 0.1, 0.1, 1.0 ];
    SetShaderValue(shader, ambientLoc, *ambientFloats, xx ShaderUniformDataType.VEC4);

    // Assign out lighting shader to model
    model.materials[0].shader = shader;
    cube.materials[0].shader = shader;

    // Create lights
    lights: [MAX_LIGHTS] Light;
    lights[0] = CreateLight(.POINT, .{ -2, 1, -2 }, Vector3Zero(), YELLOW, *shader);
    lights[1] = CreateLight(.POINT, .{  2, 1,  2 }, Vector3Zero(), RED   , *shader);
    lights[2] = CreateLight(.POINT, .{ -2, 1,  2 }, Vector3Zero(), GREEN , *shader);
    lights[3] = CreateLight(.POINT, .{  2, 1, -2 }, Vector3Zero(), BLUE  , *shader);

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.ORBITAL);

        // Update the shader with the camera view vector (points towards { 0.0, 0.0, 0.0 })
        cameraPos := float.[ camera.position.x, camera.position.y, camera.position.z ];
        SetShaderValue(shader, shader.locs[xx ShaderLocationIndex.VECTOR_VIEW], *cameraPos, xx ShaderUniformDataType.VEC3);

        // Check key inputs to enable/disable lights
        if (IsKeyPressed(xx KeyboardKey.Y)) { lights[0].enabled = !lights[0].enabled; }
        if (IsKeyPressed(xx KeyboardKey.R)) { lights[1].enabled = !lights[1].enabled; }
        if (IsKeyPressed(xx KeyboardKey.G)) { lights[2].enabled = !lights[2].enabled; }
        if (IsKeyPressed(xx KeyboardKey.B)) { lights[3].enabled = !lights[3].enabled; }

        // Update light values (actually, only enable/disable them)
        for i: 0..MAX_LIGHTS - 1 UpdateLightValues(*shader, lights[i]);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawModel(model, Vector3Zero(), 1.0, WHITE);
                DrawModel(cube, Vector3Zero(), 1.0, WHITE);

                // Draw spheres to show where the lights are
                for i: 0..MAX_LIGHTS - 1
                {
                    if (lights[i].enabled) DrawSphereEx(lights[i].position, 0.2, 8, 8, lights[i].color);
                    else DrawSphereWires(lights[i].position, 0.2, 8, 8, ColorAlpha(lights[i].color, 0.3));
                }

                DrawGrid(10, 1.0);

            EndMode3D();

            DrawFPS(10, 10);

            DrawText("Use keys [Y][R][G][B] to toggle lights", 10, 40, 20, DARKGRAY);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadModel(model);
    UnloadModel(cube);
    UnloadShader(shader);

    CloseWindow();          // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

}

