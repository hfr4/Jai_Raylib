/* ******************************************************************************************
*
*   raylib [shaders] example - Raymarching shapes generation
*
*   NOTE: This example requires raylib OpenGL 3.3 for shaders support and only #version 330
*         is currently supported. OpenGL ES 2.0 platforms are not supported at the moment.
*
*   Example originally created with raylib 2.0, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.WINDOW_RESIZABLE);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - raymarching shapes");

    camera: Camera;
    camera.position   = .{ 2.5, 2.5, 3.0 };              // Camera position
    camera.target     = .{ 0.0, 0.0, 0.7 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 65.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Load raymarching shader
    // NOTE: Defining 0 (null) for vertex shader forces usage of internal default vertex shader
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/raymarching.fs", GLSL_VERSION));

    // Get shader locations for required uniforms
    viewEyeLoc    := GetShaderLocation(shader, "viewEye");
    viewCenterLoc := GetShaderLocation(shader, "viewCenter");
    runTimeLoc    := GetShaderLocation(shader, "runTime");
    resolutionLoc := GetShaderLocation(shader, "resolution");

    resolution := float.[ cast(float)SCREEN_WIDTH, cast(float)SCREEN_HEIGHT ];
    SetShaderValue(shader, resolutionLoc, *resolution, xx ShaderUniformDataType.VEC2);

    runTime := 0.0;

    DisableCursor();                    // Limit cursor to relative movement inside the window
    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);

        cameraPos    := float.[ camera.position.x, camera.position.y, camera.position.z ];
        cameraTarget := float.[ camera.target.x  , camera.target.y  , camera.target.z ];

        deltaTime := GetFrameTime();
        runTime += deltaTime;

        // Set shader required uniform values
        SetShaderValue(shader, viewEyeLoc   , *cameraPos   , xx ShaderUniformDataType.VEC3);
        SetShaderValue(shader, viewCenterLoc, *cameraTarget, xx ShaderUniformDataType.VEC3);
        SetShaderValue(shader, runTimeLoc   , *runTime     , xx ShaderUniformDataType.FLOAT);

        // Check if screen is resized
        if (IsWindowResized())
        {
            resolution[0] = cast(float) GetScreenWidth();
            resolution[1] = cast(float) GetScreenHeight();
            SetShaderValue(shader, resolutionLoc, *resolution, xx ShaderUniformDataType.VEC2);
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            // We only draw a white full-screen rectangle,
            // frame is generated in shader using raymarching
            BeginShaderMode(shader);
                DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), WHITE);
            EndShaderMode();

            DrawText("(c) Raymarching shader by Iñigo Quilez. MIT License.", GetScreenWidth() - 280, GetScreenHeight() - 20, 10, BLACK);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);           // Unload shader

    CloseWindow();                  // Close window and OpenGL context
    //--------------------------------------------------------------------------------------


}
