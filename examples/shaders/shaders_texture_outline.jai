/* ******************************************************************************************
*
*   raylib [shaders] example - Apply an shdrOutline to a texture
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   Example originally created with raylib 4.0, last time updated with raylib 4.0
*
*   Example contributed by Samuel Skiff (@GoldenThumbs) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2021-2023 Samuel SKiff (@GoldenThumbs) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - Apply an outline to a texture");

    texture := LoadTexture("resources/fudesumi.png");

    shdrOutline := LoadShader(null, TextFormat("resources/shaders/glsl%/outline.fs", GLSL_VERSION));

    outlineSize := 2.0;
    outlineColor : [4] float = .[ 1.0, 0.0, 0.0, 1.0 ];     // Normalized RED color
    textureSize  : [2] float = .[ cast(float)texture.width, cast(float)texture.height ];

    // Get shader locations
    outlineSizeLoc  := GetShaderLocation(shdrOutline, "outlineSize");
    outlineColorLoc := GetShaderLocation(shdrOutline, "outlineColor");
    textureSizeLoc  := GetShaderLocation(shdrOutline, "textureSize");

    // Set shader values (they can be changed later)
    SetShaderValue(shdrOutline, outlineSizeLoc , *outlineSize , xx ShaderUniformDataType.FLOAT);
    SetShaderValue(shdrOutline, outlineColorLoc, *outlineColor, xx ShaderUniformDataType.VEC4);
    SetShaderValue(shdrOutline, textureSizeLoc , *textureSize , xx ShaderUniformDataType.VEC2);

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        outlineSize += GetMouseWheelMove();
        if (outlineSize < 1.0) outlineSize = 1.0;

        SetShaderValue(shdrOutline, outlineSizeLoc, *outlineSize, xx ShaderUniformDataType.FLOAT);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginShaderMode(shdrOutline);

                DrawTexture(texture, GetScreenWidth()/2 - texture.width/2, -30, WHITE);

            EndShaderMode();

            DrawText("Shader-based\ntexture\noutline", 10, 10, 20, GRAY);
            DrawText("Scroll mouse wheel to\nchange outline size", 10, 72, 20, GRAY);
            DrawText(TextFormat("Outline size: % px", cast(s32) outlineSize), 10, 120, 20, MAROON);

            DrawFPS(710, 10);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadTexture(texture);
    UnloadShader(shdrOutline);

    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------


}
