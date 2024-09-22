/* ******************************************************************************************
*
*   raylib [shaders] example - Texture Waves
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3), to test this example
*         on OpenGL ES 2.0 platforms (Android, Raspberry Pi, HTML5), use #version 100 shaders
*         raylib comes with shaders ready for both versions, check raylib/shaders install folder
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.7
*
*   Example contributed by Anata (@anatagawa) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 Anata (@anatagawa) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - texture waves");

    // Load texture texture to apply shaders
    texture := LoadTexture("resources/space.png");

    // Load shader and setup location points and values
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/wave.fs", GLSL_VERSION));

    screenLoc  := GetShaderLocation(shader, "size");
    secondsLoc := GetShaderLocation(shader, "seconds");
    freqXLoc   := GetShaderLocation(shader, "freqX");
    freqYLoc   := GetShaderLocation(shader, "freqY");
    ampXLoc    := GetShaderLocation(shader, "ampX");
    ampYLoc    := GetShaderLocation(shader, "ampY");
    speedXLoc  := GetShaderLocation(shader, "speedX");
    speedYLoc  := GetShaderLocation(shader, "speedY");

    // Shader uniform values that can be updated at any time
    screenSize := float.[ cast(float) GetScreenWidth(), cast(float) GetScreenHeight() ];
    freqX  := 25.0;
    freqY  := 25.0;
    ampX   := 5.0;
    ampY   := 5.0;
    speedX := 8.0;
    speedY := 8.0;

    SetShaderValue(shader, screenLoc , *screenSize, xx ShaderUniformDataType.VEC2);
    SetShaderValue(shader, freqXLoc  , *freqX     , xx ShaderUniformDataType.FLOAT);
    SetShaderValue(shader, freqYLoc  , *freqY     , xx ShaderUniformDataType.FLOAT);
    SetShaderValue(shader, ampXLoc   , *ampX      , xx ShaderUniformDataType.FLOAT);
    SetShaderValue(shader, ampYLoc   , *ampY      , xx ShaderUniformDataType.FLOAT);
    SetShaderValue(shader, speedXLoc , *speedX    , xx ShaderUniformDataType.FLOAT);
    SetShaderValue(shader, speedYLoc , *speedY    , xx ShaderUniformDataType.FLOAT);

    seconds := 0.0;

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    // -------------------------------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        seconds += GetFrameTime();

        SetShaderValue(shader, secondsLoc, *seconds, xx ShaderUniformDataType.FLOAT);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginShaderMode(shader);

                DrawTexture(texture, 0, 0, WHITE);
                DrawTexture(texture, texture.width, 0, WHITE);

            EndShaderMode();

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);         // Unload shader
    UnloadTexture(texture);       // Unload texture

    CloseWindow();

}
