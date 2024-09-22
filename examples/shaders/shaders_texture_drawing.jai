/* ******************************************************************************************
*
*   raylib [textures] example - Texture drawing
*
*   NOTE: This example illustrates how to draw into a blank texture using a shader
*
*   Example originally created with raylib 2.0, last time updated with raylib 3.7
*
*   Example contributed by Michał Ciesielski and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 Michał Ciesielski and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - texture drawing");

    imBlank := GenImageColor(1024, 1024, BLANK);
    texture := LoadTextureFromImage(imBlank);  // Load blank texture to fill on shader
    UnloadImage(imBlank);

    // NOTE: Using GLSL 330 shader version, on OpenGL ES 2.0 use GLSL 100 shader version
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/cubes_panning.fs", GLSL_VERSION));

    time := 0.0;
    timeLoc := GetShaderLocation(shader, "uTime");
    SetShaderValue(shader, timeLoc, *time, xx ShaderUniformDataType.FLOAT);

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    // -------------------------------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        time = cast(float) GetTime();
        SetShaderValue(shader, timeLoc, *time, xx ShaderUniformDataType.FLOAT);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginShaderMode(shader);    // Enable our custom shader for next shapes/textures drawings
                DrawTexture(texture, 0, 0, WHITE);  // Drawing BLANK texture, all magic happens on shader
            EndShaderMode();            // Disable our custom shader, return to default shader

            DrawText("BACKGROUND is PAINTED and ANIMATED on SHADER!", 10, 10, 20, MAROON);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);

    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

}
