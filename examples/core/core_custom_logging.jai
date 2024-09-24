/* ******************************************************************************************
*
*   raylib [core] example - Custom logging
*
*   Example originally created with raylib 2.5, last time updated with raylib 2.5
*
*   Example contributed by Pablo Marcos Oltra (@pamarcos) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2024 Pablo Marcos Oltra (@pamarcos) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    // Set custom logger
    SetTraceLogCallback(CustomLog);

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - custom logging");

    SetTargetFPS(60);

    while !WindowShouldClose() {
        BeginDrawing();

        ClearBackground(RAYWHITE);

        DrawText("Check out the console output to see the custom logger in action!", 60, 200, 20, LIGHTGRAY);

        EndDrawing();
    }

    CloseWindow();
}

CustomLog :: (msgType: s32, text: *u8,  args: *void) #c_call {
    // timeStr: [64] u8;
    // now := get_time_milliseconds();
    // struct tm *tm_info := localtime(&now);

    // strftime(timeStr, sizeof(timeStr), "%Y-%m-%d %H:%M:%S", tm_info);
    // print("[%] ", timeStr);

    // if msgType == {
    //     case xx TraceLogLevel.INFO;    print("[INFO] : ");
    //     case xx TraceLogLevel.ERROR;   print("[ERROR]: ");
    //     case xx TraceLogLevel.WARNING; print("[WARN] : ");
    //     case xx TraceLogLevel.DEBUG;   print("[DEBUG]: ");
    // }

    // print(text, args);
    // printf("\n");
}
