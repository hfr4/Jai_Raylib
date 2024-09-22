/* ******************************************************************************************
*
*   raylib [textures] example - Draw a texture along a segmented curve
*
*   Example originally created with raylib 4.5, last time updated with raylib 4.5
*
*   Example contributed by Jeffery Myers and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022-2024 Jeffery Myers and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

texRoad: Texture;

showCurve := false;

curveWidth := 50.0;
curveSegments := 24;

curveStartPosition: Vector2;
curveStartPositionTangent: Vector2;

curveEndPosition: Vector2;
curveEndPositionTangent: Vector2;

curveSelectedPoint: *Vector2;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx (ConfigFlags.MSAA_4X_HINT | ConfigFlags.VSYNC_HINT));
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] examples - textured curve");

    // Load the road texture
    texRoad = LoadTexture("resources/road.png");
    SetTextureFilter(texRoad, xx TextureFilter.BILINEAR);

    // Setup the curve
    curveStartPosition = .{ 80, 100 };
    curveStartPositionTangent = .{ 100, 300 };

    curveEndPosition = .{ 700, 350 };
    curveEndPositionTangent = .{ 600, 100 };

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // Curve config options
        if (IsKeyPressed(xx KeyboardKey.SPACE)) showCurve = !showCurve;
        if (IsKeyPressed(xx KeyboardKey.EQUAL)) curveWidth += 2;
        if (IsKeyPressed(xx KeyboardKey.MINUS)) curveWidth -= 2;
        if (curveWidth < 2) curveWidth = 2;

        // Update segments
        if (IsKeyPressed(xx KeyboardKey.LEFT)) curveSegments -= 2;
        if (IsKeyPressed(xx KeyboardKey.RIGHT)) curveSegments += 2;

        if (curveSegments < 2) curveSegments = 2;

        // Update curve logic
        // If the mouse is not down, we are not editing the curve so clear the selection
        if (!IsMouseButtonDown(xx MouseButton.LEFT))  curveSelectedPoint = null;

        // If a point was selected, move it
        if (curveSelectedPoint) curveSelectedPoint.* = Vector2Add(curveSelectedPoint, GetMouseDelta());


        // The mouse is down, and nothing was selected, so see if anything was picked
        mouse := GetMousePosition();
        if      (CheckCollisionPointCircle(mouse, curveStartPosition       , 6)) curveSelectedPoint = *curveStartPosition;
        else if (CheckCollisionPointCircle(mouse, curveStartPositionTangent, 6)) curveSelectedPoint = *curveStartPositionTangent;
        else if (CheckCollisionPointCircle(mouse, curveEndPosition         , 6)) curveSelectedPoint = *curveEndPosition;
        else if (CheckCollisionPointCircle(mouse, curveEndPositionTangent  , 6)) curveSelectedPoint = *curveEndPositionTangent;


        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawTexturedCurve();    // Draw a textured Spline Cubic Bezier

            // Draw spline for reference
            if (showCurve) DrawSplineSegmentBezierCubic(curveStartPosition, curveEndPosition, curveStartPositionTangent, curveEndPositionTangent, 2, BLUE);

            // Draw the various control points and highlight where the mouse is
            DrawLineV(curveStartPosition       , curveStartPositionTangent, SKYBLUE);
            DrawLineV(curveStartPositionTangent, curveEndPositionTangent  , Fade(LIGHTGRAY, 0.4));
            DrawLineV(curveEndPosition         , curveEndPositionTangent  , PURPLE);

            if (CheckCollisionPointCircle(mouse, curveStartPosition, 6)) DrawCircleV(curveStartPosition, 7, YELLOW);
            DrawCircleV(curveStartPosition, 5, RED);

            if (CheckCollisionPointCircle(mouse, curveStartPositionTangent, 6)) DrawCircleV(curveStartPositionTangent, 7, YELLOW);
            DrawCircleV(curveStartPositionTangent, 5, MAROON);

            if (CheckCollisionPointCircle(mouse, curveEndPosition, 6)) DrawCircleV(curveEndPosition, 7, YELLOW);
            DrawCircleV(curveEndPosition, 5, GREEN);

            if (CheckCollisionPointCircle(mouse, curveEndPositionTangent, 6)) DrawCircleV(curveEndPositionTangent, 7, YELLOW);
            DrawCircleV(curveEndPositionTangent, 5, DARKGREEN);

            // Draw usage info
            DrawText("Drag points to move curve, press SPACE to show/hide base curve", 10, 10, 10, DARKGRAY);
            DrawText(TextFormat("Curve width: % (Use + and - to adjust)", curveWidth), 10, 30, 10, DARKGRAY);
            DrawText(TextFormat("Curve segments: % (Use LEFT and RIGHT to adjust)", curveSegments), 10, 50, 10, DARKGRAY);

        EndDrawing();
    }

    UnloadTexture(texRoad);

    CloseWindow();
}


// Module Functions Definition


// Draw textured curve using Spline Cubic Bezier
DrawTexturedCurve :: () {
    step := 1.0 / curveSegments;

    previous := curveStartPosition;
    previousTangent: Vector2;
    previousV := 0.0;

    // We can't compute a tangent for the first point, so we need to reuse the tangent from the first segment
    tangentSet := false;

    current: Vector2;
    t := 0.0;

    for i: 0..curveSegments - 1
    {
        t = step * cast(float)i;

        a := Math.pow(1.0 - t, 3);
        b := 3.0*Math.pow(1.0 - t, 2)*t;
        c := 3.0*(1.0 - t)*Math.pow(t, 2);
        d := Math.pow(t, 3);

        // Compute the endpoint for this segment
        current.y = a*curveStartPosition.y + b*curveStartPositionTangent.y + c*curveEndPositionTangent.y + d*curveEndPosition.y;
        current.x = a*curveStartPosition.x + b*curveStartPositionTangent.x + c*curveEndPositionTangent.x + d*curveEndPosition.x;

        // Vector from previous to current
        delta := Vector2.{ current.x - previous.x, current.y - previous.y };

        // The right hand normal to the delta vector
        normal := Vector2Normalize(.{ -delta.y, delta.x });

        // The v texture coordinate of the segment (add up the length of all the segments so far)
        v := previousV + Vector2Length(delta);

        // Make sure the start point has a normal
        if (!tangentSet)
        {
            previousTangent = normal;
            tangentSet = true;
        }

        // Extend out the normals from the previous and current points to get the quad for this segment
        prevPosNormal := Vector2Add(previous, Vector2Scale(previousTangent,  curveWidth));
        prevNegNormal := Vector2Add(previous, Vector2Scale(previousTangent, -curveWidth));

        currentPosNormal := Vector2Add(current, Vector2Scale(normal,  curveWidth));
        currentNegNormal := Vector2Add(current, Vector2Scale(normal, -curveWidth));

        // Draw the segment as a quad
        rlSetTexture(texRoad.id);
        rlBegin(RL_QUADS);
            rlColor4ub(255,255,255,255);
            rlNormal3f(0.0, 0.0, 1.0);

            rlTexCoord2f(0, previousV);
            rlVertex2f(prevNegNormal.x, prevNegNormal.y);

            rlTexCoord2f(1, previousV);
            rlVertex2f(prevPosNormal.x, prevPosNormal.y);

            rlTexCoord2f(1, v);
            rlVertex2f(currentPosNormal.x, currentPosNormal.y);

            rlTexCoord2f(0, v);
            rlVertex2f(currentNegNormal.x, currentNegNormal.y);
        rlEnd();

        // The current step is the start of the next step
        previous        = current;
        previousTangent = normal;
        previousV       = v;
    }
}

