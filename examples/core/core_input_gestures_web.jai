/* ******************************************************************************************
*
*   raylib [core] example - Input Gestures for Web
*
*   Example originally created with raylib 4.6-dev, last time updated with raylib 4.6-dev
*
*   Example contributed by ubkp (@ubkp) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 ubkp (@ubkp)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

PLATFORM_WEB :: false;

#if PLATFORM_WEB {
    // #include <emscripten/emscripten.h> // Required for the Web/HTML5
}

SCREEN_WIDTH  :: 800;                  // Update depending on web canvas
SCREEN_HEIGHT :: 450;
messagePosition := Vector2.{ 160, 7 };

// Last gesture variables definitions
lastGesture := 0;
lastGesturePosition := Vector2.{ 165, 130 };

// Gesture log variables definitions and functions declarations
GESTURE_LOG_SIZE ::  20;
gestureLog: [GESTURE_LOG_SIZE][12] u8; // The gesture log uses an array (as an inverted circular queue) to store the performed gestures
gestureLogIndex := GESTURE_LOG_SIZE;    // The index for the inverted circular queue (moving from last to first direction, then looping around)
previousGesture := 0;

main :: () {
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - input gestures web");

    #if PLATFORM_WEB {
        // emscripten_set_main_loop(Update, 0, 1);
    } else {
        SetTargetFPS(60);
        while (!WindowShouldClose()) Update();
    }

    CloseWindow();
}

GetGestureName :: ( i: int) -> string
{
   if i == {
      case 0;   return "None";
      case 1;   return "Tap";
      case 2;   return "Double Tap";
      case 4;   return "Hold";
      case 8;   return "Drag";
      case 16;  return "Swipe Right";
      case 32;  return "Swipe Left";
      case 64;  return "Swipe Up";
      case 128; return "Swipe Down";
      case 256; return "Pinch In";
      case 512; return "Pinch Out";
      case;     return "Unknown";
   }
}

GetGestureColor :: (i: int) -> Color
{
   if i == {
      case 0;   return BLACK;
      case 1;   return BLUE;
      case 2;   return SKYBLUE;
      case 4;   return BLACK;
      case 8;   return LIME;
      case 16;  return RED;
      case 32;  return RED;
      case 64;  return RED;
      case 128; return RED;
      case 256; return VIOLET;
      case 512; return ORANGE;
      case;     return BLACK;
   }
}

logMode := 1; // Log mode values: 0 shows repeated events; 1 hides repeated events; 2 shows repeated events but hide hold events; 3 hides repeated events and hide hold events

gestureColor := Color.{ 0, 0, 0, 255 };
logButton1 := Rectangle.{ 53, 7, 48, 26 };
logButton2 := Rectangle.{ 108, 7, 36, 26 };
gestureLogPosition := Vector2.{ 10, 10 };

// Protractor variables definitions
angleLength := 90.0;
currentAngleDegrees := 0.0;
finalVector := Vector2.{ 0.0, 0.0 };
currentAngleStr: [7] u8;
protractorPosition := Vector2.{ 266.0, 315.0 };

Update :: ()
{
    // Handle common
    i, ii: int; // Iterators that will be reused by all for loops
    currentGesture := GetGestureDetected();
    currentDragDegrees := GetGestureDragAngle();
    currentPitchDegrees := GetGesturePinchAngle();
    touchCount := GetTouchPointCount();

    // Handle last gesture
    if ((currentGesture != 0) && (currentGesture != 4) && (currentGesture != previousGesture)) lastGesture = currentGesture; // Filter the meaningful gestures (1, 2, 8 to 512) for the display

    // Handle gesture log
    if (IsMouseButtonReleased(xx MouseButton.LEFT))
    {
        if (CheckCollisionPointRec(GetMousePosition(), logButton1))
        {
            if logMode == {
                case 3;  logMode = 2;
                case 2;  logMode = 3;
                case 1;  logMode = 0;
                case;    logMode = 1;
            }
        }
        else if (CheckCollisionPointRec(GetMousePosition(), logButton2))
        {
            if logMode == {
                case 3;  logMode=1;
                case 2;  logMode=0;
                case 1;  logMode=3;
                case;    logMode=2;
            }
        }
    }

    fillLog := 0; // Gate variable to be used to allow or not the gesture log to be filled
    if (currentGesture !=0)
    {
        if (logMode == 3) // 3 hides repeated events and hide hold events
        {
            if (((currentGesture != 4) && (currentGesture != previousGesture)) || (currentGesture < 3)) fillLog = 1;
        }
        else if (logMode == 2) // 2 shows repeated events but hide hold events
        {
            if (currentGesture != 4) fillLog = 1;
        }
        else if (logMode == 1) // 1 hides repeated events
        {
            if (currentGesture != previousGesture) fillLog = 1;
        }
        else  // 0 shows repeated events
        {
            fillLog = 1;
        }
    }

    if (fillLog) // If one of the conditions from logMode was met, fill the gesture log
    {
        previousGesture = currentGesture;
        gestureColor = GetGestureColor(currentGesture);
        if (gestureLogIndex <= 0) gestureLogIndex = GESTURE_LOG_SIZE;
        gestureLogIndex -= 1;

        // Copy the gesture respective name to the gesture log array
        TextCopy(gestureLog[gestureLogIndex].data, GetGestureName(currentGesture).data);
    }

    // Handle protractor
    if (currentGesture > 255) // aka Pinch In and Pinch Out
    {
        currentAngleDegrees = currentPitchDegrees;
    }
    else if (currentGesture > 15) // aka Swipe Right, Swipe Left, Swipe Up and Swipe Down
    {
        currentAngleDegrees = currentDragDegrees;
    }
    else if (currentGesture > 0) // aka Tap, Doubletap, Hold and Grab
    {
        currentAngleDegrees = 0.0;
    }

    currentAngleRadians := ((currentAngleDegrees +90.0)*PI/180); // Convert the current angle to Radians
    finalVector = .{
        cast(float) ((angleLength*Math.sin(currentAngleRadians)) + protractorPosition.x),
        cast(float) ((angleLength*Math.cos(currentAngleRadians)) + protractorPosition.y),
    }; // Calculate the final vector for display

    // Handle touch and mouse pointer points
    MAX_TOUCH_COUNT ::    32;

    touchPosition: [MAX_TOUCH_COUNT] Vector2 ;
    mousePosition: Vector2;
    if (currentGesture != xx Gesture.NONE)
    {
        if (touchCount != 0)
        {
            for i: 0..touchCount - 1 touchPosition[i] = GetTouchPosition(i); // Fill the touch positions
        }
        else mousePosition = GetMousePosition();
    }

    // Draw
    BeginDrawing();

        ClearBackground(RAYWHITE);

        // Draw common
        DrawText("*"                                                                           , xx (messagePosition.x + 5) , xx (messagePosition.y + 5) , 10, BLACK);
        DrawText("Example optimized for Web/HTML5\non Smartphones with Touch Screen."          , xx (messagePosition.x + 15), xx (messagePosition.y + 5) , 10, BLACK);
        DrawText("*"                                                                           , xx (messagePosition.x + 5) , xx (messagePosition.y + 35), 10, BLACK);
        DrawText("While running on Desktop Web Browsers,\ninspect and turn on Touch Emulation.", xx (messagePosition.x + 15), xx (messagePosition.y + 35), 10, BLACK);

        // Draw last gesture
        DrawText("Last gesture", xx (lastGesturePosition.x + 33), xx (lastGesturePosition.y - 47), 20, BLACK);
        DrawText("Swipe         Tap       Pinch  Touch", xx (lastGesturePosition.x + 17), xx (lastGesturePosition.y - 18), 10, BLACK);
        DrawRectangle(xx (lastGesturePosition.x + 20), xx (lastGesturePosition.y     ), 20, 20, ifx lastGesture == xx Gesture.SWIPE_UP  then  RED else LIGHTGRAY);
        DrawRectangle(xx (lastGesturePosition.x     ), xx (lastGesturePosition.y + 20), 20, 20, ifx lastGesture == xx Gesture.SWIPE_LEFT  then  RED else LIGHTGRAY);
        DrawRectangle(xx (lastGesturePosition.x + 40), xx (lastGesturePosition.y + 20), 20, 20, ifx lastGesture == xx Gesture.SWIPE_RIGHT  then  RED else LIGHTGRAY);
        DrawRectangle(xx (lastGesturePosition.x + 20), xx (lastGesturePosition.y + 40), 20, 20, ifx lastGesture == xx Gesture.SWIPE_DOWN  then  RED else LIGHTGRAY);
        DrawCircle( xx(lastGesturePosition.x + 80), xx (lastGesturePosition.y + 16), 10, ifx lastGesture == xx Gesture.TAP  then  BLUE else LIGHTGRAY);
        DrawRing( .{lastGesturePosition.x + 103, lastGesturePosition.y + 16}, 6.0, 11.0, 0.0, 360.0, 0, ifx lastGesture == xx Gesture.DRAG  then  LIME else LIGHTGRAY);
        DrawCircle( xx(lastGesturePosition.x + 80), xx (lastGesturePosition.y + 43), 10, ifx lastGesture == xx Gesture.DOUBLETAP  then  SKYBLUE else LIGHTGRAY);
        DrawCircle( xx(lastGesturePosition.x + 103), xx (lastGesturePosition.y + 43), 10, ifx lastGesture == xx Gesture.DOUBLETAP  then  SKYBLUE else LIGHTGRAY);
        DrawTriangle(.{ lastGesturePosition.x + 122, lastGesturePosition.y + 16 }, .{ lastGesturePosition.x + 137, lastGesturePosition.y + 26 }, .{ lastGesturePosition.x + 137, lastGesturePosition.y + 6 }, ifx lastGesture == xx Gesture.PINCH_OUT then  ORANGE else LIGHTGRAY);
        DrawTriangle(.{ lastGesturePosition.x + 147, lastGesturePosition.y + 6 }, .{ lastGesturePosition.x + 147, lastGesturePosition.y + 26 }, .{ lastGesturePosition.x + 162, lastGesturePosition.y + 16 }, ifx lastGesture == xx Gesture.PINCH_OUT then  ORANGE else LIGHTGRAY);
        DrawTriangle(.{ lastGesturePosition.x + 125, lastGesturePosition.y + 33 }, .{ lastGesturePosition.x + 125, lastGesturePosition.y + 53 }, .{ lastGesturePosition.x + 140, lastGesturePosition.y + 43 }, ifx lastGesture == xx Gesture.PINCH_IN then  VIOLET else LIGHTGRAY);
        DrawTriangle(.{ lastGesturePosition.x + 144, lastGesturePosition.y + 43 }, .{ lastGesturePosition.x + 159, lastGesturePosition.y + 53 }, .{ lastGesturePosition.x + 159, lastGesturePosition.y + 33 }, ifx lastGesture == xx Gesture.PINCH_IN then  VIOLET else LIGHTGRAY);
        for i: 0..3 DrawCircle( xx (lastGesturePosition.x + 180), xx (lastGesturePosition.y + 7 + i*15), 5, ifx touchCount <= i then  LIGHTGRAY else gestureColor);

        // Draw gesture log
            DrawText("Log", xx (gestureLogPosition.x), xx (gestureLogPosition.y), 20, BLACK);

        // Loop in both directions to print the gesture log array in the inverted order (and looping around if the index started somewhere in the middle)
        ii = gestureLogIndex;
        for i: 0..GESTURE_LOG_SIZE - 1 {
            ii = (ii + 1) % GESTURE_LOG_SIZE;

            DrawText(gestureLog[ii].data, xx (gestureLogPosition.x), xx (gestureLogPosition.y + 410 - i*20), 20, (ifx i == 0  then  gestureColor else LIGHTGRAY));
        }
        logButton1Color, logButton2Color: Color;
        if logMode == {
            case 3;  logButton1Color=MAROON; logButton2Color=MAROON;
            case 2;  logButton1Color=GRAY;   logButton2Color=MAROON;
            case 1;  logButton1Color=MAROON; logButton2Color=GRAY;
            case;    logButton1Color=GRAY;   logButton2Color=GRAY;
        }
        DrawRectangleRec(logButton1, logButton1Color);
        DrawText("Hide"  , xx (logButton1.x + 7), xx (logButton1.y + 3), 10, WHITE);
        DrawText("Repeat", xx (logButton1.x + 7), xx (logButton1.y + 13), 10, WHITE);
        DrawRectangleRec(logButton2, logButton2Color);
        DrawText("Hide"  , xx (logButton1.x + 62), xx (logButton1.y + 3), 10, WHITE);
        DrawText("Hold"  , xx (logButton1.x + 62), xx (logButton1.y + 13), 10, WHITE);

        // Draw protractor
        DrawText("Angle", xx (protractorPosition.x + 55), xx (protractorPosition.y + 76), 10, BLACK);
        angleString := TextFormat("%", currentAngleDegrees);
        angleStringDot := TextFindIndex(angleString, ".");
        angleStringTrim := TextSubtext(angleString, 0, angleStringDot + 3);
        DrawText( angleStringTrim, xx (protractorPosition.x + 55), xx (protractorPosition.y + 92), 20, gestureColor);
        DrawCircle(xx (protractorPosition.x), xx (protractorPosition.y), 80.0, WHITE);
        DrawLineEx(.{ protractorPosition.x - 90, protractorPosition.y }     , .{ protractorPosition.x + 90, protractorPosition.y }     , 3.0, LIGHTGRAY);
        DrawLineEx(.{ protractorPosition.x, protractorPosition.y - 90 }     , .{ protractorPosition.x, protractorPosition.y + 90 }     , 3.0, LIGHTGRAY);
        DrawLineEx(.{ protractorPosition.x - 80, protractorPosition.y - 45 }, .{ protractorPosition.x + 80, protractorPosition.y + 45 }, 3.0, GREEN);
        DrawLineEx(.{ protractorPosition.x - 80, protractorPosition.y + 45 }, .{ protractorPosition.x + 80, protractorPosition.y - 45 }, 3.0, GREEN);
        DrawText("0", xx (protractorPosition.x + 96), xx (protractorPosition.y - 9), 20, BLACK);
        DrawText("30", xx (protractorPosition.x + 74), xx (protractorPosition.y - 68), 20, BLACK);
        DrawText("90", xx (protractorPosition.x - 11), xx (protractorPosition.y - 110), 20, BLACK);
        DrawText("150", xx (protractorPosition.x - 100), xx (protractorPosition.y - 68), 20, BLACK);
        DrawText("180", xx (protractorPosition.x - 124), xx (protractorPosition.y - 9), 20, BLACK);
        DrawText("210", xx (protractorPosition.x - 100), xx (protractorPosition.y + 50), 20, BLACK);
        DrawText("270", xx (protractorPosition.x - 18), xx (protractorPosition.y + 92), 20, BLACK);
        DrawText("330", xx (protractorPosition.x + 72), xx (protractorPosition.y + 50), 20, BLACK);
        if (currentAngleDegrees != 0.0) DrawLineEx(protractorPosition, finalVector, 3.0, gestureColor);

        // Draw touch and mouse pointer points
            if (currentGesture != xx Gesture.NONE)
        {
            if ( touchCount != 0 )
            {
                for i: 0..touchCount - 1
                {
                    DrawCircleV(touchPosition[i], 50.0, Fade(gestureColor, 0.5));
                    DrawCircleV(touchPosition[i], 5.0, gestureColor);
                }

                if (touchCount == 2) DrawLineEx(touchPosition[0], touchPosition[1], xx (ifx currentGesture == 512 then  8 else 12), gestureColor);
            }
            else
            {
                DrawCircleV(mousePosition, 35.0, Fade(gestureColor, 0.5));
                DrawCircleV(mousePosition, 5.0, gestureColor);
            }
        }

    EndDrawing();
}
