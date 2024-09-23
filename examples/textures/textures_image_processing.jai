/* ******************************************************************************************
*
*   raylib [textures] example - Image processing
*
*   NOTE: Images are loaded in CPU memory (RAM); textures are loaded in GPU memory (VRAM)
*
*   Example originally created with raylib 1.4, last time updated with raylib 3.5
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2016-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

NUM_PROCESSES :: 9;

ImageProcess :: enum {
    NONE :: 0;
    COLOR_GRAYSCALE;
    COLOR_TINT;
    COLOR_INVERT;
    COLOR_CONTRAST;
    COLOR_BRIGHTNESS;
    GAUSSIAN_BLUR;
    FLIP_VERTICAL;
    FLIP_HORIZONTAL;
}

processText :: string.[
    "NO PROCESSING",
    "COLOR GRAYSCALE",
    "COLOR TINT",
    "COLOR INVERT",
    "COLOR CONTRAST",
    "COLOR BRIGHTNESS",
    "GAUSSIAN BLUR",
    "FLIP VERTICAL",
    "FLIP HORIZONTAL",
];

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - image processing");



    imOrigin := LoadImage("resources/parrots.png");
    ImageFormat(*imOrigin, xx PixelFormat.UNCOMPRESSED_R8G8B8A8);         // Format image to RGBA 32bit (required for texture update) <-- ISSUE
    texture := LoadTextureFromImage(imOrigin);

    imCopy := ImageCopy(imOrigin);

    currentProcess := ImageProcess.NONE;
    textureReload := false;

    toggleRecs: [NUM_PROCESSES] Rectangle;
    mouseHoverRec := -1;

    for i: 0..NUM_PROCESSES - 1 toggleRecs[i] = .{ 40.0, cast(float)(50 + 32*i), 150.0, 30.0 };

    SetTargetFPS(60);

    while !WindowShouldClose() {


        // Mouse toggle group logic
        for i: 0..NUM_PROCESSES - 1
        {
            if (CheckCollisionPointRec(GetMousePosition(), toggleRecs[i]))
            {
                mouseHoverRec = i;

                if (IsMouseButtonReleased(xx MouseButton.LEFT))
                {
                    currentProcess = xx i;
                    textureReload = true;
                }
                break;
            }
            else mouseHoverRec = -1;
        }

        // Keyboard toggle group logic
        if (IsKeyPressed(xx KeyboardKey.DOWN))
        {
            currentProcess += 1;
            if (currentProcess > (NUM_PROCESSES - 1)) currentProcess = xx 0;
            textureReload = true;
        }
        else if (IsKeyPressed(xx KeyboardKey.UP))
        {
            currentProcess -= 1;
            if (currentProcess < 0) currentProcess = xx 7;
            textureReload = true;
        }

        // Reload texture when required
        if (textureReload)
        {
            UnloadImage(imCopy);
            imCopy = ImageCopy(imOrigin);     // Restore image-copy from image-origin

            // NOTE: Image processing is a costly CPU process to be done every frame,
            // If image processing is required in a frame-basis, it should be done
            // with a texture and by shaders
            if currentProcess == {
                case .COLOR_GRAYSCALE;  ImageColorGrayscale(*imCopy);
                case .COLOR_TINT;       ImageColorTint(*imCopy, GREEN);
                case .COLOR_INVERT;     ImageColorInvert(*imCopy);
                case .COLOR_CONTRAST;   ImageColorContrast(*imCopy, -40);
                case .COLOR_BRIGHTNESS; ImageColorBrightness(*imCopy, -80);
                case .GAUSSIAN_BLUR;    ImageBlurGaussian(*imCopy, 10);
                case .FLIP_VERTICAL;    ImageFlipVertical(*imCopy);
                case .FLIP_HORIZONTAL;  ImageFlipHorizontal(*imCopy);
            }

            pixels := LoadImageColors(imCopy);    // Load pixel data from image (RGBA 32bit)
            UpdateTexture(texture, pixels);             // Update texture with new image data
            UnloadImageColors(pixels);

            textureReload = false;
        }

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("IMAGE PROCESSING:", 40, 30, 10, DARKGRAY);

            // Draw rectangles
            for i: 0..NUM_PROCESSES - 1
            {
                DrawRectangleRec(toggleRecs[i], ifx (xx i == currentProcess) || (i == mouseHoverRec) then SKYBLUE else LIGHTGRAY);
                DrawRectangleLines(
                    cast(s32) toggleRecs[i].x,
                    cast(s32) toggleRecs[i].y,
                    cast(s32) toggleRecs[i].width,
                    cast(s32) toggleRecs[i].height,
                    ifx (xx i == currentProcess) || (i == mouseHoverRec) then BLUE else GRAY
                );
                DrawText(
                    processText[i].data,
                    cast(s32)( toggleRecs[i].x + toggleRecs[i].width/2 - MeasureText(processText[i].data, 10)/2),
                    cast(s32)  toggleRecs[i].y + 11,
                    10,
                    ifx (xx i == currentProcess) || (i == mouseHoverRec) then DARKBLUE else DARKGRAY
                );
            }

            DrawTexture(texture, SCREEN_WIDTH - texture.width - 60, SCREEN_HEIGHT/2 - texture.height/2, WHITE);
            DrawRectangleLines(SCREEN_WIDTH - texture.width - 60, SCREEN_HEIGHT/2 - texture.height/2, texture.width, texture.height, BLACK);

        EndDrawing();
    }
    UnloadTexture(texture);
    UnloadImage(imOrigin);
    UnloadImage(imCopy);

    CloseWindow();
}