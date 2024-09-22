/* ******************************************************************************************
*
*   raylib [models] example - Heightmap loading and drawing
*
*   Example originally created with raylib 1.8, last time updated with raylib 3.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - heightmap loading and drawing");

    // Define our custom camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 18.0, 21.0, 18.0 };           // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    image   := LoadImage("resources/heightmap.png");     // Load heightmap image (RAM)
    texture := LoadTextureFromImage(image);              // Convert image to texture (VRAM)
    mesh    := GenMeshHeightmap(image, .{ 16, 8, 16 });  // Generate heightmap mesh (RAM and VRAM)
    model   := LoadModelFromMesh(mesh);                  // Load model from generated mesh

    model.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture; // Set map diffuse texture
    mapPosition := Vector3.{ -8.0, 0.0, -8.0 };                             // Define model position

    UnloadImage(image);             // Unload heightmap image from RAM, already uploaded to VRAM

    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateCamera(*camera, xx CameraMode.ORBITAL);


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawModel(model, mapPosition, 1.0, RED);

                DrawGrid(20, 1.0);

            EndMode3D();

            DrawTexture(texture, SCREEN_WIDTH - texture.width - 20, 20, WHITE);
            DrawRectangleLines(SCREEN_WIDTH - texture.width - 20, 20, texture.width, texture.height, GREEN);

            DrawFPS(10, 10);

        EndDrawing();
    }

    UnloadTexture(texture);     // Unload texture
    UnloadModel(model);         // Unload model

    CloseWindow();
}