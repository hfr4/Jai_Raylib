/* ******************************************************************************************
*
*   raylib example - particles blending
*
*   Example originally created with raylib 1.7, last time updated with raylib 3.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_PARTICLES :: 200;

Particle :: struct {
    position: Vector2;
    color:    Color;
    alpha:    float;
    size:     float;
    rotation: float;
    active:   bool;
}

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - particles blending");

    // Particles pool, reuse them!
    mouseTail: [MAX_PARTICLES] Particle;

    // Initialize particles
    for i: 0..MAX_PARTICLES - 1
    {
        mouseTail[i].position = .{ 0, 0 };
        mouseTail[i].color    = .{ cast(u8) GetRandomValue(0, 255), cast(u8) GetRandomValue(0, 255), cast(u8) GetRandomValue(0, 255), 255 };
        mouseTail[i].alpha    = 1.0;
        mouseTail[i].size     = cast(float) GetRandomValue(1, 30)/20.0;
        mouseTail[i].rotation = cast(float) GetRandomValue(0, 360);
        mouseTail[i].active   = false;
    }

    gravity := 3.0;

    smoke := LoadTexture("resources/spark_flame.png");

    blending := BlendMode.ALPHA;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // Activate one particle every frame and Update active particles
        // NOTE: Particles initial position should be mouse position when activated
        // NOTE: Particles fall down with gravity and rotation... and disappear after 2 seconds (alpha = 0)
        // NOTE: When a particle disappears, active = false and it can be reused.
        for i: 0..MAX_PARTICLES - 1
        {
            if (!mouseTail[i].active)
            {
                mouseTail[i].active   = true;
                mouseTail[i].alpha    = 1.0;
                mouseTail[i].position = GetMousePosition();
                i = MAX_PARTICLES;
            }
        }

        for i: 0..MAX_PARTICLES - 1
        {
            if (mouseTail[i].active)
            {
                mouseTail[i].position.y += gravity/2;
                mouseTail[i].alpha      -= 0.005;

                if (mouseTail[i].alpha <= 0.0) mouseTail[i].active = false;

                mouseTail[i].rotation += 2.0;
            }
        }

        if (IsKeyPressed(xx KeyboardKey.SPACE))
        {
            if (blending == .ALPHA) blending = .ADDITIVE;
            else                    blending = .ALPHA;
        }

        BeginDrawing();

            ClearBackground(DARKGRAY);

            BeginBlendMode(xx blending);

                // Draw active particles
                for i: 0..MAX_PARTICLES - 1
                {
                    r0 := Rectangle.{ 0.0, 0.0, cast(float) smoke.width, cast(float) smoke.height };
                    r1 := Rectangle.{ mouseTail[i].position.x, mouseTail[i].position.y, smoke.width*mouseTail[i].size, smoke.height*mouseTail[i].size };
                    v  := Vector2.{ cast(float) (smoke.width*mouseTail[i].size/2.0), cast(float) (smoke.height*mouseTail[i].size/2.0) };
                    if (mouseTail[i].active) DrawTexturePro(smoke, r0 , r1, v, mouseTail[i].rotation, Fade(mouseTail[i].color, mouseTail[i].alpha));
                }

            EndBlendMode();

            DrawText("PRESS SPACE to CHANGE BLENDING MODE", 180, 20, 20, BLACK);

            if (blending == .ALPHA) DrawText("ALPHA BLENDING"   , 290, SCREEN_HEIGHT - 40, 20, BLACK);
            else                    DrawText("ADDITIVE BLENDING", 280, SCREEN_HEIGHT - 40, 20, RAYWHITE);

        EndDrawing();
    }
    UnloadTexture(smoke);

    CloseWindow();
}