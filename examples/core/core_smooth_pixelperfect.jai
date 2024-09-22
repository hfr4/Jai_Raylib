/* ******************************************************************************************
*
*   raylib [core] example - Smooth Pixel-perfect camera
*
*   Example originally created with raylib 3.7, last time updated with raylib 4.0
*
*   Example contributed by Giancamillo Alessandroni (@NotManyIdeasDev) and
*   reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2021-2024 Giancamillo Alessandroni (@NotManyIdeasDev) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    virtualScreenWidth : s32 = 160;
    virtualScreenHeight : s32 = 90;

    virtualRatio := cast(float) SCREEN_WIDTH/cast(float) virtualScreenWidth;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - smooth pixel-perfect camera");

    worldSpaceCamera: Camera2D;  // Game world camera
    worldSpaceCamera.zoom = 1.0;

    screenSpaceCamera: Camera2D; // Smoothing camera
    screenSpaceCamera.zoom = 1.0;

    target := LoadRenderTexture(virtualScreenWidth, virtualScreenHeight); // This is where we'll draw all our objects.

    rec01 := Rectangle.{ 70.0, 35.0, 20.0, 20.0 };
    rec02 := Rectangle.{ 90.0, 55.0, 30.0, 10.0 };
    rec03 := Rectangle.{ 80.0, 65.0, 15.0, 25.0 };

    // The target's height is flipped (in the source Rectangle), due to OpenGL reasons
    sourceRec := Rectangle.{ 0.0, 0.0, cast(float) target.texture.width, -cast(float) target.texture.height };
    destRec := Rectangle.{ -virtualRatio, -virtualRatio, SCREEN_WIDTH + (virtualRatio*2), SCREEN_HEIGHT + (virtualRatio*2) };

    origin := Vector2.{ 0.0, 0.0 };

    rotation := 0.0;

    cameraX := 0.0;
    cameraY := 0.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        rotation += 60.0*GetFrameTime();   // Rotate the rectangles, 60 degrees per second

        // Make the camera move to demonstrate the effect
        cameraX = xx (Math.sin(cast(float) GetTime())*50.0) - 10.0;
        cameraY = xx (Math.cos(cast(float) GetTime())*30.0);

        // Set the camera's target to the values computed above
        screenSpaceCamera.target = .{ cameraX, cameraY };

        // Round worldSpace coordinates, keep decimals into screenSpace coordinates
        worldSpaceCamera.target.x = (screenSpaceCamera.target.x);
        screenSpaceCamera.target.x -= worldSpaceCamera.target.x;
        screenSpaceCamera.target.x *= virtualRatio;

        worldSpaceCamera.target.y = (screenSpaceCamera.target.y);
        screenSpaceCamera.target.y -= worldSpaceCamera.target.y;
        screenSpaceCamera.target.y *= virtualRatio;


        BeginTextureMode(target);
            ClearBackground(RAYWHITE);

            BeginMode2D(worldSpaceCamera);
                DrawRectanglePro(rec01, origin, rotation, BLACK);
                DrawRectanglePro(rec02, origin, -rotation, RED);
                DrawRectanglePro(rec03, origin, rotation + 45.0, BLUE);
            EndMode2D();
        EndTextureMode();

        BeginDrawing();
            ClearBackground(RED);

            BeginMode2D(screenSpaceCamera);
                DrawTexturePro(target.texture, sourceRec, destRec, origin, 0.0, WHITE);
            EndMode2D();

            DrawText(TextFormat("Screen resolution: %ix%", SCREEN_WIDTH, SCREEN_HEIGHT), 10, 10, 20, DARKBLUE);
            DrawText(TextFormat("World resolution: %ix%", virtualScreenWidth, virtualScreenHeight), 10, 40, 20, DARKGREEN);
            DrawFPS(GetScreenWidth() - 95, 10);
        EndDrawing();
    }

    UnloadRenderTexture(target);    // Unload render texture

    CloseWindow();

}