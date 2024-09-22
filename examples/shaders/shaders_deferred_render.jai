/* ******************************************************************************************
*
*   raylib [shaders] example - deferred rendering
*
*   NOTE: This example requires raylib OpenGL 3.3 or OpenGL ES 3.0
*
*   Example originally created with raylib 4.5, last time updated with raylib 4.5
*
*   Example contributed by Justin Andreas Lacoste (@27justin) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 Justin Andreas Lacoste (@27justin)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

#load "rlights.jai";

GLSL_VERSION :: 330;


MAX_CUBES :: 30;

GBuffer :: struct  {
    framebuffer:       u32;
    positionTexture:   u32;
    normalTexture:     u32;
    albedoSpecTexture: u32;
    depthRenderbuffer: u32;
}

DeferredMode :: enum {
   POSITION;
   NORMAL;
   ALBEDO;
   SHADING;
}


main :: () {
    // Initialization
    // -------------------------------------------------------------------------------------
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - deferred render");

    camera: Camera;
    camera.position   = .{ 5.0, 4.0, 5.0 };              // Camera position
    camera.target     = .{ 0.0, 1.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 60.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Load plane model from a generated mesh
    model := LoadModelFromMesh(GenMeshPlane(10.0, 10.0, 3, 3));
    cube := LoadModelFromMesh(GenMeshCube(2.0, 2.0, 2.0));

    // Load geometry buffer (G-buffer) shader and deferred shader
    gbufferShader := LoadShader("resources/shaders/glsl330/gbuffer.vs",
                               "resources/shaders/glsl330/gbuffer.fs");

    deferredShader := LoadShader("resources/shaders/glsl330/deferred_shading.vs",
                               "resources/shaders/glsl330/deferred_shading.fs");
    deferredShader.locs[xx ShaderLocationIndex.VECTOR_VIEW] = GetShaderLocation(deferredShader, "viewPosition");

    // Initialize the G-buffer
    gBuffer: GBuffer;
    gBuffer.framebuffer = rlLoadFramebuffer(SCREEN_WIDTH, SCREEN_HEIGHT);

    if (!gBuffer.framebuffer)
    {
        TraceLog(xx TraceLogLevel.WARNING, "Failed to create framebuffer");
        assert(false);
    }

    rlEnableFramebuffer(gBuffer.framebuffer);

    // Since we are storing position and normal data in these textures,
    // we need to use a floating point format.
    gBuffer.positionTexture = rlLoadTexture(null, SCREEN_WIDTH, SCREEN_HEIGHT, xx PixelFormat.UNCOMPRESSED_R32G32B32, 1);

    gBuffer.normalTexture = rlLoadTexture(null, SCREEN_WIDTH, SCREEN_HEIGHT, xx PixelFormat.UNCOMPRESSED_R32G32B32, 1);
    // Albedo (diffuse color) and specular strength can be combined into one texture.
    // The color in RGB, and the specular strength in the alpha channel.
    gBuffer.albedoSpecTexture = rlLoadTexture(null, SCREEN_WIDTH, SCREEN_HEIGHT, xx PixelFormat.UNCOMPRESSED_R8G8B8A8, 1);

    // Activate the draw buffers for our framebuffer
    rlActiveDrawBuffers(3);

    // Now we attach our textures to the framebuffer.
    rlFramebufferAttach(gBuffer.framebuffer, gBuffer.positionTexture  , xx rlFramebufferAttachType.COLOR_CHANNEL0, xx rlFramebufferAttachTextureType.TEXTURE2D, 0);
    rlFramebufferAttach(gBuffer.framebuffer, gBuffer.normalTexture    , xx rlFramebufferAttachType.COLOR_CHANNEL1, xx rlFramebufferAttachTextureType.TEXTURE2D, 0);
    rlFramebufferAttach(gBuffer.framebuffer, gBuffer.albedoSpecTexture, xx rlFramebufferAttachType.COLOR_CHANNEL2, xx rlFramebufferAttachTextureType.TEXTURE2D, 0);

    // Finally we attach the depth buffer.
    gBuffer.depthRenderbuffer = rlLoadTextureDepth(SCREEN_WIDTH, SCREEN_HEIGHT, true);
    rlFramebufferAttach(gBuffer.framebuffer, gBuffer.depthRenderbuffer, xx rlFramebufferAttachType.DEPTH, xx rlFramebufferAttachTextureType.RENDERBUFFER, 0);

    // Make sure our framebuffer is complete.
    // NOTE: rlFramebufferComplete() automatically unbinds the framebuffer, so we don't have
    // to rlDisableFramebuffer() here.
    if (!rlFramebufferComplete(gBuffer.framebuffer))
    {
        TraceLog(xx TraceLogLevel.WARNING, "Framebuffer is not complete");
        assert(false);
    }

    // Now we initialize the sampler2D uniform's in the deferred shader.
    // We do this by setting the uniform's value to the color channel slot we earlier
    // bound our textures to.
    rlEnableShader(deferredShader.id);

        rlSetUniformSampler(rlGetLocationUniform(deferredShader.id, "gPosition")  , 0);
        rlSetUniformSampler(rlGetLocationUniform(deferredShader.id, "gNormal")    , 1);
        rlSetUniformSampler(rlGetLocationUniform(deferredShader.id, "gAlbedoSpec"), 2);

    rlDisableShader();

    // Assign out lighting shader to model
    model.materials[0].shader = gbufferShader;
    cube.materials[0].shader  = gbufferShader;

    // Create lights
    //--------------------------------------------------------------------------------------
    lights: [MAX_LIGHTS] Light;
    lights[0] = CreateLight(.POINT, .{ -2, 1, -2 }, Vector3Zero(), YELLOW, *deferredShader);
    lights[1] = CreateLight(.POINT, .{  2, 1,  2 }, Vector3Zero(), RED   , *deferredShader);
    lights[2] = CreateLight(.POINT, .{ -2, 1,  2 }, Vector3Zero(), GREEN , *deferredShader);
    lights[3] = CreateLight(.POINT, .{  2, 1, -2 }, Vector3Zero(), BLUE  , *deferredShader);

    CUBE_SCALE :: 0.25;
    cubePositions: [MAX_CUBES] Vector3;
    cubeRotations: [MAX_CUBES] float ;

    for i: 0..MAX_CUBES - 1
    {
        cubePositions[i] = .{
            x = cast(float) (GetRandomValue(1, 1000) % 10) / 100.0 - 5,
            y = cast(float) (GetRandomValue(1, 1000) % 5)  / 100.0    ,
            z = cast(float) (GetRandomValue(1, 1000) % 10) / 100.0 - 5,
        };

        cubeRotations[i] = cast(float) (GetRandomValue(1, 1000) % 360);
    }

     mode: DeferredMode = .SHADING;

    rlEnableDepthTest();

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //---------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.ORBITAL);

        // Update the shader with the camera view vector (points towards { 0.0, 0.0, 0.0 })
        cameraPos := float.[ camera.position.x, camera.position.y, camera.position.z ];
        SetShaderValue(deferredShader, deferredShader.locs[xx ShaderLocationIndex.VECTOR_VIEW], *cameraPos, xx ShaderUniformDataType.VEC3);

        // Check key inputs to enable/disable lights
        if (IsKeyPressed(xx KeyboardKey.Y)) { lights[0].enabled = !lights[0].enabled; }
        if (IsKeyPressed(xx KeyboardKey.R)) { lights[1].enabled = !lights[1].enabled; }
        if (IsKeyPressed(xx KeyboardKey.G)) { lights[2].enabled = !lights[2].enabled; }
        if (IsKeyPressed(xx KeyboardKey.B)) { lights[3].enabled = !lights[3].enabled; }

        // Check key inputs to switch between G-buffer textures
        if (IsKeyPressed(xx KeyboardKey.ONE))   mode = .POSITION;
        if (IsKeyPressed(xx KeyboardKey.TWO))   mode = .NORMAL;
        if (IsKeyPressed(xx KeyboardKey.THREE)) mode = .ALBEDO;
        if (IsKeyPressed(xx KeyboardKey.FOUR))  mode = .SHADING;

        // Update light values (actually, only enable/disable them)
        for i: 0..MAX_LIGHTS - 1 UpdateLightValues(*deferredShader, lights[i]);
        //----------------------------------------------------------------------------------

        // Draw
        // ---------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            // Draw to the geometry buffer by first activating it
            rlEnableFramebuffer(gBuffer.framebuffer);
            rlClearScreenBuffers();  // Clear color and depth buffer

            rlDisableColorBlend();
            BeginMode3D(camera);
                // NOTE: We have to use rlEnableShader here. `BeginShaderMode` or thus `rlSetShader`
                // will not work, as they won't immediately load the shader program.
                rlEnableShader(gbufferShader.id);
                    // When drawing a model here, make sure that the material's shaders
                    // are set to the gbuffer shader!
                    DrawModel(model, Vector3Zero()    , 1.0, WHITE);
                    DrawModel(cube, .{ 0.0, 1.0, 0.0 }, 1.0, WHITE);

                    for i: 0..MAX_CUBES - 1
                    {
                        position := cubePositions[i];
                        DrawModelEx(cube, position, .{ 1, 1, 1 }, cubeRotations[i], .{ CUBE_SCALE, CUBE_SCALE, CUBE_SCALE }, WHITE);
                    }

                rlDisableShader();
            EndMode3D();
            rlEnableColorBlend();

            // Go back to the default framebuffer (0) and draw our deferred shading.
            rlDisableFramebuffer();
            rlClearScreenBuffers(); // Clear color & depth buffer

            if mode ==
            {
                case .SHADING;
                {
                    BeginMode3D(camera);
                        rlDisableColorBlend();
                        rlEnableShader(deferredShader.id);
                            // Activate our g-buffer textures
                            // These will now be bound to the sampler2D uniforms `gPosition`, `gNormal`,
                            // and `gAlbedoSpec`
                            rlActiveTextureSlot(0);
                            rlEnableTexture(gBuffer.positionTexture);
                            rlActiveTextureSlot(1);
                            rlEnableTexture(gBuffer.normalTexture);
                            rlActiveTextureSlot(2);
                            rlEnableTexture(gBuffer.albedoSpecTexture);

                            // Finally, we draw a fullscreen quad to our default framebuffer
                            // This will now be shaded using our deferred shader
                            rlLoadDrawQuad();
                        rlDisableShader();
                        rlEnableColorBlend();
                    EndMode3D();

                    // As a last step, we now copy over the depth buffer from our g-buffer to the default framebuffer.
                    rlEnableFramebuffer(gBuffer.framebuffer); //glBindFramebuffer(GL_READ_FRAMEBUFFER, gBuffer.framebuffer);
                    rlEnableFramebuffer(0); //glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);
                    rlBlitFramebuffer(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, 0x00000100);    // GL_DEPTH_BUFFER_BIT
                    rlDisableFramebuffer();

                    // Since our shader is now done and disabled, we can draw our lights in default
                    // forward rendering
                    BeginMode3D(camera);
                        rlEnableShader(rlGetShaderIdDefault());
                            for i: 0..MAX_LIGHTS - 1
                            {
                                if (lights[i].enabled) DrawSphereEx(lights[i].position, 0.2, 8, 8, lights[i].color);
                                else                   DrawSphereWires(lights[i].position, 0.2, 8, 8, ColorAlpha(lights[i].color, 0.3));
                            }
                        rlDisableShader();
                    EndMode3D();
                    DrawText("FINAL RESULT", 10, SCREEN_HEIGHT - 30, 20, DARKGREEN);
                }

                case .POSITION;
                {
                    DrawTextureRec(.{
                        id     = gBuffer.positionTexture,
                        width  = SCREEN_WIDTH,
                        height = SCREEN_HEIGHT,
                    }, .{ 0, 0, SCREEN_WIDTH, -SCREEN_HEIGHT }, Vector2Zero(), RAYWHITE);
                    DrawText("POSITION TEXTURE", 10, SCREEN_HEIGHT - 30, 20, DARKGREEN);
                }

                case .NORMAL;
                {
                    DrawTextureRec(.{
                        id     = gBuffer.normalTexture,
                        width  = SCREEN_WIDTH,
                        height = SCREEN_HEIGHT,
                    }, .{ 0, 0, SCREEN_WIDTH, -SCREEN_HEIGHT }, Vector2Zero(), RAYWHITE);
                    DrawText("NORMAL TEXTURE", 10, SCREEN_HEIGHT - 30, 20, DARKGREEN);
                }

                case .ALBEDO;
                {
                    DrawTextureRec(.{
                        id     = gBuffer.albedoSpecTexture,
                        width  = SCREEN_WIDTH,
                        height = SCREEN_HEIGHT,
                    }, .{ 0, 0, SCREEN_WIDTH, -SCREEN_HEIGHT }, Vector2Zero(), RAYWHITE);
                    DrawText("ALBEDO TEXTURE", 10, SCREEN_HEIGHT - 30, 20, DARKGREEN);
                }
            }

            DrawText("Toggle lights keys: [Y][R][G][B]", 10, 40, 20, DARKGRAY);
            DrawText("Switch G-buffer textures: [1][2][3][4]", 10, 70, 20, DARKGRAY);

            DrawFPS(10, 10);

        EndDrawing();
        // -----------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadModel(model);     // Unload the models
    UnloadModel(cube);

    UnloadShader(deferredShader);   // Unload shaders
    UnloadShader(gbufferShader);

    // Unload geometry buffer and all attached textures
    rlUnloadFramebuffer(gBuffer.framebuffer);
    rlUnloadTexture(gBuffer.positionTexture);
    rlUnloadTexture(gBuffer.normalTexture);
    rlUnloadTexture(gBuffer.albedoSpecTexture);
    rlUnloadTexture(gBuffer.depthRenderbuffer);

    CloseWindow();          // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

