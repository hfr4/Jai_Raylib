/* ******************************************************************************************
*
*   raylib [core] example - 3d cmaera split screen
*
*   Example originally created with raylib 3.7, last time updated with raylib 4.0
*
*   Example contributed by Jeffery Myers (@JeffM2501) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2021-2024 Jeffery Myers (@JeffM2501)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 3d camera split screen");

    // Setup player 1 camera and screen
    cameraPlayer1: Camera;
    cameraPlayer1.fovy       = 45.0;
    cameraPlayer1.up.y       = 1.0;
    cameraPlayer1.target.y   = 1.0;
    cameraPlayer1.position.z = -3.0;
    cameraPlayer1.position.y = 1.0;

    screenPlayer1 := LoadRenderTexture(SCREEN_WIDTH/2, SCREEN_HEIGHT);

    // Setup player two camera and screen
    cameraPlayer2: Camera;
    cameraPlayer2.fovy       = 45.0;
    cameraPlayer2.up.y       = 1.0;
    cameraPlayer2.target.y   = 3.0;
    cameraPlayer2.position.x = -3.0;
    cameraPlayer2.position.y = 3.0;

    screenPlayer2 := LoadRenderTexture(SCREEN_WIDTH / 2, SCREEN_HEIGHT);

    // Build a flipped rectangle the size of the split view to use for drawing later
    splitScreenRect := Rectangle.{ 0.0, 0.0, cast(float) screenPlayer1.texture.width, cast(float) -screenPlayer1.texture.height };

    // Grid data
    count := 5;
    spacing := 4;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // If anyone moves this frame, how far will they move based on the time since the last frame
        // this moves thigns at 10 world units per second, regardless of the actual FPS
        offsetThisFrame := 10.0*GetFrameTime();

        // Move Player1 forward and backwards (no turning)
        if (IsKeyDown(xx KeyboardKey.W))
        {
            cameraPlayer1.position.z += offsetThisFrame;
            cameraPlayer1.target.z   += offsetThisFrame;
        }
        else if (IsKeyDown(xx KeyboardKey.S))
        {
            cameraPlayer1.position.z -= offsetThisFrame;
            cameraPlayer1.target.z   -= offsetThisFrame;
        }

        // Move Player2 forward and backwards (no turning)
        if (IsKeyDown(xx KeyboardKey.UP))
        {
            cameraPlayer2.position.x += offsetThisFrame;
            cameraPlayer2.target.x   += offsetThisFrame;
        }
        else if (IsKeyDown(xx KeyboardKey.DOWN))
        {
            cameraPlayer2.position.x -= offsetThisFrame;
            cameraPlayer2.target.x   -= offsetThisFrame;
        }


        // Draw Player1 view to the render texture
        BeginTextureMode(screenPlayer1);
            ClearBackground(SKYBLUE);

            BeginMode3D(cameraPlayer1);

                // Draw scene: grid of cube trees on a plane to make a "world"
                DrawPlane(.{ 0, 0, 0 }, .{ 50, 50 }, BEIGE); // Simple world plane

                for x: -count..count {
                    xs := cast(float) (x * spacing);

                    for z : -count..count {
                        zs := cast(float) (z * spacing);

                        DrawCube(.{ xs, 1.5, zs }, 1   , 1, 1   , LIME);
                        DrawCube(.{ xs, 0.5, zs }, 0.25, 1, 0.25, BROWN);
                    }
                }

                // Draw a cube at each player's position
                DrawCube(cameraPlayer1.position, 1, 1, 1, RED);
                DrawCube(cameraPlayer2.position, 1, 1, 1, BLUE);

            EndMode3D();

            DrawRectangle(0, 0, GetScreenWidth()/2, 40, Fade(RAYWHITE, 0.8));
            DrawText("PLAYER1: W/S to move", 10, 10, 20, MAROON);

        EndTextureMode();

        // Draw Player2 view to the render texture
        BeginTextureMode(screenPlayer2);
            ClearBackground(SKYBLUE);

            BeginMode3D(cameraPlayer2);

                // Draw scene: grid of cube trees on a plane to make a "world"
                DrawPlane(.{ 0, 0, 0 }, .{ 50, 50 }, BEIGE); // Simple world plane

                for x: -count..count {
                    xs := cast(float) (x * spacing);

                    for z : -count..count {
                        zs := cast(float) (z * spacing);

                        DrawCube(.{ xs, 1.5, zs }, 1   , 1, 1   , LIME);
                        DrawCube(.{ xs, 0.5, zs }, 0.25, 1, 0.25, BROWN);
                    }
                }

                // Draw a cube at each player's position
                DrawCube(cameraPlayer1.position, 1, 1, 1, RED);
                DrawCube(cameraPlayer2.position, 1, 1, 1, BLUE);

            EndMode3D();

            DrawRectangle(0, 0, GetScreenWidth()/2, 40, Fade(RAYWHITE, 0.8));
            DrawText("PLAYER2: UP/DOWN to move", 10, 10, 20, DARKBLUE);

        EndTextureMode();

        // Draw both views render textures to the screen side by side
        BeginDrawing();
            ClearBackground(BLACK);

            DrawTextureRec(screenPlayer1.texture, splitScreenRect, .{ 0, 0 }, WHITE);
            DrawTextureRec(screenPlayer2.texture, splitScreenRect, .{ SCREEN_WIDTH/2.0, 0 }, WHITE);

            DrawRectangle(GetScreenWidth()/2 - 2, 0, 4, GetScreenHeight(), LIGHTGRAY);
        EndDrawing();
    }
    UnloadRenderTexture(screenPlayer1);
    UnloadRenderTexture(screenPlayer2);

    CloseWindow();
}