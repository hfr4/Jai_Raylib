/* ******************************************************************************************
*
*   raylib [shaders] example - Hybrid Rendering
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

Math :: #import "Math";

GLSL_VERSION :: 330;

RayLocs :: struct {
    camPos: s32;
    camDir: s32;
    screenCenter: s32;
}


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - write depth buffer");

    // This Shader calculates pixel depth and color using raymarch
    shdrRaymarch := LoadShader(null, TextFormat("resources/shaders/glsl%/hybrid_raymarch.fs", GLSL_VERSION));

    // This Shader is a standard rasterization fragment shader with the addition of depth writing
    // You are required to write depth for all shaders if one shader does it
    shdrRaster := LoadShader(null, TextFormat("resources/shaders/glsl%/hybrid_raster.fs", GLSL_VERSION));

    // Declare Struct used to store camera locs.
    marchLocs: RayLocs;

    // Fill the struct with shader locs.
    marchLocs.camPos       = GetShaderLocation(shdrRaymarch, "camPos");
    marchLocs.camDir       = GetShaderLocation(shdrRaymarch, "camDir");
    marchLocs.screenCenter = GetShaderLocation(shdrRaymarch, "screenCenter");

    // Transfer screenCenter position to shader. Which is used to calculate ray direction.
    screenCenter := Vector2.{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0};
    SetShaderValue(shdrRaymarch, marchLocs.screenCenter, *screenCenter , xx ShaderUniformDataType.VEC2);

    // Use Customized function to create writable depth texture buffer
    target := LoadRenderTextureDepthTex(SCREEN_WIDTH, SCREEN_HEIGHT);

    // Define the camera to look into our 3d world
    camera := Camera .{
        position   = .{ 0.5, 1.0, 1.5 },              // Camera position
        target     = .{ 0.0, 0.5, 0.0 },              // Camera looking at point
        up         = .{ 0.0, 1.0, 0.0 },              // Camera up vector (rotation towards target)
        fovy       = 45.0,                            // Camera field-of-view Y
        projection = xx CameraProjection.PERSPECTIVE, // Camera projection type
    };

    // Camera FOV is pre-calculated in the camera Distance.
    camDist := cast(float) (1.0 / (Math.tan(camera.fovy * 0.5 * DEG2RAD)));

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.ORBITAL);

        // Update Camera Postion in the ray march shader.
        SetShaderValue(shdrRaymarch, marchLocs.camPos, *camera.position, xx ShaderUniformDataType.VEC3);

        // Update Camera Looking Vector. Vector length determines FOV.
        camDir := Vector3Scale( Vector3Normalize( Vector3Subtract(camera.target, camera.position)) , camDist);
        SetShaderValue(shdrRaymarch, marchLocs.camDir, *camDir, xx ShaderUniformDataType.VEC3);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        // Draw into our custom render texture (framebuffer)
        BeginTextureMode(target);
            ClearBackground(WHITE);

            // Raymarch Scene
            rlEnableDepthTest(); //Manually enable Depth Test to handle multiple rendering methods.
            BeginShaderMode(shdrRaymarch);
                DrawRectangleRec(.{0,0, cast(float)SCREEN_WIDTH, cast(float)SCREEN_HEIGHT},WHITE);
            EndShaderMode();

            // Raserize Scene
            BeginMode3D(camera);
                BeginShaderMode(shdrRaster);
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
    UnloadShader(shdrRaymarch);
    UnloadShader(shdrRaster);

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