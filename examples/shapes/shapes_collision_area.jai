/* ******************************************************************************************
*
*   raylib [shapes] example - collision area
*
*   Example originally created with raylib 2.5, last time updated with raylib 2.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2013-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - collision area");

    // Box A: Moving box
    boxA := Rectangle.{ 10, GetScreenHeight()/2.0 - 50, 200, 100 };
    boxASpeedX := 4;

    // Box B: Mouse moved box
    boxB := Rectangle.{ GetScreenWidth()/2.0 - 30, GetScreenHeight()/2.0 - 30, 60, 60 };

    boxCollision: Rectangle; // Collision rectangle

    screenUpperLimit : s32 = 40;      // Top menu limits

    pause := false;             // Movement pause
    collision := false;         // Collision detection

    SetTargetFPS(60);

    while !WindowShouldClose() {
                //-----------------------------------------------------
        // Move box if not paused
        if (!pause) boxA.x += boxASpeedX;

        // Bounce box on x screen limits
        if (((boxA.x + boxA.width) >= xx GetScreenWidth()) || (boxA.x <= 0)) boxASpeedX *= -1;

        // Update player-controlled-box (box02)
        boxB.x = GetMouseX() - boxB.width/2;
        boxB.y = GetMouseY() - boxB.height/2;

        // Make sure Box B does not go out of move area limits
        if  ((boxB.x + boxB.width) >= xx GetScreenWidth()) boxB.x = GetScreenWidth() - boxB.width;
        else if (boxB.x <= 0) boxB.x = 0;

        if ((boxB.y + boxB.height) >= xx GetScreenHeight()) boxB.y = GetScreenHeight() - boxB.height;
        else if (boxB.y <= xx screenUpperLimit) boxB.y = cast(float) screenUpperLimit;

        // Check boxes collision
        collision = CheckCollisionRecs(boxA, boxB);

        // Get collision rectangle (only on collision)
        if (collision) boxCollision = GetCollisionRec(boxA, boxB);

        // Pause Box A movement
        if (IsKeyPressed(xx KeyboardKey.SPACE)) pause = !pause;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawRectangle(0, 0, SCREEN_WIDTH, screenUpperLimit, ifx collision then RED else BLACK);

            DrawRectangleRec(boxA, GOLD);
            DrawRectangleRec(boxB, BLUE);

            if (collision)
            {
                // Draw collision area
                DrawRectangleRec(boxCollision, LIME);

                // Draw collision message
                DrawText("COLLISION!", GetScreenWidth()/2 - MeasureText("COLLISION!", 20)/2, screenUpperLimit/2 - 10, 20, BLACK);

                // Draw collision area
                DrawText(TextFormat("Collision Area: %", cast(s32) boxCollision.width* cast(s32) boxCollision.height), GetScreenWidth()/2 - 100, screenUpperLimit + 10, 20, BLACK);
            }

            // Draw help instructions
            DrawText("Press SPACE to PAUSE/RESUME", 20, SCREEN_HEIGHT - 35, 20, LIGHTGRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }

    CloseWindow();
}