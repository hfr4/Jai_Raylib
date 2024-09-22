/* ******************************************************************************************
*
*   raylib [textures] example - Bunnymark
*
*   Example originally created with raylib 1.6, last time updated with raylib 2.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_BUNNIES   ::  50000;    // 50K bunnies limit

// This is the maximum amount of elements (quads) per batch
// NOTE: This value is defined in [rlgl] module and can be changed there
MAX_BATCH_ELEMENTS ::  8192;

Bunny :: struct {
    position: Vector2;
    speed:    Vector2;
    color:    Color;
}

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - bunnymark");

    // Load bunny texture
    texBunny := LoadTexture("resources/wabbit_alpha.png");

    bunnies := NewArray(MAX_BUNNIES, Bunny); // Bunnies array

    bunniesCount := 0;           // Bunnies counter

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsMouseButtonDown(xx MouseButton.LEFT))
        {
            // Create more bunnies
            for i: 0..99
            {
                if (bunniesCount < MAX_BUNNIES)
                {
                    bunnies[bunniesCount].position = GetMousePosition();
                    bunnies[bunniesCount].speed.x = cast(float)GetRandomValue(-250, 250)/60.0;
                    bunnies[bunniesCount].speed.y = cast(float)GetRandomValue(-250, 250)/60.0;
                    bunnies[bunniesCount].color = .{
                        cast(u8) GetRandomValue(50, 240),
                        cast(u8) GetRandomValue(80, 240),
                        cast(u8) GetRandomValue(100, 240),
                        255,
                    };
                    bunniesCount += 1;
                }
            }
        }

        // Update bunnies
        for i: 0..bunniesCount - 1
        {
            bunnies[i].position.x += bunnies[i].speed.x;
            bunnies[i].position.y += bunnies[i].speed.y;

            if (((bunnies[i].position.x + texBunny.width/2) > xx GetScreenWidth()) ||
                ((bunnies[i].position.x + texBunny.width/2) < 0)) bunnies[i].speed.x *= -1;
            if (((bunnies[i].position.y + texBunny.height/2) > xx GetScreenHeight()) ||
                ((bunnies[i].position.y + texBunny.height/2 - 40) < 0)) bunnies[i].speed.y *= -1;
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            for i: 0..bunniesCount - 1
            {
                // NOTE: When internal batch buffer limit is reached (MAX_BATCH_ELEMENTS),
                // a draw call is launched and buffer starts being filled again;
                // before issuing a draw call, updated vertex data from internal CPU buffer is send to GPU...
                // Process of sending data is costly and it could happen that GPU data has not been completely
                // processed for drawing while new data is tried to be sent (updating current in-use buffers)
                // it could generates a stall and consequently a frame drop, limiting the number of drawn bunnies
                DrawTexture(texBunny, cast(s32) bunnies[i].position.x, cast(s32) bunnies[i].position.y, bunnies[i].color);
            }

            DrawRectangle(0, 0, SCREEN_WIDTH, 40, BLACK);
            DrawText(TextFormat("bunnies: %", bunniesCount), 120, 10, 20, GREEN);
            DrawText(TextFormat("batched draw calls: %", 1 + bunniesCount/MAX_BATCH_ELEMENTS), 320, 10, 20, MAROON);

            DrawFPS(10, 10);

        EndDrawing();
    }
    array_free(bunnies);

    UnloadTexture(texBunny);    // Unload bunny texture

    CloseWindow();
}
