/* ******************************************************************************************
*
*   raylib [text] example - raylib fonts loading
*
*   NOTE: raylib is distributed with some free to use fonts (even for commercial pourposes!)
*         To view details and credits for those fonts, check raylib license file
*
*   Example originally created with raylib 1.7, last time updated with raylib 3.7
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_FONTS :: 8;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - raylib fonts");

    fonts: [MAX_FONTS] Font;
    fonts[0] = LoadFont("resources/fonts/alagard.png");
    fonts[1] = LoadFont("resources/fonts/pixelplay.png");
    fonts[2] = LoadFont("resources/fonts/mecha.png");
    fonts[3] = LoadFont("resources/fonts/setback.png");
    fonts[4] = LoadFont("resources/fonts/romulus.png");
    fonts[5] = LoadFont("resources/fonts/pixantiqua.png");
    fonts[6] = LoadFont("resources/fonts/alpha_beta.png");
    fonts[7] = LoadFont("resources/fonts/jupiter_crash.png");

    messages: [MAX_FONTS] string;
    messages[0] = "ALAGARD FONT designed by Hewett Tsoi";
    messages[1] = "PIXELPLAY FONT designed by Aleksander Shevchuk";
    messages[2] = "MECHA FONT designed by Captain Falcon";
    messages[3] = "SETBACK FONT designed by Brian Kent (AEnigma)";
    messages[4] = "ROMULUS FONT designed by Hewett Tsoi";
    messages[5] = "PIXANTIQUA FONT designed by Gerhard Grossmann";
    messages[6] = "ALPHA_BETA FONT designed by Brian Kent (AEnigma)";
    messages[7] = "JUPITER_CRASH FONT designed by Brian Kent (AEnigma)";

    spacings: [MAX_FONTS] int = .[ 2, 4, 8, 4, 3, 4, 4, 1 ];

    positions: [MAX_FONTS] Vector2;

    for i: 0..MAX_FONTS - 1 {
        positions[i].x = SCREEN_WIDTH/2.0 - MeasureTextEx(fonts[i], messages[i].data, fonts[i].baseSize*2.0, cast(float) spacings[i]).x/2.0;
        positions[i].y = 60.0 + fonts[i].baseSize + 45.0*i;
    }

    // Small Y position corrections
    positions[3].y += 8;
    positions[4].y += 2;
    positions[7].y -= 8;

    colors: [MAX_FONTS] Color = .[ MAROON, ORANGE, DARKGREEN, DARKBLUE, DARKPURPLE, LIME, GOLD, RED ];

    SetTargetFPS(60);

    while !WindowShouldClose() {

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("free fonts included with raylib", 250, 20, 20, DARKGRAY);
            DrawLine(220, 50, 590, 50, DARKGRAY);

            for i: 0..MAX_FONTS - 1
            {
                DrawTextEx(fonts[i], messages[i].data, positions[i], fonts[i].baseSize*2.0, cast(float) spacings[i], colors[i]);
            }

        EndDrawing();
    }

    for i: 0..MAX_FONTS - 1 UnloadFont(fonts[i]);

    CloseWindow();
}