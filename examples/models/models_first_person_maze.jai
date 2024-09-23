/* ******************************************************************************************
*
*   raylib [models] example - first person maze
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - first person maze");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 0.2, 0.4, 0.2 };              // Camera position
    camera.target     = .{ 0.185, 0.4, 0.0 };            // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    imMap    := LoadImage("resources/cubicmap.png");      // Load cubicmap image (RAM)
    cubicmap := LoadTextureFromImage(imMap);              // Convert image to texture to display (VRAM)
    mesh     := GenMeshCubicmap(imMap, .{ 1.0, 1.0, 1.0 });
    model    := LoadModelFromMesh(mesh);

    // NOTE: By default each cube is mapped to one part of texture atlas
    texture := LoadTexture("resources/cubicmap_atlas.png");    // Load map texture
    model.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;    // Set map diffuse texture

    // Get map image data to be used for collision detection
    mapPixels := LoadImageColors(imMap);
    UnloadImage(imMap);

    mapPosition := Vector3.{ -16.0, 0.0, -8.0 };  // Set model position

    DisableCursor();                // Limit cursor to relative movement inside the window

    SetTargetFPS(60);

    while !WindowShouldClose() {

        oldCamPos := camera.position;    // Store old camera position

        UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);

        // Check player collision (we simplify to 2D collision detection)
        playerPos := Vector2.{ camera.position.x, camera.position.z };
        playerRadius := 0.1;  // Collision radius (player is modelled as a cilinder for collision)

        playerCellX := cast(s32) (playerPos.x - mapPosition.x + 0.5);
        playerCellY := cast(s32) (playerPos.y - mapPosition.z + 0.5);

        // Out-of-limits security check
        if      (playerCellX < 0)               playerCellX = 0;
        else if (playerCellX >= cubicmap.width) playerCellX = cubicmap.width - 1;

        if      (playerCellY < 0)                playerCellY = 0;
        else if (playerCellY >= cubicmap.height) playerCellY = cubicmap.height - 1;

        // Check map collisions using image data and player position
        // TODO: Improvement: Just check player surrounding cells for collision
        for y: 0..cubicmap.height - 1
        {
            for x: 0..cubicmap.width - 1
            {
                if ((mapPixels[y*cubicmap.width + x].r == 255) &&       // Collision: white pixel, only check R channel
                    (CheckCollisionCircleRec(playerPos, playerRadius,
                    .{ mapPosition.x - 0.5 + x*1.0, mapPosition.z - 0.5 + y*1.0, 1.0, 1.0 })))
                {
                    // Collision detected, reset camera position
                    camera.position = oldCamPos;
                }
            }
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);
                DrawModel(model, mapPosition, 1.0, WHITE);                     // Draw maze map
            EndMode3D();

            DrawTextureEx(cubicmap, .{ GetScreenWidth() - cubicmap.width*4.0 - 20, 20.0 }, 0.0, 4.0, WHITE);
            DrawRectangleLines(GetScreenWidth() - cubicmap.width*4 - 20, 20, cubicmap.width*4, cubicmap.height*4, GREEN);

            // Draw player position radar
            DrawRectangle(GetScreenWidth() - cubicmap.width*4 - 20 + playerCellX*4, 20 + playerCellY*4, 4, 4, RED);

            DrawFPS(10, 10);

        EndDrawing();
    }

    UnloadImageColors(mapPixels);

    UnloadTexture(cubicmap);
    UnloadTexture(texture);
    UnloadModel(model);

    CloseWindow();
}