/* ******************************************************************************************
*
*   raylib [shapes] example - Draw Textured Polygon
*
*   Example originally created with raylib 3.7, last time updated with raylib 3.7
*
*   Example contributed by Chris Camacho (@codifies) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2021-2024 Chris Camacho (@codifies) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_POINTS :: 11;      // 10 points and back to the start

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - textured polygon");

    // Define texture coordinates to map our texture to poly
     texcoords: [MAX_POINTS] Vector2 = .[
        .{ 0.75 , 0.0   },
        .{ 0.25 , 0.0   },
        .{ 0.0  , 0.5   },
        .{ 0.0  , 0.75  },
        .{ 0.25 , 1.0   },
        .{ 0.375, 0.875 },
        .{ 0.625, 0.875 },
        .{ 0.75 , 1.0   },
        .{ 1.0  , 0.75  },
        .{ 1.0  , 0.5   },
        .{ 0.75 , 0.0   }  // Close the poly
     ];

    // Define the base poly vertices from the UV's
    // NOTE: They can be specified in any other way
    points: [MAX_POINTS] Vector2;
    for i: 0..MAX_POINTS - 1
    {
        points[i].x = (texcoords[i].x - 0.5)*256.0;
        points[i].y = (texcoords[i].y - 0.5)*256.0;
    }

    // Define the vertices drawing position
    // NOTE: Initially same as points but updated every frame
    positions: [MAX_POINTS] Vector2;
    for i: 0..MAX_POINTS - 1 positions[i] = points[i];

    // Load texture to be mapped to poly
    texture := LoadTexture("resources/cat.png");

    angle := 0.0;             // Rotation angle (in degrees)

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // Update points rotation with an angle transform
        // NOTE: Base points position are not modified
        angle += 1;
        for i: 0..MAX_POINTS - 1 positions[i] = Vector2Rotate(points[i], xx (angle*DEG2RAD));

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText("textured polygon", 20, 20, 20, DARKGRAY);

            DrawTexturePoly(texture, .{ GetScreenWidth()/2.0, GetScreenHeight()/2.0 },
                            positions, texcoords, WHITE);

        EndDrawing();
    }
    UnloadTexture(texture); // Unload texture

    CloseWindow();
}

// Draw textured polygon, defined by vertex and texture coordinates
// NOTE: Polygon center must have straight line path to all points
// without crossing perimeter, points must be in anticlockwise order
DrawTexturePoly :: (texture: Texture2D , center: Vector2, points: [] Vector2, texcoords: [] Vector2, tint: Color)
{
    rlSetTexture(texture.id);

    // Texturing is only supported on RL_QUADS
    rlBegin(RL_QUADS);

        rlColor4ub(tint.r, tint.g, tint.b, tint.a);

        for i: 0..MAX_POINTS - 2
        {
            rlTexCoord2f(0.5, 0.5);
            rlVertex2f(center.x, center.y);

            rlTexCoord2f(texcoords[i].x, texcoords[i].y);
            rlVertex2f(points[i].x + center.x, points[i].y + center.y);

            rlTexCoord2f(texcoords[i + 1].x, texcoords[i + 1].y);
            rlVertex2f(points[i + 1].x + center.x, points[i + 1].y + center.y);

            rlTexCoord2f(texcoords[i + 1].x, texcoords[i + 1].y);
            rlVertex2f(points[i + 1].x + center.x, points[i + 1].y + center.y);
        }
    rlEnd();

    rlSetTexture(0);
}
