/* ******************************************************************************************
*
*   raylib [textures] example - Procedural images generation
*
*   Example originally created with raylib 1.8, last time updated with raylib 1.8
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2O17-2024 Wilhem Barbier (@nounoursheureux) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

NUM_TEXTURES :: 9;      // Currently we have 8 generation algorithms but some have multiple purposes (Linear and Square Gradients)

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - procedural images generation");

    verticalGradient   := GenImageGradientLinear(SCREEN_WIDTH, SCREEN_HEIGHT, 0 , RED, BLUE);
    horizontalGradient := GenImageGradientLinear(SCREEN_WIDTH, SCREEN_HEIGHT, 90, RED, BLUE);
    diagonalGradient   := GenImageGradientLinear(SCREEN_WIDTH, SCREEN_HEIGHT, 45, RED, BLUE);
    radialGradient     := GenImageGradientRadial(SCREEN_WIDTH, SCREEN_HEIGHT, 0.0, WHITE, BLACK);
    squareGradient     := GenImageGradientSquare(SCREEN_WIDTH, SCREEN_HEIGHT, 0.0, WHITE, BLACK);
    checked            := GenImageChecked       (SCREEN_WIDTH, SCREEN_HEIGHT, 32, 32, RED, BLUE);
    whiteNoise         := GenImageWhiteNoise    (SCREEN_WIDTH, SCREEN_HEIGHT, 0.5);
    perlinNoise        := GenImagePerlinNoise   (SCREEN_WIDTH, SCREEN_HEIGHT, 50, 50, 4.0);
    cellular           := GenImageCellular      (SCREEN_WIDTH, SCREEN_HEIGHT, 32);

    textures: [NUM_TEXTURES] Texture2D;

    textures[0] = LoadTextureFromImage(verticalGradient);
    textures[1] = LoadTextureFromImage(horizontalGradient);
    textures[2] = LoadTextureFromImage(diagonalGradient);
    textures[3] = LoadTextureFromImage(radialGradient);
    textures[4] = LoadTextureFromImage(squareGradient);
    textures[5] = LoadTextureFromImage(checked);
    textures[6] = LoadTextureFromImage(whiteNoise);
    textures[7] = LoadTextureFromImage(perlinNoise);
    textures[8] = LoadTextureFromImage(cellular);


    UnloadImage(verticalGradient);
    UnloadImage(horizontalGradient);
    UnloadImage(diagonalGradient);
    UnloadImage(radialGradient);
    UnloadImage(squareGradient);
    UnloadImage(checked);
    UnloadImage(whiteNoise);
    UnloadImage(perlinNoise);
    UnloadImage(cellular);

    currentTexture := 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsMouseButtonPressed(xx MouseButton.LEFT) || IsKeyPressed(xx KeyboardKey.RIGHT)) {
            currentTexture = (currentTexture + 1) % NUM_TEXTURES; // Cycle between the textures
        }
        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexture(textures[currentTexture], 0, 0, WHITE);

            DrawRectangle(30, 400, 325, 30, Fade(SKYBLUE, 0.5));
            DrawRectangleLines(30, 400, 325, 30, Fade(WHITE, 0.5));
            DrawText("MOUSE LEFT BUTTON to CYCLE PROCEDURAL TEXTURES", 40, 410, 10, WHITE);

            if currentTexture == {
                case 0; DrawText("VERTICAL GRADIENT"  , 560, 10, 20, RAYWHITE);
                case 1; DrawText("HORIZONTAL GRADIENT", 540, 10, 20, RAYWHITE);
                case 2; DrawText("DIAGONAL GRADIENT"  , 540, 10, 20, RAYWHITE);
                case 3; DrawText("RADIAL GRADIENT"    , 580, 10, 20, LIGHTGRAY);
                case 4; DrawText("SQUARE GRADIENT"    , 580, 10, 20, LIGHTGRAY);
                case 5; DrawText("CHECKED"            , 680, 10, 20, RAYWHITE);
                case 6; DrawText("WHITE NOISE"        , 640, 10, 20, RED);
                case 7; DrawText("PERLIN NOISE"       , 640, 10, 20, RED);
                case 8; DrawText("CELLULAR"           , 670, 10, 20, RAYWHITE);
            }

        EndDrawing();
    }


    for i: 0..NUM_TEXTURES - 1 UnloadTexture(textures[i]);

    CloseWindow();
}