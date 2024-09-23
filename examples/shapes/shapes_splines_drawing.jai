/* ******************************************************************************************
*
*   raylib [shapes] example - splines drawing
*
*   Example originally created with raylib 5.0, last time updated with raylib 5.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_SPLINE_POINTS  ::    32;

// Cubic Bezier spline control points
// NOTE: Every segment has two control points
ControlPoint :: struct {
    start: Vector2;
    end:   Vector2;
}

// Spline types
SplineType :: enum {
    LINEAR;           // Linear
    BASIS;            // B-Spline
    CATMULLROM;       // Catmull-Rom
    BEZIER;           // Cubic Bezier
}

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    SetConfigFlags(xx ConfigFlags.MSAA_4X_HINT);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - splines drawing");

    points: [MAX_SPLINE_POINTS] Vector2;
    points[0] = .{  50.0, 400.0 };
    points[1] = .{ 160.0, 220.0 };
    points[2] = .{ 340.0, 380.0 };
    points[3] = .{ 520.0, 60.0  };
    points[4] = .{ 710.0, 260.0 };

    // Array required for spline bezier-cubic,
    // including control points interleaved with start-end segment points
    pointsInterleaved: [3*(MAX_SPLINE_POINTS - 1) + 1] Vector2;

    pointCount := 5;
    selectedPoint := -1;
    focusedPoint := -1;
    selectedControlPoint: *Vector2;
    focusedControlPoint:  *Vector2;

    // Cubic Bezier control points initialization
    control: [MAX_SPLINE_POINTS-1] ControlPoint;
    for i: 0..pointCount - 2
    {
        control[i].start = .{ points[i].x     + 50, points[i].y     };
        control[i].end   = .{ points[i + 1].x - 50, points[i + 1].y };
    }

    // Spline config variables
    splineThickness := 8.0;
    splineTypeActive := SplineType.LINEAR; // 0-Linear, 1-BSpline, 2-CatmullRom, 3-Bezier
    splineTypeEditMode := false;
    splineHelpersActive := true;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // Spline points creation logic (at the end of spline)
        if (IsMouseButtonPressed(xx MouseButton.RIGHT) && (pointCount < MAX_SPLINE_POINTS))
        {
            points[pointCount] = GetMousePosition();
            i := pointCount - 1;
            control[i].start = .{ points[i].x     + 50, points[i].y     };
            control[i].end   = .{ points[i + 1].x - 50, points[i + 1].y };
            pointCount+= 1;
        }

        // Spline point focus and selection logic
        for i: 0..pointCount - 1
        {
            if (CheckCollisionPointCircle(GetMousePosition(), points[i], 8.0))
            {
                focusedPoint = i;
                if (IsMouseButtonDown(xx MouseButton.LEFT)) selectedPoint = i;
                break;
            }
            else focusedPoint = -1;
        }

        // Spline point movement logic
        if (selectedPoint >= 0)
        {
            points[selectedPoint] = GetMousePosition();
            if (IsMouseButtonReleased(xx MouseButton.LEFT)) selectedPoint = -1;
        }

        // Cubic Bezier spline control points logic
        if ((splineTypeActive == .BEZIER) && (focusedPoint == -1))
        {
            // Spline control point focus and selection logic
            for i:0..pointCount - 2
            {
                if (CheckCollisionPointCircle(GetMousePosition(), control[i].start, 6.0))
                {
                    focusedControlPoint = *control[i].start;
                    if (IsMouseButtonDown(xx MouseButton.LEFT)) selectedControlPoint = *control[i].start;
                    break;
                }
                else if (CheckCollisionPointCircle(GetMousePosition(), control[i].end, 6.0))
                {
                    focusedControlPoint = *control[i].end;
                    if (IsMouseButtonDown(xx MouseButton.LEFT)) selectedControlPoint = *control[i].end;
                    break;
                }
                else focusedControlPoint = null;
            }

            // Spline control point movement logic
            if (selectedControlPoint != null)
            {
                selectedControlPoint.* = GetMousePosition();
                if (IsMouseButtonReleased(xx MouseButton.LEFT)) selectedControlPoint = null;
            }
        }

        // Spline selection logic
        if      (IsKeyPressed(xx KeyboardKey.ONE))   splineTypeActive = .LINEAR;
        else if (IsKeyPressed(xx KeyboardKey.TWO))   splineTypeActive = .BASIS;
        else if (IsKeyPressed(xx KeyboardKey.THREE)) splineTypeActive = .CATMULLROM;
        else if (IsKeyPressed(xx KeyboardKey.FOUR))  splineTypeActive = .BEZIER;

        BeginDrawing();

            ClearBackground(RAYWHITE);

            if (splineTypeActive == .LINEAR)
            {
                // Draw spline: linear
                DrawSplineLinear(points.data, xx pointCount, splineThickness, RED);
            }
            else if (splineTypeActive == .BASIS)
            {
                // Draw spline: basis
                DrawSplineBasis(points.data, xx pointCount, splineThickness, RED);  // Provide connected points array

                /*
                for (i := 0; i < (pointCount - 3); i+= 1)
                {
                    // Drawing individual segments, not considering thickness connection compensation
                    DrawSplineSegmentBasis(points[i], points[i + 1], points[i + 2], points[i + 3], splineThickness, MAROON);
                }
                */
            }
            else if (splineTypeActive == .CATMULLROM)
            {
                // Draw spline: catmull-rom
                DrawSplineCatmullRom(points.data, xx pointCount, splineThickness, RED); // Provide connected points array

                /*
                for (i := 0; i < (pointCount - 3); i+= 1)
                {
                    // Drawing individual segments, not considering thickness connection compensation
                    DrawSplineSegmentCatmullRom(points[i], points[i + 1], points[i + 2], points[i + 3], splineThickness, MAROON);
                }
                */
            }
            else if (splineTypeActive == .BEZIER)
            {
                // NOTE: Cubic-bezier spline requires the 2 control points of each segnment to be
                // provided interleaved with the start and end point of every segment
                for i: 0..pointCount - 2
                {
                    pointsInterleaved[3*i]     = points[i];
                    pointsInterleaved[3*i + 1] = control[i].start;
                    pointsInterleaved[3*i + 2] = control[i].end;
                }

                pointsInterleaved[3*(pointCount - 1)] = points[pointCount - 1];

                // Draw spline: cubic-bezier (with control points)
                DrawSplineBezierCubic(pointsInterleaved.data, xx (3*(pointCount - 1)), splineThickness, RED);

                /*
                for (i := 0; i < 3*(pointCount - 1); i += 3)
                {
                    // Drawing individual segments, not considering thickness connection compensation
                    DrawSplineSegmentBezierCubic(pointsInterleaved[i], pointsInterleaved[i + 1], pointsInterleaved[i + 2], pointsInterleaved[i + 3], splineThickness, MAROON);
                }
                */

                // Draw spline control points
                for i: 0..pointCount - 2
                {
                    // Every cubic bezier point have two control points
                    DrawCircleV(control[i].start, 6, GOLD);
                    DrawCircleV(control[i].end  , 6, GOLD);
                    if      (focusedControlPoint == *control[i].start) DrawCircleV(control[i].start, 8, GREEN);
                    else if (focusedControlPoint == *control[i].end)   DrawCircleV(control[i].end  , 8, GREEN);
                    DrawLineEx(points[i]    , control[i].start, 1.0, LIGHTGRAY);
                    DrawLineEx(points[i + 1], control[i].end  , 1.0, LIGHTGRAY);

                    // Draw spline control lines
                    DrawLineV(points[i], control[i].start, GRAY);
                    //DrawLineV(control[i].start, control[i].end, LIGHTGRAY);
                    DrawLineV(control[i].end, points[i + 1], GRAY);
                }
            }

            if (splineHelpersActive) {
                // Draw spline point helpers
                for i: 0..pointCount - 1
                {
                    DrawCircleLinesV(points[i], ifx (xx focusedPoint == i) then 12.0  else  8.0, ifx (xx focusedPoint == i) then BLUE else DARKBLUE);
                    if ((splineTypeActive != .LINEAR) &&
                        (splineTypeActive != .BEZIER) &&
                        (i < pointCount - 1)) DrawLineV(points[i], points[i + 1], GRAY);

                    DrawText(TextFormat("[%, %]", points[i].x, points[i].y), cast(s32) points[i].x, cast(s32) points[i].y + 10, 10, BLACK);
                }
            }

            // Check all possible UI states that require controls lock
            if (splineTypeEditMode) GuiLock();

            // Draw spline config
            GuiLabel(.{ 12, 62, 140, 24 }, TextFormat("Spline thickness: %", cast(s32) splineThickness));
            GuiSliderBar(.{ 12, 60 + 24, 140, 16 }, null, null, *splineThickness, 1.0, 40.0);

            GuiCheckBox(.{ 12, 110, 20, 20 }, "Show point helpers", *splineHelpersActive);

            GuiUnlock();

            GuiLabel(.{ 12, 10, 140, 24 }, "Spline type:");
            splineTypeActives32 := cast(s32) splineTypeActive;

            if (GuiDropdownBox(.{ 12, 8 + 24, 140, 28 }, "LINEAR;BSPLINE;CATMULLROM;BEZIER", *splineTypeActives32, splineTypeEditMode)) splineTypeEditMode = !splineTypeEditMode;

            splineTypeActive = xx splineTypeActives32;

        EndDrawing();
    }

    CloseWindow();
}