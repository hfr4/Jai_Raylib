/* ******************************************************************************************
*
*   raylib [core] example - 2D Camera system
*
*   Example originally created with raylib 1.5, last time updated with raylib 3.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2016-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_BUILDINGS :: 100;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera");

    player := Rectangle.{ 400, 280, 40, 40 };
    buildings: [MAX_BUILDINGS] Rectangle;
    buildColors: [MAX_BUILDINGS] Color;

    spacing := 0;

    for i: 0..MAX_BUILDINGS - 1
    {
        buildings[i].width  = cast(float) GetRandomValue(50, 200);
        buildings[i].height = cast(float) GetRandomValue(100, 800);
        buildings[i].y      = SCREEN_HEIGHT - 130.0 - buildings[i].height;
        buildings[i].x      = -6000.0 + spacing;

        spacing += cast(s32) buildings[i].width;

        buildColors[i] = Color.{ xx GetRandomValue(200, 240), xx GetRandomValue(200, 240), xx GetRandomValue(200, 250), 255 };
    }

    camera: Camera2D;
    camera.target   = .{ player.x + 20.0, player.y + 20.0 };
    camera.offset   = .{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 };
    camera.rotation = 0.0;
    camera.zoom     = 1.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // Player movement
        if      (IsKeyDown(xx KeyboardKey.RIGHT)) player.x += 2;
        else if (IsKeyDown(xx KeyboardKey.LEFT))  player.x -= 2;

        // Camera target follows player
        camera.target = .{ player.x + 20, player.y + 20 };

        // Camera rotation controls
        if      (IsKeyDown(xx KeyboardKey.A)) camera.rotation -= 1;
        else if (IsKeyDown(xx KeyboardKey.S)) camera.rotation += 1;

        // Limit camera rotation to 80 degrees (-40 to 40)
        if      (camera.rotation >  40) camera.rotation =  40;
        else if (camera.rotation < -40) camera.rotation = -40;

        // Camera zoom controls
        camera.zoom += (cast(float) GetMouseWheelMove()*0.05);

        if      (camera.zoom > 3.0) camera.zoom = 3.0;
        else if (camera.zoom < 0.1) camera.zoom = 0.1;

        // Camera reset (zoom and rotation)
        if (IsKeyPressed(xx KeyboardKey.R))
        {
            camera.zoom     = 1.0;
            camera.rotation = 0.0;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode2D(camera);

                DrawRectangle(-6000, 320, 13000, 8000, DARKGRAY);

                for i: 0..MAX_BUILDINGS - 1 DrawRectangleRec(buildings[i], buildColors[i]);

                DrawRectangleRec(player, RED);

                DrawLine(cast(s32) camera.target.x, -SCREEN_HEIGHT*10, cast(s32) camera.target.x, SCREEN_HEIGHT*10, GREEN);
                DrawLine(-SCREEN_WIDTH*10, cast(s32) camera.target.y, SCREEN_WIDTH*10, cast(s32) camera.target.y, GREEN);

            EndMode2D();

            DrawText("SCREEN AREA", 640, 10, 20, RED);

            DrawRectangle(0, 0, SCREEN_WIDTH, 5, RED);
            DrawRectangle(0, 5, 5, SCREEN_HEIGHT - 10, RED);
            DrawRectangle(SCREEN_WIDTH - 5, 5, 5, SCREEN_HEIGHT - 10, RED);
            DrawRectangle(0, SCREEN_HEIGHT - 5, SCREEN_WIDTH, 5, RED);

            DrawRectangle( 10, 10, 250, 113, Fade(SKYBLUE, 0.5));
            DrawRectangleLines( 10, 10, 250, 113, BLUE);

            DrawText("Free 2d camera controls:", 20, 20, 10, BLACK);
            DrawText("- Right/Left to move Offset", 40, 40, 10, DARKGRAY);
            DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY);
            DrawText("- A / S to Rotate", 40, 80, 10, DARKGRAY);
            DrawText("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY);

        EndDrawing();
    }
    CloseWindow();
}
