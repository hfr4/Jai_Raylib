/* ******************************************************************************************
*
*   raylib [shaders] example - Multiple sample2D with default batch system
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3), to test this example
*         on OpenGL ES 2.0 platforms (Android, Raspberry Pi, HTML5), use #version 100 shaders
*         raylib comes with shaders ready for both versions, check raylib/shaders install folder
*
*   Example originally created with raylib 3.5, last time updated with raylib 3.5
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib - multiple sample2D");

    imRed := GenImageColor(800, 450, .{ 255, 0, 0, 255 });
    texRed := LoadTextureFromImage(imRed);
    UnloadImage(imRed);

    imBlue := GenImageColor(800, 450, .{ 0, 0, 255, 255 });
    texBlue := LoadTextureFromImage(imBlue);
    UnloadImage(imBlue);

    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/color_mix.fs", GLSL_VERSION));

    // Get an additional sampler2D location to be enabled on drawing
    texBlueLoc := GetShaderLocation(shader, "texture1");

    // Get shader uniform for divider
    dividerLoc := GetShaderLocation(shader, "divider");
    dividerValue := 0.5;

    SetTargetFPS(60);                           // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())                // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        if      (IsKeyDown(xx KeyboardKey.RIGHT)) dividerValue += 0.01;
        else if (IsKeyDown(xx KeyboardKey.LEFT))  dividerValue -= 0.01;

        if      (dividerValue < 0.0) dividerValue = 0.0;
        else if (dividerValue > 1.0) dividerValue = 1.0;

        SetShaderValue(shader, dividerLoc, *dividerValue, xx ShaderUniformDataType.FLOAT);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginShaderMode(shader);

                // WARNING: Additional samplers are enabled for all draw calls in the batch,
                // EndShaderMode() forces batch drawing and consequently resets active textures
                // to let other sampler2D to be activated on consequent drawings (if required)
                SetShaderValueTexture(shader, texBlueLoc, texBlue);

                // We are drawing texRed using default sampler2D texture0 but
                // an additional texture units is enabled for texBlue (sampler2D texture1)
                DrawTexture(texRed, 0, 0, WHITE);

            EndShaderMode();

            DrawText("Use KEY_LEFT/KEY_RIGHT to move texture mixing in shader!", 80, GetScreenHeight() - 40, 20, RAYWHITE);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);
    UnloadTexture(texRed);
    UnloadTexture(texBlue);

    CloseWindow();

}