/* ******************************************************************************************
*
*   raylib [shaders] example - Hot reloading
*
*   NOTE: This example requires raylib OpenGL 3.3 for shaders support and only #version 330
*         is currently supported. OpenGL ES 2.0 platforms are not supported at the moment.
*
*   Example originally created with raylib 3.0, last time updated with raylib 3.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2020-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - hot reloading");

    fragShaderFileName := "resources/shaders/glsl%/reload.fs";
    fragShaderFileModTime := GetFileModTime(TextFormat(fragShaderFileName, GLSL_VERSION));

    // Load raymarching shader
    // NOTE: Defining 0 (null) for vertex shader forces usage of internal default vertex shader
    shader := LoadShader(null, TextFormat(fragShaderFileName, GLSL_VERSION));

    // Get shader locations for required uniforms
    resolutionLoc := GetShaderLocation(shader, "resolution");
    mouseLoc      := GetShaderLocation(shader, "mouse");
    timeLoc       := GetShaderLocation(shader, "time");

    resolution: [2] float = .[ cast(float) SCREEN_WIDTH, cast(float) SCREEN_HEIGHT ];
    SetShaderValue(shader, resolutionLoc, *resolution, xx ShaderUniformDataType.VEC2);

    totalTime := 0.0;
    shaderAutoReloading := false;

    SetTargetFPS(60);                       // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())            // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        totalTime += GetFrameTime();
        mouse := GetMousePosition();
        mousePos := float.[ mouse.x, mouse.y ];

        // Set shader required uniform values
        SetShaderValue(shader, timeLoc, *totalTime, xx ShaderUniformDataType.FLOAT);
        SetShaderValue(shader, mouseLoc, *mousePos, xx ShaderUniformDataType.VEC2);

        // Hot shader reloading
        if (shaderAutoReloading || (IsMouseButtonPressed(xx MouseButton.LEFT)))
        {
            currentFragShaderModTime := GetFileModTime(TextFormat(fragShaderFileName, GLSL_VERSION));

            // Check if shader file has been modified
            if (currentFragShaderModTime != fragShaderFileModTime)
            {
                // Try reloading updated shader
                updatedShader := LoadShader(null, TextFormat(fragShaderFileName, GLSL_VERSION));

                if (updatedShader.id != rlGetShaderIdDefault())      // It was correctly loaded
                {
                    UnloadShader(shader);
                    shader = updatedShader;

                    // Get shader locations for required uniforms
                    resolutionLoc = GetShaderLocation(shader, "resolution");
                    mouseLoc      = GetShaderLocation(shader, "mouse");
                    timeLoc       = GetShaderLocation(shader, "time");

                    // Reset required uniforms
                    SetShaderValue(shader, resolutionLoc, *resolution, xx ShaderUniformDataType.VEC2);
                }

                fragShaderFileModTime = currentFragShaderModTime;
            }
        }

        if (IsKeyPressed(xx KeyboardKey.A)) shaderAutoReloading = !shaderAutoReloading;
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            // We only draw a white full-screen rectangle, frame is generated in shader
            BeginShaderMode(shader);
                DrawRectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, WHITE);
            EndShaderMode();

            DrawText(TextFormat("PRESS [A] to TOGGLE SHADER AUTOLOADING: %",
                    ifx shaderAutoReloading then "AUTO" else "MANUAL"), 10, 10, 10, ifx shaderAutoReloading then RED else BLACK);
            if (!shaderAutoReloading) DrawText("MOUSE CLICK to SHADER RE-LOADING", 10, 30, 10, BLACK);

            // DrawText(TextFormat("Shader last modification: %", asctime(localtime(&fragShaderFileModTime))), 10, 430, 10, BLACK);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);

    CloseWindow();                  // Close window and OpenGL context
    //--------------------------------------------------------------------------------------


}
