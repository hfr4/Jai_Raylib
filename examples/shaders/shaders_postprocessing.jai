/* ******************************************************************************************
*
*   raylib [shaders] example - Apply a postprocessing shader to a scene
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

MAX_POSTPRO_SHADERS :: 12;

PostproShader :: enum {
    FX_GRAYSCALE;
    FX_POSTERIZATION;
    FX_DREAM_VISION;
    FX_PIXELIZER;
    FX_CROSS_HATCHING;
    FX_CROSS_STITCHING;
    FX_PREDATOR_VIEW;
    FX_SCANLINES;
    FX_FISHEYE;
    FX_SOBEL;
    FX_BLOOM;
    FX_BLUR;
    //FX_FXAA
}

postproShaderText :: string.[
    "GRAYSCALE",
    "POSTERIZATION",
    "DREAM_VISION",
    "PIXELIZER",
    "CROSS_HATCHING",
    "CROSS_STITCHING",
    "PREDATOR_VIEW",
    "SCANLINES",
    "FISHEYE",
    "SOBEL",
    "BLOOM",
    "BLUR",
    //"FXAA"
];


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);      // Enable Multi Sampling Anti Aliasing 4x (if available)

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - postprocessing shader");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 2.0, 3.0, 2.0 };              // Camera position
    camera.target     = .{ 0.0, 1.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    model   := LoadModel("resources/models/church.obj");                 // Load OBJ model
    texture := LoadTexture("resources/models/church_diffuse.png"); // Load model texture (diffuse map)
    model.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;        // Set model diffuse texture

    position: Vector3;            // Set model position

    // Load all postpro shaders
    // NOTE 1: All postpro shader use the base vertex shader (DEFAULT_VERTEX_SHADER)
    // NOTE 2: We load the correct shader depending on GLSL version
    shaders: [MAX_POSTPRO_SHADERS] Shader;

    // NOTE: Defining 0 (null) for vertex shader forces usage of internal default vertex shader
    shaders[xx PostproShader.FX_GRAYSCALE]       = LoadShader(null, TextFormat("resources/shaders/glsl%/grayscale.fs"      , GLSL_VERSION));
    shaders[xx PostproShader.FX_POSTERIZATION]   = LoadShader(null, TextFormat("resources/shaders/glsl%/posterization.fs"  , GLSL_VERSION));
    shaders[xx PostproShader.FX_DREAM_VISION]    = LoadShader(null, TextFormat("resources/shaders/glsl%/dream_vision.fs"   , GLSL_VERSION));
    shaders[xx PostproShader.FX_PIXELIZER]       = LoadShader(null, TextFormat("resources/shaders/glsl%/pixelizer.fs"      , GLSL_VERSION));
    shaders[xx PostproShader.FX_CROSS_HATCHING]  = LoadShader(null, TextFormat("resources/shaders/glsl%/cross_hatching.fs" , GLSL_VERSION));
    shaders[xx PostproShader.FX_CROSS_STITCHING] = LoadShader(null, TextFormat("resources/shaders/glsl%/cross_stitching.fs", GLSL_VERSION));
    shaders[xx PostproShader.FX_PREDATOR_VIEW]   = LoadShader(null, TextFormat("resources/shaders/glsl%/predator.fs"       , GLSL_VERSION));
    shaders[xx PostproShader.FX_SCANLINES]       = LoadShader(null, TextFormat("resources/shaders/glsl%/scanlines.fs"      , GLSL_VERSION));
    shaders[xx PostproShader.FX_FISHEYE]         = LoadShader(null, TextFormat("resources/shaders/glsl%/fisheye.fs"        , GLSL_VERSION));
    shaders[xx PostproShader.FX_SOBEL]           = LoadShader(null, TextFormat("resources/shaders/glsl%/sobel.fs"          , GLSL_VERSION));
    shaders[xx PostproShader.FX_BLOOM]           = LoadShader(null, TextFormat("resources/shaders/glsl%/bloom.fs"          , GLSL_VERSION));
    shaders[xx PostproShader.FX_BLUR]            = LoadShader(null, TextFormat("resources/shaders/glsl%/blur.fs"           , GLSL_VERSION));

    currentShader : int = xx PostproShader.FX_GRAYSCALE;

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

        if      (IsKeyPressed(xx KeyboardKey.RIGHT)) currentShader += 1;
        else if (IsKeyPressed(xx KeyboardKey.LEFT))  currentShader -= 1;

        if      (currentShader >= MAX_POSTPRO_SHADERS) currentShader = 0;
        else if (currentShader < 0)                    currentShader = MAX_POSTPRO_SHADERS - 1;
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginTextureMode(target);       // Enable drawing to texture
            ClearBackground(RAYWHITE);  // Clear texture background

            BeginMode3D(camera);        // Begin 3d mode drawing
                DrawModel(model, position, 0.1, WHITE);   // Draw 3d model with texture
                DrawGrid(10, 1.0);     // Draw a grid
            EndMode3D();                // End 3d mode drawing, returns to orthographic 2d mode
        EndTextureMode();               // End drawing to texture (now we have a texture available for next passes)

        BeginDrawing();
            ClearBackground(RAYWHITE);  // Clear screen background

            // Render generated texture using selected postprocessing shader
            BeginShaderMode(shaders[currentShader]);
                // NOTE: Render texture must be y-flipped due to default OpenGL coordinates (left-bottom)
                DrawTextureRec(target.texture, .{ 0, 0, cast(float)target.texture.width, cast(float)-target.texture.height }, .{ 0, 0 }, WHITE);
            EndShaderMode();

            // Draw 2d shapes and text over drawn texture
            DrawRectangle(0, 9, 580, 30, Fade(LIGHTGRAY, 0.7));

            DrawText("(c) Church 3D model by Alberto Cano", SCREEN_WIDTH - 200, SCREEN_HEIGHT - 20, 10, GRAY);
            DrawText("CURRENT POSTPRO SHADER:", 10, 15, 20, BLACK);
            DrawText(postproShaderText[currentShader].data, 330, 15, 20, RED);
            DrawText("< >", 540, 10, 30, DARKBLUE);
            DrawFPS(700, 15);
        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    // Unload all postpro shaders
    for i: 0..MAX_POSTPRO_SHADERS - 1 UnloadShader(shaders[i]);

    UnloadTexture(texture);         // Unload texture
    UnloadModel(model);             // Unload model
    UnloadRenderTexture(target);    // Unload render texture

    CloseWindow();                  // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
