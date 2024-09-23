/* ******************************************************************************************
*
*   raylib [shaders] example - Model shader
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3), to test this example
*         on OpenGL ES 2.0 platforms (Android, Raspberry Pi, HTML5), use #version 100 shaders
*         raylib comes with shaders ready for both versions, check raylib/shaders install folder
*
*   Example originally created with raylib 1.3, last time updated with raylib 3.7
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);      // Enable Multi Sampling Anti Aliasing 4x (if available)

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - model shader");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 4.0, 4.0, 4.0 };              // Camera position
    camera.target     = .{ 0.0, 1.0, -1.0 };             // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    model   := LoadModel("resources/models/watermill.obj");           // Load OBJ model
    texture := LoadTexture("resources/models/watermill_diffuse.png"); // Load model texture

    // Load shader for model
    // NOTE: Defining 0 (null) for vertex shader forces usage of internal default vertex shader
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/grayscale.fs", GLSL_VERSION));

    model.materials[0].shader = shader;                     // Set shader effect to 3d model
    model.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture; // Bind texture to model

    position: Vector3; // Set model position

    DisableCursor();                    // Limit cursor to relative movement inside the window
    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawModel(model, position, 0.2, WHITE);   // Draw 3d model with texture

                DrawGrid(10, 1.0);     // Draw a grid

            EndMode3D();

            DrawText("(c) Watermill 3D model by Alberto Cano", xx (SCREEN_WIDTH - 210), xx (SCREEN_HEIGHT - 20), 10, GRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);
    UnloadTexture(texture);
    UnloadModel(model);

    CloseWindow();

}