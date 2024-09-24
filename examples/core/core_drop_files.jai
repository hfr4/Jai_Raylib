/* ******************************************************************************************
*
*   raylib [core] example - Windows drop files
*
*   NOTE: This example only works on platforms that support drag & drop (Windows, Linux, OSX, Html5?)
*
*   Example originally created with raylib 1.3, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_FILEPATH_RECORDED ::  4096;
MAX_FILEPATH_SIZE     ::  2048;
filePaths: [MAX_FILEPATH_RECORDED] [MAX_FILEPATH_SIZE] u8; // We will register a maximum of filepaths

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - drop files");

    filePathCounter := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsFileDropped()) {
            droppedFiles := LoadDroppedFiles();

            for i: 0..droppedFiles.count - 1 {
                if (filePathCounter < (MAX_FILEPATH_RECORDED - 1)) {
                    TextCopy(*filePaths[filePathCounter][0], droppedFiles.paths[i]);

                    filePathCounter += 1;
                }
            }

            UnloadDroppedFiles(droppedFiles);
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (filePathCounter == 0) DrawText("Drop your files to this window!", 100, 40, 20, DARKGRAY);
            else
            {
                DrawText("Dropped files:", 100, 40, 20, DARKGRAY);

                for i: 0..filePathCounter - 1
                {
                    if (i%2 == 0) DrawRectangle(0, xx (85 + 40*i), SCREEN_WIDTH, 40, Fade(LIGHTGRAY, 0.5));
                    else          DrawRectangle(0, xx (85 + 40*i), SCREEN_WIDTH, 40, Fade(LIGHTGRAY, 0.3));

                    DrawText(filePaths[i].data, 120, xx (100 + 40*i), 10, GRAY);
                }

                DrawText("Drop new files...", 100, xx (110 + 40*filePathCounter), 20, DARKGRAY);
            }

        EndDrawing();
    }

    CloseWindow();
}