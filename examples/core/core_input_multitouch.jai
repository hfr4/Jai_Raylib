/* ******************************************************************************************
*
*   raylib [core] example - Input multitouch
*
*   Example originally created with raylib 2.1, last time updated with raylib 2.5
*
*   Example contributed by Berni (@Berni8k) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2024 Berni (@Berni8k) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_TOUCH_POINTS :: 10;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - input multitouch");

    touchPositions: [MAX_TOUCH_POINTS] Vector2;

    SetTargetFPS(60);


    while !WindowShouldClose() {

        // Get the touch point count ( how many fingers are touching the screen )
        tCount := GetTouchPointCount();
        // Clamp touch points available ( set the maximum touch points allowed )
        if (tCount > MAX_TOUCH_POINTS) tCount = MAX_TOUCH_POINTS;
        // Get touch points positions
        for i: 0..tCount - 1 touchPositions[i] = GetTouchPosition(xx i);

        BeginDrawing();

            ClearBackground(RAYWHITE);

            for i: 0..tCount - 1
            {
                // Make sure point is not (0, 0) as this means there is no touch for it
                if ((touchPositions[i].x > 0) && (touchPositions[i].y > 0))
                {
                    // Draw circle and touch index number
                    DrawCircleV(touchPositions[i], 34, ORANGE);
                    DrawText(TextFormat("%", i), cast(s32) touchPositions[i].x - 10, cast(s32) touchPositions[i].y - 70, 40, BLACK);
                }
            }

            DrawText("touch the screen at multiple locations to get multiple balls", 10, 10, 20, DARKGRAY);

        EndDrawing();
    }
    CloseWindow();
}