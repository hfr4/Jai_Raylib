/* ******************************************************************************************
*
*   raylib [core] example - 2d camera split screen
*
*   Addapted from the core_3d_camera_split_screen example:
*       https://github.com/raysan5/raylib/blob/master/examples/core/core_3d_camera_split_screen.c
*
*   Example originally created with raylib 4.5, last time updated with raylib 4.5
*
*   Example contributed by Gabriel dos Santos Sanches (@gabrielssanches) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 Gabriel dos Santos Sanches (@gabrielssanches)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

PLAYER_SIZE :: 40;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera split screen");

    player1 := Rectangle.{ 200, 200, PLAYER_SIZE, PLAYER_SIZE };
    player2 := Rectangle.{ 250, 200, PLAYER_SIZE, PLAYER_SIZE };

    camera1: Camera2D;
    camera1.target   = .{ player1.x, player1.y };
    camera1.offset   = .{ 200.0, 200.0 };
    camera1.rotation = 0.0;
    camera1.zoom     = 1.0;

    camera2: Camera2D;
    camera2.target   = .{ player2.x, player2.y };
    camera2.offset   = .{ 200.0, 200.0 };
    camera2.rotation = 0.0;
    camera2.zoom     = 1.0;

    screenCamera1 := LoadRenderTexture(SCREEN_WIDTH/2, SCREEN_HEIGHT);
    screenCamera2 := LoadRenderTexture(SCREEN_WIDTH/2, SCREEN_HEIGHT);

    // Build a flipped rectangle the size of the split view to use for drawing later
    splitScreenRect := Rectangle.{ 0.0, 0.0, cast(float) screenCamera1.texture.width, cast(float) -screenCamera1.texture.height };

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if      (IsKeyDown(xx KeyboardKey.S)) player1.y += 3.0;
        else if (IsKeyDown(xx KeyboardKey.W)) player1.y -= 3.0;
        if      (IsKeyDown(xx KeyboardKey.D)) player1.x += 3.0;
        else if (IsKeyDown(xx KeyboardKey.A)) player1.x -= 3.0;

        if      (IsKeyDown(xx KeyboardKey.UP))    player2.y -= 3.0;
        else if (IsKeyDown(xx KeyboardKey.DOWN))  player2.y += 3.0;
        if      (IsKeyDown(xx KeyboardKey.RIGHT)) player2.x += 3.0;
        else if (IsKeyDown(xx KeyboardKey.LEFT))  player2.x -= 3.0;

        camera1.target = .{ player1.x, player1.y };
        camera2.target = .{ player2.x, player2.y };


        BeginTextureMode(screenCamera1);
            ClearBackground(RAYWHITE);

            BeginMode2D(camera1);

                // Draw full scene with first camera
                for i: 0..SCREEN_WIDTH/PLAYER_SIZE
                {
                    DrawLineV(.{cast(float) PLAYER_SIZE*i, 0}, .{ cast(float) PLAYER_SIZE*i, cast(float) SCREEN_HEIGHT}, LIGHTGRAY);
                }

                for i: 0..SCREEN_HEIGHT/PLAYER_SIZE
                {
                    DrawLineV(.{0, cast(float) PLAYER_SIZE*i}, .{ cast(float) SCREEN_WIDTH, cast(float) PLAYER_SIZE*i}, LIGHTGRAY);
                }

                for i: 0..SCREEN_WIDTH/PLAYER_SIZE - 1
                {
                    for j: 0..SCREEN_HEIGHT/PLAYER_SIZE - 1
                    {
                        DrawText(TextFormat("[%, %]", i, j), cast(s32) (10 + PLAYER_SIZE*i), cast(s32) (15 + PLAYER_SIZE*j), 10, LIGHTGRAY);
                    }
                }

                DrawRectangleRec(player1, RED);
                DrawRectangleRec(player2, BLUE);
            EndMode2D();

            DrawRectangle(0, 0, GetScreenWidth()/2, 30, Fade(RAYWHITE, 0.6));
            DrawText("PLAYER1: W/S/A/D to move", 10, 10, 10, MAROON);

        EndTextureMode();

        BeginTextureMode(screenCamera2);
            ClearBackground(RAYWHITE);

            BeginMode2D(camera2);

                // Draw full scene with second camera
                for i: 0..SCREEN_WIDTH/PLAYER_SIZE
                {
                    DrawLineV(.{ cast(float) PLAYER_SIZE*i, 0}, .{ cast(float) PLAYER_SIZE*i, cast(float) SCREEN_HEIGHT}, LIGHTGRAY);
                }

                for i: 0..SCREEN_HEIGHT/PLAYER_SIZE
                {
                    DrawLineV(.{0, cast(float) PLAYER_SIZE*i}, .{ cast(float) SCREEN_WIDTH, cast(float) PLAYER_SIZE*i}, LIGHTGRAY);
                }

                for i: 0..SCREEN_WIDTH/PLAYER_SIZE - 1
                {
                    for j: 0..SCREEN_HEIGHT/PLAYER_SIZE - 1
                    {
                        DrawText(TextFormat("[%, %]", i, j), cast(s32) (10 + PLAYER_SIZE*i), cast(s32) (15 + PLAYER_SIZE*j), 10, LIGHTGRAY);
                    }
                }

                DrawRectangleRec(player1, RED);
                DrawRectangleRec(player2, BLUE);

            EndMode2D();

            DrawRectangle(0, 0, GetScreenWidth()/2, 30, Fade(RAYWHITE, 0.6));
            DrawText("PLAYER2: UP/DOWN/LEFT/RIGHT to move", 10, 10, 10, DARKBLUE);

        EndTextureMode();

        // Draw both views render textures to the screen side by side
        BeginDrawing();
            ClearBackground(BLACK);

            DrawTextureRec(screenCamera1.texture, splitScreenRect, .{ 0, 0 }, WHITE);
            DrawTextureRec(screenCamera2.texture, splitScreenRect, .{ SCREEN_WIDTH/2.0, 0 }, WHITE);

            DrawRectangle(GetScreenWidth()/2 - 2, 0, 4, GetScreenHeight(), LIGHTGRAY);
        EndDrawing();
    }
    UnloadRenderTexture(screenCamera1);
    UnloadRenderTexture(screenCamera2);

    CloseWindow();
}