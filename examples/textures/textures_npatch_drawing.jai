/* ******************************************************************************************
*
*   raylib [textures] example - N-patch drawing
*
*   NOTE: Images are loaded in CPU memory (RAM); textures are loaded in GPU memory (VRAM)
*
*   Example originally created with raylib 2.0, last time updated with raylib 2.5
*
*   Example contributed by Jorge A. Gomes (@overdev) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2024 Jorge A. Gomes (@overdev) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - N-patch drawing");

    nPatchTexture := LoadTexture("resources/ninepatch_button.png");

    mousePosition: Vector2;
    origin: Vector2;

    // Position and size of the n-patches
    dstRec1 := Rectangle.{ 480.0, 160.0, 32.0, 32.0 };
    dstRec2 := Rectangle.{ 160.0, 160.0, 32.0, 32.0 };
    dstRecH := Rectangle.{ 160.0, 93.0 , 32.0, 32.0 };
    dstRecV := Rectangle.{ 92.0 , 160.0, 32.0, 32.0 };

    // A 9-patch (NPATCH_NINE_PATCH) changes its sizes in both axis
    ninePatchInfo1 := NPatchInfo.{ .{ 0.0, 0.0  , 64.0, 64.0 }, 12, 40, 12, 12, xx NPatchLayout.NINE_PATCH };
    ninePatchInfo2 := NPatchInfo.{ .{ 0.0, 128.0, 64.0, 64.0 }, 16, 16, 16, 16, xx NPatchLayout.NINE_PATCH };

    // A horizontal 3-patch (NPATCH_THREE_PATCH_HORIZONTAL) changes its sizes along the x axis only
    h3PatchInfo := NPatchInfo.{ .{ 0.0,  64.0, 64.0, 64.0 }, 8, 8, 8, 8, xx NPatchLayout.THREE_PATCH_HORIZONTAL };

    // A vertical 3-patch (NPATCH_THREE_PATCH_VERTICAL) changes its sizes along the y axis only
    v3PatchInfo := NPatchInfo.{ .{ 0.0, 192.0, 64.0, 64.0 }, 6, 6, 6, 6, xx NPatchLayout.THREE_PATCH_VERTICAL };

    SetTargetFPS(60);

    while !WindowShouldClose() {

        mousePosition = GetMousePosition();

        // Resize the n-patches based on mouse position
        dstRec1.width  = mousePosition.x - dstRec1.x;
        dstRec1.height = mousePosition.y - dstRec1.y;
        dstRec2.width  = mousePosition.x - dstRec2.x;
        dstRec2.height = mousePosition.y - dstRec2.y;
        dstRecH.width  = mousePosition.x - dstRecH.x;
        dstRecV.height = mousePosition.y - dstRecV.y;

        // Set a minimum width and/or height
        if (dstRec1.width  < 1.0)   dstRec1.width  = 1.0;
        if (dstRec1.width  > 300.0) dstRec1.width  = 300.0;
        if (dstRec1.height < 1.0)   dstRec1.height = 1.0;
        if (dstRec2.width  < 1.0)   dstRec2.width  = 1.0;
        if (dstRec2.width  > 300.0) dstRec2.width  = 300.0;
        if (dstRec2.height < 1.0)   dstRec2.height = 1.0;
        if (dstRecH.width  < 1.0)   dstRecH.width  = 1.0;
        if (dstRecV.height < 1.0)   dstRecV.height = 1.0;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            // Draw the n-patches
            DrawTextureNPatch(nPatchTexture, ninePatchInfo2, dstRec2, origin, 0.0, WHITE);
            DrawTextureNPatch(nPatchTexture, ninePatchInfo1, dstRec1, origin, 0.0, WHITE);
            DrawTextureNPatch(nPatchTexture, h3PatchInfo   , dstRecH, origin, 0.0, WHITE);
            DrawTextureNPatch(nPatchTexture, v3PatchInfo   , dstRecV, origin, 0.0, WHITE);

            // Draw the source texture
            DrawRectangleLines(5, 88, 74, 266, BLUE);
            DrawTexture(nPatchTexture, 10, 93, WHITE);
            DrawText("TEXTURE", 15, 360, 10, DARKGRAY);

            DrawText("Move the mouse to stretch or shrink the n-patches", 10, 20, 20, DARKGRAY);

        EndDrawing();
    }

    UnloadTexture(nPatchTexture);

    CloseWindow();
}