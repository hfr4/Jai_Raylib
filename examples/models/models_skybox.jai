/* ******************************************************************************************
*
*   raylib [models] example - Skybox loading and drawing
*
*   Example originally created with raylib 1.8, last time updated with raylib 4.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - skybox loading and drawing");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 1.0, 1.0, 1.0 };              // Camera position
    camera.target     = .{ 4.0, 1.0, 4.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    // Load skybox model
    cube := GenMeshCube(1.0, 1.0, 1.0);
    skybox := LoadModelFromMesh(cube);

    useHDR := true;

    // Load skybox shader and set required locations
    // NOTE: Some locations are automatically set at shader loading
    skybox.materials[0].shader = LoadShader(TextFormat("resources/shaders/glsl%/skybox.vs", GLSL_VERSION),
                                            TextFormat("resources/shaders/glsl%/skybox.fs", GLSL_VERSION));

    environmentMap := xx MaterialMapIndex.CUBEMAP;
    doGamma : s32  = ifx useHDR then cast(s32)1 else cast(s32) 0;
    vflipped : s32 = ifx useHDR then cast(s32)1 else cast(s32) 0;

    SetShaderValue(skybox.materials[0].shader, GetShaderLocation(skybox.materials[0].shader, "environmentMap"), *environmentMap, xx ShaderUniformDataType.INT);
    SetShaderValue(skybox.materials[0].shader, GetShaderLocation(skybox.materials[0].shader, "doGamma")       , *doGamma       , xx ShaderUniformDataType.INT);
    SetShaderValue(skybox.materials[0].shader, GetShaderLocation(skybox.materials[0].shader, "vflipped")      , *vflipped      , xx ShaderUniformDataType.INT);

    // Load cubemap shader and setup required shader locations
    shdrCubemap := LoadShader(TextFormat("resources/shaders/glsl%/cubemap.vs", GLSL_VERSION),
                              TextFormat("resources/shaders/glsl%/cubemap.fs", GLSL_VERSION));

    equirectangularMap : s32 = 0;
    SetShaderValue(shdrCubemap, GetShaderLocation(shdrCubemap, "equirectangularMap"), *equirectangularMap, xx ShaderUniformDataType.INT);

    skyboxFileName: [256] u8;

    if (useHDR)
    {
        TextCopy(*skyboxFileName[0], "resources/dresden_square_2k.hdr");

        // Load HDR panorama (sphere) texture
        panorama := LoadTexture(*skyboxFileName[0]);

        // Generate cubemap (texture with 6 quads-cube-mapping) from panorama HDR texture
        // NOTE 1: New texture is generated rendering to texture, shader calculates the sphere->cube coordinates mapping
        // NOTE 2: It seems on some Android devices WebGL, fbo does not properly support a FLOAT-based attachment,
        // despite texture can be successfully created.. so using PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 instead of PIXELFORMAT_UNCOMPRESSED_R32G32B32A32
        skybox.materials[0].maps[xx MaterialMapIndex.CUBEMAP].texture = GenTextureCubemap(shdrCubemap, panorama, 1024, xx PixelFormat.UNCOMPRESSED_R8G8B8A8);

        UnloadTexture(panorama);        // Texture not required anymore, cubemap already generated
    }
    else
    {
        img := LoadImage("resources/skybox.png");
        skybox.materials[0].maps[xx MaterialMapIndex.CUBEMAP].texture = LoadTextureCubemap(img, xx CubemapLayout.AUTO_DETECT);    // CUBEMAP_LAYOUT_PANORAMA
        UnloadImage(img);
    }

    DisableCursor();                    // Limit cursor to relative movement inside the window

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);

        // Load new cubemap texture on drag&drop
        if (IsFileDropped())
        {
            droppedFiles := LoadDroppedFiles();

            if (droppedFiles.count == 1)         // Only support one file dropped
            {
                if (IsFileExtension(droppedFiles.paths[0], ".png;.jpg;.hdr;.bmp;.tga"))
                {

                    UnloadTexture(skybox.materials[0].maps[xx MaterialMapIndex.CUBEMAP].texture);

                    if (useHDR)
                    {
                        // Load HDR panorama (sphere) texture
                        panorama := LoadTexture(droppedFiles.paths[0]);

                        // Generate cubemap from panorama texture
                        skybox.materials[0].maps[xx MaterialMapIndex.CUBEMAP].texture = GenTextureCubemap(shdrCubemap, panorama, 1024, xx PixelFormat.UNCOMPRESSED_R8G8B8A8);

                        UnloadTexture(panorama);    // Texture not required anymore, cubemap already generated
                    }
                    else
                    {
                        img := LoadImage(droppedFiles.paths[0]);
                        skybox.materials[0].maps[xx MaterialMapIndex.CUBEMAP].texture = LoadTextureCubemap(img, xx CubemapLayout.AUTO_DETECT);
                        UnloadImage(img);
                    }

                    TextCopy(*skyboxFileName[0], droppedFiles.paths[0]);
                }
            }

            UnloadDroppedFiles(droppedFiles);
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                // We are inside the cube, we need to disable backface culling!
                rlDisableBackfaceCulling();
                rlDisableDepthMask();
                    DrawModel(skybox, .{0, 0, 0}, 1.0, WHITE);
                rlEnableBackfaceCulling();
                rlEnableDepthMask();

                DrawGrid(10, 1.0);

            EndMode3D();

            //DrawTextureEx(panorama, (Vector2){ 0, 0 }, 0.0f, 0.5f, WHITE);

            if (useHDR) DrawText(TextFormat("Panorama image from hdrihaven.com: %", GetFileName(*skyboxFileName[0])), 10, GetScreenHeight() - 20, 10, BLACK);
            else        DrawText(TextFormat(": %", GetFileName(*skyboxFileName[0])), 10, GetScreenHeight() - 20, 10, BLACK);

            DrawFPS(10, 10);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(skybox.materials[0].shader);
    UnloadTexture(skybox.materials[0].maps[xx MaterialMapIndex.CUBEMAP].texture);

    UnloadModel(skybox);

    CloseWindow();              // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}

// Generate cubemap texture from HDR texture
GenTextureCubemap :: (shader: Shader, panorama: Texture2D, size: s32, format: s32) -> TextureCubemap
{
    cubemap: TextureCubemap;

    rlDisableBackfaceCulling();     // Disable backface culling to render inside the cube

    // STEP 1: Setup framebuffer
    //------------------------------------------------------------------------------------------
    rbo := rlLoadTextureDepth(size, size, true);
    cubemap.id = rlLoadTextureCubemap(null, size, format);

    fbo := rlLoadFramebuffer(size, size);
    rlFramebufferAttach(fbo, rbo       , xx rlFramebufferAttachType.DEPTH         , xx rlFramebufferAttachTextureType.RENDERBUFFER      , 0);
    rlFramebufferAttach(fbo, cubemap.id, xx rlFramebufferAttachType.COLOR_CHANNEL0, xx rlFramebufferAttachTextureType.CUBEMAP_POSITIVE_X, 0);

    // Check if framebuffer is complete with attachments (valid)
    if (rlFramebufferComplete(fbo)) TraceLog(xx TraceLogLevel.INFO, "FBO: [ID %] Framebuffer object created successfully", fbo);
    //------------------------------------------------------------------------------------------

    // STEP 2: Draw to framebuffer
    //------------------------------------------------------------------------------------------
    // NOTE: Shader is used to convert HDR equirectangular environment map to cubemap equivalent (6 faces)
    rlEnableShader(shader.id);

    // Define projection matrix and send it to shader
    matFboProjection := MatrixPerspective(90.0*DEG2RAD, 1.0, RL_CULL_DISTANCE_NEAR, RL_CULL_DISTANCE_FAR);
    rlSetUniformMatrix(shader.locs[xx ShaderLocationIndex.MATRIX_PROJECTION], matFboProjection);

    // Define view matrix for every side of the cubemap
    fboViews : [6] Matrix = .[
        MatrixLookAt(.{ 0.0, 0.0, 0.0 }, .{  1.0,  0.0,  0.0 }, .{ 0.0, -1.0,  0.0 }),
        MatrixLookAt(.{ 0.0, 0.0, 0.0 }, .{ -1.0,  0.0,  0.0 }, .{ 0.0, -1.0,  0.0 }),
        MatrixLookAt(.{ 0.0, 0.0, 0.0 }, .{  0.0,  1.0,  0.0 }, .{ 0.0,  0.0,  1.0 }),
        MatrixLookAt(.{ 0.0, 0.0, 0.0 }, .{  0.0, -1.0,  0.0 }, .{ 0.0,  0.0, -1.0 }),
        MatrixLookAt(.{ 0.0, 0.0, 0.0 }, .{  0.0,  0.0,  1.0 }, .{ 0.0, -1.0,  0.0 }),
        MatrixLookAt(.{ 0.0, 0.0, 0.0 }, .{  0.0,  0.0, -1.0 }, .{ 0.0, -1.0,  0.0 })
    ];

    rlViewport(0, 0, size, size);   // Set viewport to current fbo dimensions

    // Activate and enable texture for drawing to cubemap faces
    rlActiveTextureSlot(0);
    rlEnableTexture(panorama.id);

    for i: 0..5
    {
        // Set the view matrix for the current cube face
        rlSetUniformMatrix(shader.locs[xx ShaderLocationIndex.MATRIX_VIEW], fboViews[i]);

        // Select the current cubemap face attachment for the fbo
        // WARNING: This function by default enables->attach->disables fbo!!!
        rlFramebufferAttach(fbo, cubemap.id, xx rlFramebufferAttachType.COLOR_CHANNEL0, xx (xx rlFramebufferAttachTextureType.CUBEMAP_POSITIVE_X + i), 0);
        rlEnableFramebuffer(fbo);

        // Load and draw a cube, it uses the current enabled texture
        rlClearScreenBuffers();
        rlLoadDrawCube();

        // ALTERNATIVE: Try to use internal batch system to draw the cube instead of rlLoadDrawCube
        // for some reason this method does not work, maybe due to cube triangles definition? normals pointing out?
        // TODO: Investigate this issue...
        //rlSetTexture(panorama.id); // WARNING: It must be called after enabling current framebuffer if using internal batch system!
        //rlClearScreenBuffers();
        //DrawCubeV(Vector3Zero(), Vector3One(), WHITE);
        //rlDrawRenderBatchActive();
    }
    //------------------------------------------------------------------------------------------

    // STEP 3: Unload framebuffer and reset state
    //------------------------------------------------------------------------------------------
    rlDisableShader();          // Unbind shader
    rlDisableTexture();         // Unbind texture
    rlDisableFramebuffer();     // Unbind framebuffer
    rlUnloadFramebuffer(fbo);

    // Reset viewport dimensions to default
    rlViewport(0, 0, rlGetFramebufferWidth(), rlGetFramebufferHeight());
    rlEnableBackfaceCulling();
    //------------------------------------------------------------------------------------------

    cubemap.width   = size;
    cubemap.height  = size;
    cubemap.mipmaps = 1;
    cubemap.format  = format;

    return cubemap;
}
