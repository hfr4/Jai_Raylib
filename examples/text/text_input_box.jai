/* ******************************************************************************************
*
*   raylib [text] example - Input Box
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

MAX_INPUT_CHARS :: 9;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - input box");

    name: [MAX_INPUT_CHARS + 1] u8;      // NOTE: One extra space required for null terminator char '\0'
    letterCount := 0;

    textBox := Rectangle.{ SCREEN_WIDTH/2.0 - 100, 180, 225, 50 };
    mouseOnText := false;

    framesCounter := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (CheckCollisionPointRec(GetMousePosition(), textBox)) mouseOnText = true;
        else mouseOnText = false;

        if (mouseOnText)
        {
            // Set the window's cursor to the I-Beam
            SetMouseCursor(xx MouseCursor.IBEAM);

            // Get char pressed (unicode character) on the queue
            key := GetCharPressed();

            // Check if more characters have been pressed on the same frame
            while (key > 0)
            {
                // NOTE: Only allow keys in range [32..125]
                if ((key >= 32) && (key <= 125) && (letterCount < MAX_INPUT_CHARS))
                {
                    name[letterCount]   = cast(u8) key;
                    name[letterCount+1] = #char "\0"; // Add null terminator at the end of the string.
                    letterCount += 1;
                }

                key = GetCharPressed();  // Check next character in the queue
            }

            if (IsKeyPressed(xx KeyboardKey.BACKSPACE))
            {
                letterCount -= 1;
                if (letterCount < 0) letterCount = 0;
                name[letterCount] = #char "\0";
            }
        }
        else SetMouseCursor(xx MouseCursor.DEFAULT);

        if (mouseOnText) framesCounter += 1;
        else framesCounter = 0;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("PLACE MOUSE OVER INPUT BOX!", 240, 140, 20, GRAY);

            DrawRectangleRec(textBox, LIGHTGRAY);
            if (mouseOnText) DrawRectangleLines(cast(s32)textBox.x, cast(s32)textBox.y, cast(s32)textBox.width, cast(s32)textBox.height, RED);
            else             DrawRectangleLines(cast(s32)textBox.x, cast(s32)textBox.y, cast(s32)textBox.width, cast(s32)textBox.height, DARKGRAY);

            DrawText(name.data, cast(s32)textBox.x + 5, cast(s32)textBox.y + 8, 40, MAROON);

            DrawText(TextFormat("INPUT CHARS: %/%", letterCount, MAX_INPUT_CHARS), 315, 250, 20, DARKGRAY);

            if (mouseOnText)
            {
                if (letterCount < MAX_INPUT_CHARS)
                {
                    // Draw blinking underscore char
                    if (((framesCounter/20)%2) == 0) DrawText("_", cast(s32)textBox.x + 8 + MeasureText(name.data, 40), cast(s32)textBox.y + 12, 40, MAROON);
                }
                else DrawText("Press BACKSPACE to delete chars...", 230, 300, 20, GRAY);
            }

        EndDrawing();
    }
    CloseWindow();
}

// Check if any key is pressed
// NOTE: We limit keys check to keys between 32 (xx KeyboardKey.SPACE) and 126
IsAnyKeyPressed :: () -> bool {
    keyPressed := false;
    key := GetKeyPressed();

    if ((key >= 32) && (key <= 126)) keyPressed = true;

    return keyPressed;
}
