/* ******************************************************************************************
*
*   raylib [core] example - Storage save/load values
*
*   Example originally created with raylib 1.4, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

STORAGE_DATA_FILE :: "storage.data";   // Storage file

// NOTE: Storage positions must start with 0, directly related to file memory layout
StorageData :: enum {
    POSITION_SCORE   :: 0;
    POSITION_HISCORE :: 1;
}

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - storage save/load values");

    score : s32 = 0;
    hiscore : s32 = 0;
    framesCounter := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyPressed(xx KeyboardKey.R))
        {
            score   = GetRandomValue(1000, 2000);
            hiscore = GetRandomValue(2000, 4000);
        }

        if (IsKeyPressed(xx KeyboardKey.ENTER))
        {
            ok := SaveStorageValue(.POSITION_SCORE  , score);
            ok = SaveStorageValue(.POSITION_HISCORE, hiscore);
        }
        else if (IsKeyPressed(xx KeyboardKey.SPACE))
        {
            // NOTE: If requested position could not be found, value 0 is returned
            score   = LoadStorageValue(.POSITION_SCORE);
            hiscore = LoadStorageValue(.POSITION_HISCORE);
        }

        framesCounter+= 1;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText(TextFormat("SCORE: %"   , score)  , 280, 130, 40, MAROON);
            DrawText(TextFormat("HI-SCORE: %", hiscore), 210, 200, 50, BLACK);

            DrawText(TextFormat("frames: %", framesCounter), 10, 10, 20, LIME);

            DrawText("Press R to generate random numbers", 220, 40, 20, LIGHTGRAY);
            DrawText("Press ENTER to SAVE values", 250, 310, 20, LIGHTGRAY);
            DrawText("Press SPACE to LOAD values", 252, 350, 20, LIGHTGRAY);

        EndDrawing();
    }
    CloseWindow();
}

// Save integer value to storage file (to defined position)
// NOTE: Storage positions is directly related to file memory layout (4 bytes each integer)
SaveStorageValue :: (position: StorageData, value: s32) -> bool
{
    success := false;
    dataSize : s32 = 0;
    newDataSize := 0;
    fileData := LoadFileData(STORAGE_DATA_FILE, *dataSize);
    newFileData: *u8;

    if (fileData != null)
    {
        if (dataSize <= cast(s32)  (xx position * size_of(s32)))
        {
            // Increase data size up to position and store value
            newDataSize = cast(s32) ((xx position + 1) * size_of(s32)) ;
            realloc(newFileData, newDataSize, xx fileData);

            if (newFileData != null)
            {
                // RL_REALLOC succeded
                dataPtr := cast(*s32) newFileData;
                dataPtr[position] = value;
            }
            else
            {
                // RL_REALLOC failed
                TraceLog(xx TraceLogLevel.WARNING, "FILEIO: [%] Failed to realloc data (%), position in bytes (%) bigger than actual file size", STORAGE_DATA_FILE, dataSize, position*size_of(s32) );

                // We store the old size of the file
                newFileData = fileData;
                newDataSize = dataSize;
            }
        }
        else
        {
            // Store the old size of the file
            newFileData = fileData;
            newDataSize = dataSize;

            // Replace value on selected position
            dataPtr := cast(*s32)newFileData;
            dataPtr[xx position] = value;
        }

        success = SaveFileData(STORAGE_DATA_FILE, newFileData, xx newDataSize);
        free(newFileData);

        TraceLog(xx TraceLogLevel.INFO, "FILEIO: [%] Saved storage value: %", STORAGE_DATA_FILE, value);
    }
    else
    {
        TraceLog(xx TraceLogLevel.INFO, "FILEIO: [%] File created successfully", STORAGE_DATA_FILE);

        dataSize = cast(s32) ((xx position + 1) * size_of(s32)) ;
        fileData = cast(*u8) alloc(dataSize);
        dataPtr := cast(*s32) fileData;
        dataPtr[xx position] = value;

        success = SaveFileData(STORAGE_DATA_FILE, fileData, xx dataSize);
        UnloadFileData(fileData);

        TraceLog(xx TraceLogLevel.INFO, "FILEIO: [%] Saved storage value: %", STORAGE_DATA_FILE, value);
    }

    return success;
}

// Load integer value from storage file (from defined position)
// NOTE: If requested position could not be found, value 0 is returned
LoadStorageValue :: (position: StorageData) -> s32
{
    value : s32 = 0;
    dataSize : s32 = 0;
    fileData := LoadFileData(STORAGE_DATA_FILE, *dataSize);

    if (fileData != null)
    {
        if ( dataSize < cast(s32) (xx position*4))
            TraceLog(xx TraceLogLevel.WARNING, "FILEIO: [%] Failed to find storage position: %", STORAGE_DATA_FILE, position);
        else
        {
            dataPtr := cast(*s32)fileData;
            value = dataPtr[xx position];
        }

        UnloadFileData(fileData);

        TraceLog(xx TraceLogLevel.INFO, "FILEIO: [%] Loaded storage value: %", STORAGE_DATA_FILE, value);
    }

    return value;
}