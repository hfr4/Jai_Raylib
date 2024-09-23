/* ******************************************************************************************
*
*   raylib [models] example - Detect basic 3d collisions (box vs sphere vs box)
*
*   Example originally created with raylib 1.3, last time updated with raylib 3.5
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

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - box collisions");

    // Define the camera to look into our 3d world
    camera: Camera = .{
        .{ 0.0, 10.0, 10.0 },
        .{ 0.0, 0.0, 0.0 },
        .{ 0.0, 1.0, 0.0 },
        45.0,
        0
    };

    playerPosition := Vector3.{ 0.0, 1.0, 2.0 };
    playerSize := Vector3.{ 1.0, 2.0, 1.0 };
    playerColor: Color = GREEN;

    enemyBoxPos := Vector3.{ -4.0, 1.0, 0.0 };
    enemyBoxSize := Vector3.{ 2.0, 2.0, 2.0 };

    enemySpherePos := Vector3.{ 4.0, 0.0, 0.0 };
    enemySphereSize := 1.5;

    collision := false;

    SetTargetFPS(60);

    while !WindowShouldClose() {


        // Move player
        if      (IsKeyDown(xx KeyboardKey.RIGHT)) playerPosition.x += 0.2;
        else if (IsKeyDown(xx KeyboardKey.LEFT)) playerPosition.x -= 0.2;
        else if (IsKeyDown(xx KeyboardKey.DOWN)) playerPosition.z += 0.2;
        else if (IsKeyDown(xx KeyboardKey.UP)) playerPosition.z -= 0.2;

        collision = false;

        // Check collisions player vs enemy-box

        bb0 := BoundingBox.{
            .{ playerPosition.x - playerSize.x/2, playerPosition.y - playerSize.y/2, playerPosition.z - playerSize.z/2 },
            .{ playerPosition.x + playerSize.x/2, playerPosition.y + playerSize.y/2, playerPosition.z + playerSize.z/2 },
        };
        bb1 := BoundingBox.{
                .{ enemyBoxPos.x - enemyBoxSize.x/2, enemyBoxPos.y - enemyBoxSize.y/2, enemyBoxPos.z - enemyBoxSize.z/2 },
                .{ enemyBoxPos.x + enemyBoxSize.x/2, enemyBoxPos.y + enemyBoxSize.y/2, enemyBoxPos.z + enemyBoxSize.z/2 },
        };
        if (CheckCollisionBoxes(bb0, bb1)) collision = true;

        // Check collisions player vs enemy-sphere
        if (CheckCollisionBoxSphere( bb0, enemySpherePos, enemySphereSize)) collision = true;

        if (collision) playerColor = RED;
        else           playerColor = GREEN;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                // Draw enemy-box
                DrawCube(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, GRAY);
                DrawCubeWires(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, DARKGRAY);

                // Draw enemy-sphere
                DrawSphere(enemySpherePos, enemySphereSize, GRAY);
                DrawSphereWires(enemySpherePos, enemySphereSize, 16, 16, DARKGRAY);

                // Draw player
                DrawCubeV(playerPosition, playerSize, playerColor);

                DrawGrid(10, 1.0);        // Draw a grid

            EndMode3D();

            DrawText("Move player with arrow keys to collide", 220, 40, 20, GRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }

    CloseWindow();
}