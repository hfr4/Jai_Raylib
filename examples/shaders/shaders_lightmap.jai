/* ******************************************************************************************
*
*   raylib [shaders] example - lightmap
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3).
*
*   Example contributed by Jussi Viitala (@nullstare) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 Jussi Viitala (@nullstare) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

MAP_SIZE :: 10;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);  // Enable Multi Sampling Anti Aliasing 4x (if available)
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - lightmap");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 4.0, 6.0, 8.0 };              // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    mesh := GenMeshPlane(cast(float)MAP_SIZE, cast(float)MAP_SIZE, 1, 1);

    // GenMeshPlane doesn't generate texcoords2 so we will upload them separately
    mesh.texcoords2 = cast(*float) alloc(mesh.vertexCount * 2 * size_of(float));

    // X                          // Y
    mesh.texcoords2[0] = 0.0;    mesh.texcoords2[1] = 0.0;
    mesh.texcoords2[2] = 1.0;    mesh.texcoords2[3] = 0.0;
    mesh.texcoords2[4] = 0.0;    mesh.texcoords2[5] = 1.0;
    mesh.texcoords2[6] = 1.0;    mesh.texcoords2[7] = 1.0;

    // Load a new texcoords2 attributes buffer
    mesh.vboId[xx ShaderLocationIndex.VERTEX_TEXCOORD02] = rlLoadVertexBuffer(mesh.texcoords2, mesh.vertexCount * 2 * size_of(float), false);
    rlEnableVertexArray(mesh.vaoId);

    // Index 5 is for texcoords2
    rlSetVertexAttribute(5, 2, RL_FLOAT, false, 0, null);
    rlEnableVertexAttribute(5);
    rlDisableVertexArray();

    // Load lightmap shader
    shader := LoadShader(TextFormat("resources/shaders/glsl%/lightmap.vs", GLSL_VERSION),
                               TextFormat("resources/shaders/glsl%/lightmap.fs", GLSL_VERSION));

    texture := LoadTexture("resources/cubicmap_atlas.png");
    light := LoadTexture("resources/spark_flame.png");

    GenTextureMipmaps(*texture);
    SetTextureFilter(texture, xx TextureFilter.TRILINEAR);

    lightmap := LoadRenderTexture(MAP_SIZE, MAP_SIZE);

    SetTextureFilter(lightmap.texture, xx TextureFilter.TRILINEAR);

    material := LoadMaterialDefault();
    material.shader = shader;
    material.maps[xx MaterialMapIndex.ALBEDO].texture = texture;
    material.maps[xx MaterialMapIndex.METALNESS].texture = lightmap.texture;

    // Drawing to lightmap
    BeginTextureMode(lightmap);
        ClearBackground(BLACK);

        BeginBlendMode(xx BlendMode.ADDITIVE);
            DrawTexturePro(
                light,
                .{ 0, 0, xx light.width, xx light.height },
                .{ 0, 0, 20, 20 },
                .{ 10.0, 10.0 },
                0.0,
                RED
            );
            DrawTexturePro(
                light,
                .{ 0, 0, xx light.width, xx light.height },
                .{ 8, 4, 20, 20 },
                .{ 10.0, 10.0 },
                0.0,
                BLUE
            );
            DrawTexturePro(
                light,
                .{ 0, 0, xx light.width, xx light.height },
                .{ 8, 8, 10, 10 },
                .{ 5.0, 5.0 },
                0.0,
                GREEN
            );
        BeginBlendMode(xx BlendMode.ALPHA);
    EndTextureMode();

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
        BeginDrawing();
            ClearBackground(RAYWHITE);

            BeginMode3D(camera);
                DrawMesh(mesh, material, MatrixIdentity());
            EndMode3D();

            DrawFPS(10, 10);

            DrawTexturePro(
                lightmap.texture,
                .{ 0, 0, -MAP_SIZE, -MAP_SIZE },
                .{ xx (GetRenderWidth() - MAP_SIZE*8 - 10), 10, xx (MAP_SIZE*8), xx (MAP_SIZE*8) },
                .{ 0.0, 0.0 },
                0.0,
                WHITE);

            DrawText("lightmap"    , GetRenderWidth() - 66, 16 + MAP_SIZE*8, 10, GRAY);
            DrawText("10x10 pixels", GetRenderWidth() - 76, 30 + MAP_SIZE*8, 10, GRAY);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadMesh(mesh);
    UnloadShader(shader);

    CloseWindow();          // Close window and OpenGL context
    //--------------------------------------------------------------------------------------


}

