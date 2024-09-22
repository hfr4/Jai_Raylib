/* ******************************************************************************************
*
*   raylib [shaders] example - Julia sets
*
*   NOTE: This example requires raylib OpenGL 3.3 or ES2 versions for shaders support,
*         OpenGL 1.1 does not support shaders, recompile raylib to OpenGL 3.3 version.
*
*   NOTE: Shaders used in this example are #version 330 (OpenGL 3.3).
*
*   Example originally created with raylib 2.5, last time updated with raylib 4.0
*
*   Example contributed by Josh Colclough (@joshcol9232) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 Josh Colclough (@joshcol9232) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GLSL_VERSION :: 330;

// A few good julia sets
pointsOfInterest: [6][2] float = .[
    .[ -0.348827 , 0.607167 ],
    .[ -0.786268 , 0.169728 ],
    .[ -0.8      , 0.156    ],
    .[ 0.285     , 0.0      ],
    .[ -0.835    , -0.2321  ],
    .[ -0.70176  , -0.3842  ],
];

zoomSpeed := 1.01;
offsetSpeedMul := 2.0;

startingZoom := 0.75;


main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;


    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shaders] example - julia sets");

    // Load julia set shader
    // NOTE: Defining 0 (null) for vertex shader forces usage of internal default vertex shader
    shader := LoadShader(null, TextFormat("resources/shaders/glsl%/julia_set.fs", GLSL_VERSION));

    // Create a RenderTexture2D to be used for render to texture
    target := LoadRenderTexture(GetScreenWidth(), GetScreenHeight());

    // c constant to use in z^2 + c
    c: [2] float = .[ pointsOfInterest[0][0], pointsOfInterest[0][1] ];

    // Offset and zoom to draw the julia set at. (centered on screen and default size)
    offset: [2] float;
    zoom := startingZoom;

    // Get variable (uniform) locations on the shader to connect with the program
    // NOTE: If uniform variable could not be found in the shader, function returns -1
    cLoc      := GetShaderLocation(shader, "c");
    zoomLoc   := GetShaderLocation(shader, "zoom");
    offsetLoc := GetShaderLocation(shader, "offset");

    // Upload the shader uniform values!
    SetShaderValue(shader, cLoc     , *c     , xx ShaderUniformDataType.VEC2);
    SetShaderValue(shader, zoomLoc  , *zoom  , xx ShaderUniformDataType.FLOAT);
    SetShaderValue(shader, offsetLoc, *offset, xx ShaderUniformDataType.VEC2);

    incrementSpeed := 0;             // Multiplier of speed to change c value
    showControls := true;           // Show controls

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // Press [1 - 6] to reset c to a point of interest
        if (IsKeyPressed(xx KeyboardKey.ONE)   ||
            IsKeyPressed(xx KeyboardKey.TWO)   ||
            IsKeyPressed(xx KeyboardKey.THREE) ||
            IsKeyPressed(xx KeyboardKey.FOUR)  ||
            IsKeyPressed(xx KeyboardKey.FIVE)  ||
            IsKeyPressed(xx KeyboardKey.SIX))
        {
            if      (IsKeyPressed(xx KeyboardKey.ONE))  { c[0] = pointsOfInterest[0][0]; c[1] = pointsOfInterest[0][1]; }
            else if (IsKeyPressed(xx KeyboardKey.TWO))  { c[0] = pointsOfInterest[1][0]; c[1] = pointsOfInterest[1][1]; }
            else if (IsKeyPressed(xx KeyboardKey.THREE)){ c[0] = pointsOfInterest[2][0]; c[1] = pointsOfInterest[2][1]; }
            else if (IsKeyPressed(xx KeyboardKey.FOUR)) { c[0] = pointsOfInterest[3][0]; c[1] = pointsOfInterest[3][1]; }
            else if (IsKeyPressed(xx KeyboardKey.FIVE)) { c[0] = pointsOfInterest[4][0]; c[1] = pointsOfInterest[4][1]; }
            else if (IsKeyPressed(xx KeyboardKey.SIX))  { c[0] = pointsOfInterest[5][0]; c[1] = pointsOfInterest[5][1]; }

            SetShaderValue(shader, cLoc, *c, xx ShaderUniformDataType.VEC2);
        }

        // If "R" is pressed, reset zoom and offset.
        if (IsKeyPressed(xx KeyboardKey.R))
        {
            zoom      = startingZoom;
            offset[0] = 0.0;
            offset[1] = 0.0;
            SetShaderValue(shader, zoomLoc  , *zoom  , xx ShaderUniformDataType.FLOAT);
            SetShaderValue(shader, offsetLoc, *offset, xx ShaderUniformDataType.VEC2);
        }

        if (IsKeyPressed(xx KeyboardKey.SPACE)) incrementSpeed = 0;         // Pause animation (c change)
        if (IsKeyPressed(xx KeyboardKey.F1)) showControls = !showControls;  // Toggle whether or not to show controls

        if      (IsKeyPressed(xx KeyboardKey.RIGHT)) incrementSpeed += 1;
        else if (IsKeyPressed(xx KeyboardKey.LEFT))  incrementSpeed -= 1;

        // If either left or right button is pressed, zoom in/out.
        if (IsMouseButtonDown(xx MouseButton.LEFT) || IsMouseButtonDown(xx MouseButton.RIGHT))
        {
            // Change zoom. If Mouse left -> zoom in. Mouse right -> zoom out.
            zoom *= ifx IsMouseButtonDown(xx MouseButton.LEFT) then zoomSpeed else 1.0/zoomSpeed;

            mousePos := GetMousePosition();
            offsetVelocity: Vector2;
            // Find the velocity at which to change the camera. Take the distance of the mouse
            // from the center of the screen as the direction, and adjust magnitude based on
            // the current zoom.
            offsetVelocity.x = (mousePos.x/cast(float)SCREEN_WIDTH  - 0.5)*offsetSpeedMul/zoom;
            offsetVelocity.y = (mousePos.y/cast(float)SCREEN_HEIGHT - 0.5)*offsetSpeedMul/zoom;

            // Apply move velocity to camera
            offset[0] += GetFrameTime()*offsetVelocity.x;
            offset[1] += GetFrameTime()*offsetVelocity.y;

            // Update the shader uniform values!
            SetShaderValue(shader, zoomLoc  , *zoom  , xx ShaderUniformDataType.FLOAT);
            SetShaderValue(shader, offsetLoc, *offset, xx ShaderUniformDataType.VEC2);
        }

        // Increment c value with time
        dc := GetFrameTime()* cast(float)incrementSpeed*0.0005;
        c[0] += dc;
        c[1] += dc;
        SetShaderValue(shader, cLoc, *c, xx ShaderUniformDataType.VEC2);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        // Using a render texture to draw Julia set
        BeginTextureMode(target);       // Enable drawing to texture
            ClearBackground(BLACK);     // Clear the render texture

            // Draw a rectangle in shader mode to be used as shader canvas
            // NOTE: Rectangle uses font white character texture coordinates,
            // so shader can not be applied here directly because input vertexTexCoord
            // do not represent full screen coordinates (space where want to apply shader)
            DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), BLACK);
        EndTextureMode();

        BeginDrawing();
            ClearBackground(BLACK);     // Clear screen background

            // Draw the saved texture and rendered julia set with shader
            // NOTE: We do not invert texture on Y, already considered inside shader
            BeginShaderMode(shader);
                // WARNING: If xx ConfigFlags.WINDOW_HIGHDPI is enabled, HighDPI monitor scaling should be considered
                // when rendering the RenderTexture2D to fit in the HighDPI scaled Window
                DrawTextureEx(target.texture, .{ 0.0, 0.0 }, 0.0, 1.0, WHITE);
            EndShaderMode();

            if (showControls)
            {
                DrawText("Press Mouse buttons right/left to zoom in/out and move", 10, 15, 10, RAYWHITE);
                DrawText("Press KEY_F1 to toggle these controls"                 , 10, 30, 10, RAYWHITE);
                DrawText("Press KEYS [1 - 6] to change point of interest"        , 10, 45, 10, RAYWHITE);
                DrawText("Press KEY_LEFT | KEY_RIGHT to change speed"            , 10, 60, 10, RAYWHITE);
                DrawText("Press KEY_SPACE to stop movement animation"            , 10, 75, 10, RAYWHITE);
                DrawText("Press KEY_R to recenter the camera"                    , 10, 90, 10, RAYWHITE);
            }
        EndDrawing();
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    UnloadShader(shader);               // Unload shader
    UnloadRenderTexture(target);        // Unload render texture

    CloseWindow();                      // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

}
