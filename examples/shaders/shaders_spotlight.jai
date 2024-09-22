/* ******************************************************************************************
*
*   raylib [shaders] example - Simple shader mask
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.7
*
*   Example contributed by Chris Camacho (@chriscamacho) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 Chris Camacho (@chriscamacho) and Ramon Santamaria (@raysan5)
*
********************************************************************************************
*
*   The shader makes alpha holes in the forground to give the appearance of a top
*   down look at a spotlight casting a pool of light...
*
*   The right hand side of the screen there is just enough light to see whats
*   going on without the spot light, great for a stealth type game where you
*   have to avoid the spotlights.
*
*   The left hand side of the screen is in pitch dark except for where the spotlights are.
*
*   Although this example doesn't scale like the letterbox example, you could integrate
*   the two techniques, but by scaling the actual colour of the render texture rather
*   than using alpha as a mask.
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

GLSL_VERSION :: 330;

MAX_SPOTS  ::       3;        // NOTE: It must be the same as define in shader
MAX_STARS  ::     400;

// Spot data
Spot :: struct {
    position: Vector2;
    speed: Vector2;
    inner: float;
    radius: float;

    // Shader locations
    positionLoc: s32;
    innerLoc:    s32;
    radiusLoc:   s32;
}

// Stars in the star field have a position and velocity
Star :: struct {
    position: Vector2;
    speed: Vector2;
}

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - shader spotlight");
    HideCursor();

    texRay := LoadTexture("resources/raysan.png");

    stars: [MAX_STARS] Star;

    for n: 0..MAX_STARS - 1 ResetStar(*stars[n]);

    // Progress all the stars on, so they don't all start in the centre
    for m: 0..SCREEN_WIDTH/2 - 1
    {
        for n: 0..MAX_STARS - 1 UpdateStar(*stars[n]);
    }

    frameCounter := 0;

    // Use default vert shader
    shdrSpot := LoadShader(null, TextFormat("resources/shaders/glsl%/spotlight.fs", GLSL_VERSION));

    // Get the locations of spots in the shader
    spots: [MAX_SPOTS] Spot;

    for i: 0..MAX_SPOTS - 1
    {
        posName    := tprint("spots[%].pos"   , i);
        innerName  := tprint("spots[%].inner" , i);
        radiusName := tprint("spots[%].radius", i);

        spots[i].positionLoc = GetShaderLocation(shdrSpot, posName.data);
        spots[i].innerLoc    = GetShaderLocation(shdrSpot, innerName.data);
        spots[i].radiusLoc   = GetShaderLocation(shdrSpot, radiusName.data);
    }

    // Tell the shader how wide the screen is so we can have
    // a pitch black half and a dimly lit half.
    wLoc := GetShaderLocation(shdrSpot, "SCREEN_WIDTH");
    sw := cast(float) GetScreenWidth();
    SetShaderValue(shdrSpot, wLoc, *sw, xx ShaderUniformDataType.FLOAT);

    // Randomize the locations and velocities of the spotlights
    // and initialize the shader locations
    for i: 0..MAX_SPOTS - 1
    {
        spots[i].position.x = cast(float)GetRandomValue(64, SCREEN_WIDTH - 64);
        spots[i].position.y = cast(float)GetRandomValue(64, SCREEN_HEIGHT - 64);
        spots[i].speed      = .{ 0, 0 };

        while ((Math.abs(spots[i].speed.x) + Math.abs(spots[i].speed.y)) < 2)
        {
            spots[i].speed.x = GetRandomValue(-400, 40) / 10.0;
            spots[i].speed.y = GetRandomValue(-400, 40) / 10.0;
        }

        spots[i].inner  = 28.0 * (i + 1);
        spots[i].radius = 48.0 * (i + 1);

        SetShaderValue(shdrSpot, spots[i].positionLoc, *spots[i].position.x, xx ShaderUniformDataType.VEC2);
        SetShaderValue(shdrSpot, spots[i].innerLoc   , *spots[i].inner     , xx ShaderUniformDataType.FLOAT);
        SetShaderValue(shdrSpot, spots[i].radiusLoc  , *spots[i].radius    , xx ShaderUniformDataType.FLOAT);
    }

    SetTargetFPS(60);               // Set  to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        frameCounter += 1;

        // Move the stars, resetting them if the go offscreen
        for n: 0..MAX_STARS - 1 UpdateStar(*stars[n]);

        // Update the spots, send them to the shader
        for i: 0..MAX_SPOTS - 1 {
            if (i == 0)
            {
                mp := GetMousePosition();
                spots[i].position.x = mp.x;
                spots[i].position.y = SCREEN_HEIGHT - mp.y;
            }
            else
            {
                spots[i].position.x += spots[i].speed.x;
                spots[i].position.y += spots[i].speed.y;

                if (spots[i].position.x < 64)                   spots[i].speed.x = -spots[i].speed.x;
                if (spots[i].position.x > (SCREEN_WIDTH - 64))  spots[i].speed.x = -spots[i].speed.x;
                if (spots[i].position.y < 64)                   spots[i].speed.y = -spots[i].speed.y;
                if (spots[i].position.y > (SCREEN_HEIGHT - 64)) spots[i].speed.y = -spots[i].speed.y;
            }

            SetShaderValue(shdrSpot, spots[i].positionLoc, *spots[i].position.x, xx ShaderUniformDataType.VEC2);
        }

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(DARKBLUE);

            // Draw stars and bobs
            for n: 0..MAX_STARS - 1
            {
                // Single pixel is just too small these days!
                DrawRectangle( cast(s32) stars[n].position.x, cast(s32) stars[n].position.y, 2, 2, WHITE);
            }

            for i: 0..15
            {
                DrawTexture(texRay,
                    cast(s32)((SCREEN_WIDTH/2.0)  + Math.cos((frameCounter + i*8)/51.45)*(SCREEN_WIDTH/2.2) - 32),
                    cast(s32)((SCREEN_HEIGHT/2.0) + Math.sin((frameCounter + i*8)/17.87)*(SCREEN_HEIGHT/4.2)), WHITE);
            }

            // Draw spot lights
            BeginShaderMode(shdrSpot);
                // Instead of a blank rectangle you could render here
                // a render texture of the full screen used to do screen
                // scaling (slight adjustment to shader would be required
                // to actually pay attention to the colour!)
                DrawRectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, WHITE);
            EndShaderMode();

            DrawFPS(10, 10);

            DrawText("Move the mouse!", 10, 30, 20, GREEN);
            DrawText("Pitch Black"    , cast(s32)(SCREEN_WIDTH*0.2), SCREEN_HEIGHT/2, 20, GREEN);
            DrawText("Dark"           , cast(s32)(SCREEN_WIDTH*.66), SCREEN_HEIGHT/2, 20, GREEN);

        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadTexture(texRay);
    UnloadShader(shdrSpot);

    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------


}


ResetStar :: (s: *Star)
{
    s.position = .{ GetScreenWidth()/2.0, GetScreenHeight()/2.0 };

    s.speed.x = cast(float) GetRandomValue(-1000, 1000)/100.0;
    s.speed.y = cast(float) GetRandomValue(-1000, 1000)/100.0;

    while (!(Math.abs(s.speed.x) + Math.abs(s.speed.y) > 1)) {
        s.speed.x = cast(float) GetRandomValue(-1000, 1000)/100.0;
        s.speed.y = cast(float) GetRandomValue(-1000, 1000)/100.0;
    }

    s.position = Vector2Add(s.position, Vector2Multiply(s.speed, .{ 8.0, 8.0 }));
}

UpdateStar :: (s: *Star)
{
    s.position = Vector2Add(s.position, s.speed);

    if ((s.position.x < 0) || (s.position.x > xx GetScreenWidth()) ||
        (s.position.y < 0) || (s.position.y > xx GetScreenHeight()))
    {
        ResetStar(s);
    }
}


