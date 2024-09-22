/* ******************************************************************************************
*
*   raylib [textures] example - Draw part of the texture tiled
*
*   Example originally created with raylib 3.0, last time updated with raylib 4.2
*
*   Example contributed by Vlad Adrian (@demizdor) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2020-2024 Vlad Adrian (@demizdor) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

OPT_WIDTH    ::  220;       // Max width for the options container
MARGIN_SIZE  ::    8;       // Size for the margins
COLOR_SIZE   ::   16;       // Size of the color select buttons

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.WINDOW_RESIZABLE); // Make the window resizable
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - Draw part of a texture tiled");

    // NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
    texPattern := LoadTexture("resources/patterns.png");
    SetTextureFilter(texPattern, xx TextureFilter.TRILINEAR); // Makes the texture smoother when upscaled

    // Coordinates for all patterns inside the texture
    recPattern :: Rectangle.[
        .{ 3 , 3  , 66 , 66  },
        .{ 75, 3  , 100, 100 },
        .{ 3 , 75 , 66 , 66  },
        .{ 7 , 156, 50 , 50  },
        .{ 85, 106, 90 , 45  },
        .{ 75, 154, 100, 60  }
    ];

    // Setup colors
    COLORS :: Color.[ BLACK, MAROON, ORANGE, BLUE, PURPLE, BEIGE, LIME, RED, DARKGRAY, SKYBLUE ];
    MAX_COLORS :: COLORS.count;
    colorRec: [MAX_COLORS] Rectangle;

    // Calculate rectangle for each color
    x := 0;
    y := 0;
    for i: 0..MAX_COLORS - 1
    {
        colorRec[i].x      = xx (2.0 + MARGIN_SIZE + x);
        colorRec[i].y      = xx (22.0 + 256.0 + MARGIN_SIZE + y);
        colorRec[i].width  = COLOR_SIZE*2.0;
        colorRec[i].height = cast(float)COLOR_SIZE;

        if (i == (MAX_COLORS/2 - 1))
        {
            x = 0;
            y += COLOR_SIZE + MARGIN_SIZE;
        }
        else x += (COLOR_SIZE*2 + MARGIN_SIZE);
    }

    activePattern := 0;
    activeCol := 0;
    scale := 1.0;
    rotation := 0.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // Handle mouse
        if (IsMouseButtonPressed(xx MouseButton.LEFT))
        {
            mouse := GetMousePosition();

            // Check which pattern was clicked and set it as the active pattern
            for i: 0..recPattern.count - 1
            {
                if (CheckCollisionPointRec(mouse, .{ 2 + MARGIN_SIZE + recPattern[i].x, 40 + MARGIN_SIZE + recPattern[i].y, recPattern[i].width, recPattern[i].height }))
                {
                    activePattern = i;
                    break;
                }
            }

            // Check to see which color was clicked and set it as the active color
            for i: 0..MAX_COLORS - 1
            {
                if (CheckCollisionPointRec(mouse, colorRec[i]))
                {
                    activeCol = i;
                    break;
                }
            }
        }

        // Handle keys

        // Change scale
        if (IsKeyPressed(xx KeyboardKey.UP))   scale += 0.25;
        if (IsKeyPressed(xx KeyboardKey.DOWN)) scale -= 0.25;
        if      (scale > 10.0) scale = 10.0;
        else if (scale <= 0.0) scale = 0.25;

        // Change rotation
        if (IsKeyPressed(xx KeyboardKey.LEFT))  rotation -= 25.0;
        if (IsKeyPressed(xx KeyboardKey.RIGHT)) rotation += 25.0;

        // Reset
        if (IsKeyPressed(xx KeyboardKey.SPACE)) { rotation = 0.0; scale = 1.0; }


        BeginDrawing();
            ClearBackground(RAYWHITE);

            // Draw the tiled area
            DrawTextureTiled(texPattern, recPattern[activePattern], .{cast(float)OPT_WIDTH+MARGIN_SIZE, cast(float)MARGIN_SIZE, GetScreenWidth() - OPT_WIDTH - 2.0*MARGIN_SIZE, GetScreenHeight() - 2.0*MARGIN_SIZE},
                .{0.0, 0.0}, rotation, scale, COLORS[activeCol]);

            // Draw options
            DrawRectangle(MARGIN_SIZE, MARGIN_SIZE, OPT_WIDTH - MARGIN_SIZE, GetScreenHeight() - 2*MARGIN_SIZE, ColorAlpha(LIGHTGRAY, 0.5));

            DrawText("Select Pattern", 2 + MARGIN_SIZE, 30 + MARGIN_SIZE, 10, BLACK);
            DrawTexture(texPattern, 2 + MARGIN_SIZE, 40 + MARGIN_SIZE, BLACK);
            DrawRectangle(2 + MARGIN_SIZE + cast(s32)recPattern[activePattern].x, 40 + MARGIN_SIZE + cast(s32)recPattern[activePattern].y, cast(s32)recPattern[activePattern].width, cast(s32)recPattern[activePattern].height, ColorAlpha(DARKBLUE, 0.3));

            DrawText("Select Color", 2+MARGIN_SIZE, 10+256+MARGIN_SIZE, 10, BLACK);
            for i: 0..MAX_COLORS - 1
            {
                DrawRectangleRec(colorRec[i], COLORS[i]);
                if (activeCol == i) DrawRectangleLinesEx(colorRec[i], 3, ColorAlpha(WHITE, 0.5));
            }

            DrawText("Scale (UP/DOWN to change)", 2 + MARGIN_SIZE, 80 + 256 + MARGIN_SIZE, 10, BLACK);
            DrawText(TextFormat("%.2x", scale), 2 + MARGIN_SIZE, 92 + 256 + MARGIN_SIZE, 20, BLACK);

            DrawText("Rotation (LEFT/RIGHT to change)", 2 + MARGIN_SIZE, 122 + 256 + MARGIN_SIZE, 10, BLACK);
            DrawText(TextFormat("%.0 degrees", rotation), 2 + MARGIN_SIZE, 134 + 256 + MARGIN_SIZE, 20, BLACK);

            DrawText("Press [SPACE] to reset", 2 + MARGIN_SIZE, 164 + 256 + MARGIN_SIZE, 10, DARKBLUE);

            // Draw FPS
            DrawText(TextFormat("% FPS", GetFPS()), 2 + MARGIN_SIZE, 2 + MARGIN_SIZE, 20, BLACK);
        EndDrawing();
    }

    UnloadTexture(texPattern);        // Unload texture

    CloseWindow();
}

// Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
DrawTextureTiled :: (texture: Texture2D, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: float, scale: float, tint: Color)
{
    if ((texture.id <= 0)   || (scale <= 0.0))       return;  // Wanna see a infinite loop?!...just delete this line!
    if ((source.width == 0) || (source.height == 0)) return;

    tileWidth  := cast(s32)(source.width*scale);
    tileHeight := cast(s32)(source.height*scale);
    if ((xx dest.width < tileWidth) && (xx dest.height < tileHeight))
    {
        // Can fit only one tile
        DrawTexturePro(texture, .{source.x, source.y, (cast(float)dest.width/tileWidth)*source.width, (cast(float)dest.height/tileHeight)*source.height},
                    .{dest.x, dest.y, dest.width, dest.height}, origin, rotation, tint);
    }
    else if (xx dest.width <= tileWidth)
    {
        // Tiled vertically (one column)
        dy := 0;
        while dy + tileHeight < xx dest.height
        {
            DrawTexturePro(texture, .{source.x, source.y, (cast(float)dest.width/tileWidth)*source.width, source.height}, .{dest.x, dest.y + dy, dest.width, cast(float)tileHeight}, origin, rotation, tint);
            dy += tileHeight;
        }

        // Fit last tile
        if (dy < xx dest.height)
        {
            DrawTexturePro(texture, .{source.x, source.y, (cast(float)dest.width/tileWidth)*source.width, (cast(float)(dest.height - dy)/tileHeight)*source.height},
                        .{dest.x, dest.y + dy, dest.width, dest.height - dy}, origin, rotation, tint);
        }
    }
    else if (xx dest.height <= tileHeight)
    {
        // Tiled horizontally (one row)
        dx := 0;
        while dx+tileWidth < xx dest.width
        {
            DrawTexturePro(texture, .{source.x, source.y, source.width, (cast(float)dest.height/tileHeight)*source.height}, .{dest.x + dx, dest.y, cast(float)tileWidth, dest.height}, origin, rotation, tint);
            dx += tileWidth;
        }

        // Fit last tile
        if (dx < xx dest.width)
        {
            DrawTexturePro(texture, .{source.x, source.y, (cast(float)(dest.width - dx)/tileWidth)*source.width, (cast(float)dest.height/tileHeight)*source.height},
                        .{dest.x + dx, dest.y, dest.width - dx, dest.height}, origin, rotation, tint);
        }
    }
    else
    {
        // Tiled both horizontally and vertically (rows and columns)
        dx := 0;
        while dx+tileWidth < xx dest.width
        {
            dy := 0;
            while dy+tileHeight < xx dest.height
            {
                DrawTexturePro(texture, source, .{dest.x + dx, dest.y + dy, cast(float)tileWidth, cast(float)tileHeight}, origin, rotation, tint);
                dy += tileHeight;
            }

            if (dy < xx dest.height)
            {
                DrawTexturePro(texture, .{source.x, source.y, source.width, (cast(float)(dest.height - dy)/tileHeight)*source.height},
                    .{dest.x + dx, dest.y + dy, cast(float)tileWidth, dest.height - dy}, origin, rotation, tint);
            }
            dx += tileWidth;
        }

        // Fit last column of tiles
        if (dx < xx dest.width)
        {
            dy := 0;
            while dy+tileHeight < xx dest.height
            {
                DrawTexturePro(texture, .{source.x, source.y, (cast(float)(dest.width - dx)/tileWidth)*source.width, source.height},
                        .{dest.x + dx, dest.y + dy, dest.width - dx, cast(float)tileHeight}, origin, rotation, tint);
                dy += tileHeight;
            }

            // Draw final tile in the bottom right corner
            if (dy < xx dest.height)
            {
                DrawTexturePro(texture, .{source.x, source.y, (cast(float)(dest.width - dx)/tileWidth)*source.width, (cast(float)(dest.height - dy)/tileHeight)*source.height},
                    .{dest.x + dx, dest.y + dy, dest.width - dx, dest.height - dy}, origin, rotation, tint);
            }
        }
    }
}
