/* ******************************************************************************************
*
*   raylib [models] example - Cubicmap loading and drawing
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - cubesmap loading and drawing");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 16.0, 14.0, 16.0 };           // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    image    := LoadImage("resources/cubicmap.png");  // Load cubicmap image (RAM)
    cubicmap := LoadTextureFromImage(image);          // Convert image to texture to display (VRAM)

    mesh  := GenMeshCubicmap(image, .{ 1.0, 1.0, 1.0 });
    model := LoadModelFromMesh(mesh);

    // NOTE: By default each cube is mapped to one part of texture atlas
    texture := LoadTexture("resources/cubicmap_atlas.png");    // Load map texture
    model.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;    // Set map diffuse texture

    mapPosition := Vector3.{ -16.0, 0.0, -8.0 };          // Set model position

    UnloadImage(image);     // Unload cubesmap image from RAM, already uploaded to VRAM

    pause := false;     // Pause camera orbital rotation (and zoom)

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyPressed(xx KeyboardKey.P)) pause = !pause;

        if (!pause) UpdateCamera(*camera, xx CameraMode.ORBITAL);


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawModel(model, mapPosition, 1.0, WHITE);

            EndMode3D();

            DrawTextureEx(cubicmap, .{ SCREEN_WIDTH - cubicmap.width*4.0 - 20, 20.0 }, 0.0, 4.0, WHITE);
            DrawRectangleLines(SCREEN_WIDTH - cubicmap.width*4 - 20, 20, cubicmap.width*4, cubicmap.height*4, GREEN);

            DrawText("cubicmap image used to", 658, 90, 10, GRAY);
            DrawText("generate map 3d model", 658, 104, 10, GRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }

    UnloadTexture(cubicmap);    // Unload cubicmap texture
    UnloadTexture(texture);     // Unload map texture
    UnloadModel(model);         // Unload map model

    CloseWindow();
}
