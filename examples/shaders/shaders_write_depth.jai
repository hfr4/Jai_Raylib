/* ******************************************************************************************
*
*   raylib [shaders] example - Depth buffer writing
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
*
*   Example contributed by Buğra Alptekin Sarı (@BugraAlptekinSari) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022-2023 Buğra Alptekin Sarı (@BugraAlptekinSari)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - write depth buffer");

    // The shader inverts the depth buffer by writing into it by `gl_FragDepth = 1 - gl_FragCoord.z;`
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/write_depth.fs", GLSL_VERSION));

    // Use Customized function to create writable depth texture buffer
    target := LoadRenderTextureDepthTex(SCREEN_WIDTH, SCREEN_HEIGHT);

    // Define the camera to look into our 3d world
    camera := Camera.{
        position   = .{ 2.0, 2.0, 3.0 },              // Camera position
        target     = .{ 0.0, 0.5, 0.0 },              // Camera looking at point
        up         = .{ 0.0, 1.0, 0.0 },              // Camera up vector (rotation towards target)
        fovy       = 45.0,                            // Camera field-of-view Y
        projection = xx CameraProjection.PERSPECTIVE, // Camera projection type
    };

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.ORBITAL);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------

        // Draw into our custom render texture (framebuffer)
        BeginTextureMode(target);
            ClearBackground(WHITE);

            BeginMode3D(camera);
                BeginShaderMode(shader);
                    DrawCubeWiresV(.{ 0.0, 0.5, 1.0 }, .{ 1.0, 1.0, 1.0 }, RED);
                    DrawCubeV(.{ 0.0, 0.5, 1.0 }, .{ 1.0, 1.0, 1.0 }, PURPLE);
                    DrawCubeWiresV(.{ 0.0, 0.5, -1.0 }, .{ 1.0, 1.0, 1.0 }, DARKGREEN);
                    DrawCubeV(.{ 0.0, 0.5, -1.0 }, .{ 1.0, 1.0, 1.0 }, YELLOW);
                    DrawGrid(10, 1.0);
                EndShaderMode();
            EndMode3D();
        EndTextureMode();

        // Draw into screen our custom render texture
        BeginDrawing();
            ClearBackground(RAYWHITE);

            DrawTextureRec(target.texture, .{ 0, 0, cast(float)SCREEN_WIDTH, cast(float)-SCREEN_HEIGHT }, .{ 0, 0 }, WHITE);
            DrawFPS(10, 10);
        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadRenderTextureDepthTex(*target);
    UnloadShader(shader);

    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

//------------------------------------------------------------------------------------
// Define custom functions required for the example
//------------------------------------------------------------------------------------
// Load custom render texture, create a writable depth texture buffer
LoadRenderTextureDepthTex :: (width: s32, height: s32) -> RenderTexture2D
{
    target: RenderTexture2D;

    target.id = rlLoadFramebuffer(width, height);   // Load an empty framebuffer

    if (target.id > 0)
    {
        rlEnableFramebuffer(target.id);

        // Create color texture (default to RGBA)
        target.texture.id      = rlLoadTexture(null, width, height, xx PixelFormat.UNCOMPRESSED_R8G8B8A8, 1);
        target.texture.width   = width;
        target.texture.height  = height;
        target.texture.format  = xx PixelFormat.UNCOMPRESSED_R8G8B8A8;
        target.texture.mipmaps = 1;

        // Create depth texture buffer (instead of raylib default renderbuffer)
        target.depth.id      = rlLoadTextureDepth(width, height, false);
        target.depth.width   = width;
        target.depth.height  = height;
        target.depth.format  = 19;       //DEPTH_COMPONENT_24BIT?
        target.depth.mipmaps = 1;

        // Attach color texture and depth texture to FBO
        rlFramebufferAttach(target.id, target.texture.id, xx rlFramebufferAttachType.COLOR_CHANNEL0, xx rlFramebufferAttachTextureType.TEXTURE2D, 0);
        rlFramebufferAttach(target.id, target.depth.id  , xx rlFramebufferAttachType.DEPTH         , xx rlFramebufferAttachTextureType.TEXTURE2D, 0);

        // Check if fbo is complete with attachments (valid)
        if (rlFramebufferComplete(target.id)) TraceLog(xx TraceLogLevel.INFO, "FBO: [ID %] Framebuffer object created successfully", target.id);

        rlDisableFramebuffer();
    }
    else TraceLog(xx TraceLogLevel.WARNING, "FBO: Framebuffer object can not be created");

    return target;
}


UnloadRenderTextureDepthTex :: (target: *RenderTexture2D)
{
    if (target.id > 0)
    {
        // Color texture attached to FBO is deleted
        rlUnloadTexture(target.texture.id);
        rlUnloadTexture(target.depth.id);

        // NOTE: Depth texture is automatically
        // queried and deleted before deleting framebuffer
        rlUnloadFramebuffer(target.id);
    }
}