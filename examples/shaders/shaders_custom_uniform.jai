/* ******************************************************************************************
*
*   raylib [shaders] example - Postprocessing with custom uniform variable
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3), to test this example
*         on OpenGL ES 2.0 platforms (Android, Raspberry Pi, HTML5), use #version 100 shaders
*         raylib comes with shaders ready for both versions, check raylib/shaders install folder
*
*   Example originally created with raylib 1.3, last time updated with raylib 4.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);      // Enable Multi Sampling Anti Aliasing 4x (if available)

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - custom uniform variable");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 8.0, 8.0, 8.0 };              // Camera position
    camera.target     = .{ 0.0, 1.5, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    model   := LoadModel("resources/models/barracks.obj");           // Load OBJ model
    texture := LoadTexture("resources/models/barracks_diffuse.png"); // Load model texture (diffuse map)
    model.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture; // Set model diffuse texture

    position := Vector3.{ 0.0, 0.0, 0.0 }; // Set model position

    // Load postprocessing shader
    // NOTE: Defining 0 (null) for vertex shader forces usage of internal default vertex shader
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/swirl.fs", GLSL_VERSION));

    // Get variable (uniform) location on the shader to connect with the program
    // NOTE: If uniform variable could not be found in the shader, function returns -1
    swirlCenterLoc := GetShaderLocation(shader, "center");

    swirlCenter := float.[ cast(float) SCREEN_WIDTH/2.0, cast(float) SCREEN_HEIGHT/2.0 ];

    // Create a RenderTexture2D to be used for render to texture
    target := LoadRenderTexture(SCREEN_WIDTH, SCREEN_HEIGHT);

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.ORBITAL);

        mousePosition := GetMousePosition();

        swirlCenter[0] = mousePosition.x;
        swirlCenter[1] = SCREEN_HEIGHT - mousePosition.y;

        // Send new value to the shader to be used on drawing
        SetShaderValue(shader, swirlCenterLoc, *swirlCenter, xx ShaderUniformDataType.VEC2);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginTextureMode(target);       // Enable drawing to texture
            ClearBackground(RAYWHITE);  // Clear texture background

            BeginMode3D(camera);        // Begin 3d mode drawing
                DrawModel(model, position, 0.5, WHITE);   // Draw 3d model with texture
                DrawGrid(10, 1.0);     // Draw a grid
            EndMode3D();                // End 3d mode drawing, returns to orthographic 2d mode

            DrawText("TEXT DRAWN IN RENDER TEXTURE", 200, 10, 30, RED);
        EndTextureMode();               // End drawing to texture (now we have a texture available for next passes)

        BeginDrawing();
            ClearBackground(RAYWHITE);  // Clear screen background

            // Enable shader using the custom uniform
            BeginShaderMode(shader);
                // NOTE: Render texture must be y-flipped due to default OpenGL coordinates (left-bottom)
                DrawTextureRec(target.texture, .{ 0, 0, cast(float) target.texture.width, cast(float) -target.texture.height }, .{ 0, 0 }, WHITE);
            EndShaderMode();

            // Draw some 2d text over drawn texture
            DrawText("(c) Barracks 3D model by Alberto Cano", SCREEN_WIDTH - 220, SCREEN_HEIGHT - 20, 10, GRAY);
            DrawFPS(10, 10);
        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);               // Unload shader
    UnloadTexture(texture);             // Unload texture
    UnloadModel(model);                 // Unload model
    UnloadRenderTexture(target);        // Unload render texture

    CloseWindow();                      // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}