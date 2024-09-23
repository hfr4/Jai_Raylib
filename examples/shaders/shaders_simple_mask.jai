/* ******************************************************************************************
*
*   raylib [shaders] example - Simple shader mask
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
********************************************************************************************
*
*   After a model is loaded it has a default material, this material can be
*   modified in place rather than creating one from scratch...
*   While all of the maps have particular names, they can be used for any purpose
*   except for three maps that are applied as cubic maps (see below)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - simple shader mask");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 0.0, 1.0, 2.0 };              // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Define our three models to show the shader on
    torus := GenMeshTorus(0.3, 1, 16, 32);
    model1 := LoadModelFromMesh(torus);

    cube := GenMeshCube(0.8,0.8,0.8);
    model2 := LoadModelFromMesh(cube);

    // Generate model to be shaded just to see the gaps in the other two
    sphere := GenMeshSphere(1, 16, 16);
    model3 := LoadModelFromMesh(sphere);

    // Load the shader
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/mask.fs", GLSL_VERSION));

    // Load and apply the diffuse texture (colour map)
    texDiffuse := LoadTexture("resources/plasma.png");
    model1.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texDiffuse;
    model2.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texDiffuse;

    // Using xx MaterialMapIndex.EMISSION as a spare slot to use for 2nd texture
    // NOTE: Don't use MATERIAL_MAP_IRRADIANCE, MATERIAL_MAP_PREFILTER or  MATERIAL_MAP_CUBEMAP as they are bound as cube maps
    texMask := LoadTexture("resources/mask.png");
    model1.materials[0].maps[xx MaterialMapIndex.EMISSION].texture = texMask;
    model2.materials[0].maps[xx MaterialMapIndex.EMISSION].texture = texMask;
    shader.locs[xx ShaderLocationIndex.MAP_EMISSION] = GetShaderLocation(shader, "mask");

    // Frame is incremented each frame to animate the shader
    shaderFrame := GetShaderLocation(shader, "frame");

    // Apply the shader to the two models
    model1.materials[0].shader = shader;
    model2.materials[0].shader = shader;

    framesCounter: int;
    rotation: Vector3;           // Model rotation angles

    DisableCursor();                    // Limit cursor to relative movement inside the window
    SetTargetFPS(60);                   // Set  to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);

        framesCounter += 1;
        rotation.x += 0.01;
        rotation.y += 0.005;
        rotation.z -= 0.0025;

        // Send frames counter to shader for animation
        SetShaderValue(shader, shaderFrame, *framesCounter, xx ShaderUniformDataType.INT);

        // Rotate one of the models
        model1.transform = MatrixRotateXYZ(rotation);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(DARKBLUE);

            BeginMode3D(camera);

                DrawModel(model1, .{ 0.5, 0.0, 0.0 }, 1, WHITE);
                DrawModelEx(model2, .{ -0.5, 0.0, 0.0 }, .{ 1.0, 1.0, 0.0 }, 50, .{ 1.0, 1.0, 1.0 }, WHITE);
                DrawModel(model3,.{ 0.0, 0.0, -1.5 }, 1, WHITE);
                DrawGrid(10, 1.0);        // Draw a grid

            EndMode3D();

            DrawRectangle(16, 698, MeasureText(TextFormat("Frame: %", framesCounter), 20) + 8, 42, BLUE);
            DrawText(TextFormat("Frame: %", framesCounter), 20, 700, 20, WHITE);

            DrawFPS(10, 10);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadModel(model1);
    UnloadModel(model2);
    UnloadModel(model3);

    UnloadTexture(texDiffuse);
    UnloadTexture(texMask);

    UnloadShader(shader);

    CloseWindow();
}
