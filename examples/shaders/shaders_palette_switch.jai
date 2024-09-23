/* ******************************************************************************************
*
*   raylib [shaders] example - Color palette switch
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3), to test this example
*         on OpenGL ES 2.0 platforms (Android, Raspberry Pi, HTML5), use #version 100 shaders
*         raylib comes with shaders ready for both versions, check raylib/shaders install folder
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.7
*
*   Example contributed by Marco Lizza (@MarcoLizza) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 Marco Lizza (@MarcoLizza) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

MAX_PALETTES        ::    3;
COLORS_PER_PALETTE  ::    8;
VALUES_PER_COLOR    ::    3;

palettes : [MAX_PALETTES] [COLORS_PER_PALETTE*VALUES_PER_COLOR] int : .[
    .[   // 3-BIT RGB
        0  , 0  , 0  ,
        255, 0  , 0  ,
        0  , 255, 0  ,
        0  , 0  , 255,
        0  , 255, 255,
        255, 0  , 255,
        255, 255, 0  ,
        255, 255, 255,
    ],
    .[   // AMMO-8 (GameBoy-like)
        4  , 12 , 6  ,
        17 , 35 , 24 ,
        30 , 58 , 41 ,
        48 , 93 , 66 ,
        77 , 128, 97 ,
        137, 162, 87 ,
        190, 220, 127,
        238, 255, 204,
    ],
    .[   // RKBV (2-strip film)
        21 , 25 , 26 ,
        138, 76 , 88 ,
        217, 98 , 117,
        230, 184, 193,
        69 , 107, 115,
        75 , 151, 166,
        165, 189, 194,
        255, 245, 247,
    ]
];

paletteText :: string.[
    "3-BIT RGB",
    "AMMO-8 (GameBoy-like)",
    "RKBV (2-strip film)",
];


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - color palette switch");

    // Load shader to be used on some parts drawing
    // NOTE 1: Using GLSL 330 shader version, on OpenGL ES 2.0 use GLSL 100 shader version
    // NOTE 2: Defining 0 (null) for vertex shader forces usage of internal default vertex shader
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/palette_switch.fs", GLSL_VERSION));

    // Get variable (uniform) location on the shader to connect with the program
    // NOTE: If uniform variable could not be found in the shader, function returns -1
    paletteLoc := GetShaderLocation(shader, "palette");

    currentPalette: int;
    lineHeight := SCREEN_HEIGHT / COLORS_PER_PALETTE;

    SetTargetFPS(60);                       // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())            // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        if      (IsKeyPressed(xx KeyboardKey.RIGHT)) currentPalette += 1;
        else if (IsKeyPressed(xx KeyboardKey.LEFT))  currentPalette -= 1;

        if      (currentPalette >= MAX_PALETTES) currentPalette = 0;
        else if (currentPalette < 0)             currentPalette = MAX_PALETTES - 1;

        // Send new value to the shader to be used on drawing.
        // NOTE: We are sending RGB triplets w/o the alpha channel
        SetShaderValueV(shader, paletteLoc, *palettes[currentPalette], xx ShaderUniformDataType.IVEC3, COLORS_PER_PALETTE);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginShaderMode(shader);

                for i: 0..COLORS_PER_PALETTE - 1
                {
                    // Draw horizontal screen-wide rectangles with increasing "palette index"
                    // The used palette index is encoded in the RGB components of the pixel
                    DrawRectangle(0, xx (lineHeight*i), GetScreenWidth(), xx lineHeight, .{ xx i, xx i, xx i, 255 });
                }

            EndShaderMode();

            DrawText("< >"                           , 10, 10, 30, DARKBLUE);
            DrawText("CURRENT PALETTE:"              , 60, 15, 20, RAYWHITE);
            DrawText(paletteText[currentPalette].data, 300, 15, 20, RED);

            DrawFPS(700, 15);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);

    CloseWindow();}
