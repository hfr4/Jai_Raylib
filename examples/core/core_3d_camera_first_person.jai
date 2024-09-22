/* ******************************************************************************************
*
*   raylib [core] example - 3d camera first person
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.3
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

MAX_COLUMNS :: 20;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 3d camera first person");

    // Define the camera to look into our 3d world (position, target, up vector)
    camera: Camera;
    camera.position   = .{ 0.0, 2.0, 4.0 };               // Camera position
    camera.target     = .{ 0.0, 2.0, 0.0 };               // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };               // Camera up vector (rotation towards target)
    camera.fovy       = 60.0;                             // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE;  // Camera projection type

    cameraMode : s32 = xx CameraMode.FIRST_PERSON;

    // Generates some random columns
    heights: [MAX_COLUMNS] float;
    positions: [MAX_COLUMNS] Vector3;
    colors: [MAX_COLUMNS] Color;

    for i: 0..MAX_COLUMNS - 1
    {
        heights[i]   = cast(float) GetRandomValue(1, 12);
        positions[i] = .{ cast(float) GetRandomValue(-15, 15), heights[i]/2.0, cast(float) GetRandomValue(-15, 15) };
        colors[i]    = .{ xx GetRandomValue(20, 255), xx GetRandomValue(10, 55), 30, 255 };
    }

    // DisableCursor();                    // Limit cursor to relative movement inside the window

    SetTargetFPS(60);

    while !WindowShouldClose() {

        // Switch camera mode
        if (IsKeyPressed(xx KeyboardKey.ONE))
        {
            cameraMode = xx CameraMode.FREE;
            camera.up = .{ 0.0, 1.0, 0.0 }; // Reset roll
        }

        if (IsKeyPressed(xx KeyboardKey.TWO))
        {
            cameraMode = xx CameraMode.FIRST_PERSON;
            camera.up = .{ 0.0, 1.0, 0.0 }; // Reset roll
        }

        if (IsKeyPressed(xx KeyboardKey.THREE))
        {
            cameraMode = xx CameraMode.THIRD_PERSON;
            camera.up = .{ 0.0, 1.0, 0.0 }; // Reset roll
        }

        if (IsKeyPressed(xx KeyboardKey.FOUR))
        {
            cameraMode = xx CameraMode.ORBITAL;
            camera.up = .{ 0.0, 1.0, 0.0 }; // Reset roll
        }

        // Switch camera projection
        if (IsKeyPressed(xx KeyboardKey.P))
        {
            if (camera.projection == xx CameraProjection.PERSPECTIVE)
            {
                // Create isometric view
                cameraMode = xx CameraMode.THIRD_PERSON;
                // Note: The target distance is related to the render distance in the orthographic projection
                camera.position   = .{ 0.0, 2.0, -100.0 };
                camera.target     = .{ 0.0, 2.0, 0.0 };
                camera.up         = .{ 0.0, 1.0, 0.0 };
                camera.projection = xx CameraProjection.ORTHOGRAPHIC;
                camera.fovy       = 20.0; // near plane width in xx CameraProjection.ORTHOGRAPHIC
                CameraYaw(*camera, xx (-135 * DEG2RAD), true);
                CameraPitch(*camera, xx (-45 * DEG2RAD), true, true, false);
            }
            else if (camera.projection == xx CameraProjection.ORTHOGRAPHIC)
            {
                // Reset to default view
                cameraMode = xx CameraMode.THIRD_PERSON;
                camera.position   = .{ 0.0, 2.0, 10.0 };
                camera.target     = .{ 0.0, 2.0, 0.0 };
                camera.up         = .{ 0.0, 1.0, 0.0 };
                camera.projection = xx CameraProjection.PERSPECTIVE;
                camera.fovy       = 60.0;
            }
        }

        // Update camera computes movement internally depending on the camera mode
        // Some default standard keyboard/mouse inputs are hardcoded to simplify use
        // For advance camera controls, it's reecommended to compute camera movement manually
        UpdateCamera(*camera, cameraMode);                  // Update camera

/*
        // Camera PRO usage example (EXPERIMENTAL)
        // This new camera function allows custom movement/rotation values to be directly provided
        // as input parameters, with this approach, rcamera module is internally independent of raylib inputs
        UpdateCameraPro(*camera,
            .{
                (IsKeyDown(xx KeyboardKey.W) || IsKeyDown(xx KeyboardKey.UP))*0.1 -      // Move forward-backward
                (IsKeyDown(xx KeyboardKey.S) || IsKeyDown(xx KeyboardKey.DOWN))*0.1,
                (IsKeyDown(xx KeyboardKey.D) || IsKeyDown(xx KeyboardKey.RIGHT))*0.1 -   // Move right-left
                (IsKeyDown(xx KeyboardKey.A) || IsKeyDown(xx KeyboardKey.LEFT))*0.1,
                0.0                                                // Move up-down
            },
            .{
                GetMouseDelta().x*0.05,                            // Rotation: yaw
                GetMouseDelta().y*0.05,                            // Rotation: pitch
                0.0                                                // Rotation: roll
            },
            GetMouseWheelMove()*2.0);                              // Move to target (zoom)
*/


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                DrawPlane(.{ 0.0, 0.0, 0.0 }, .{ 32.0, 32.0 }, LIGHTGRAY); // Draw ground
                DrawCube(.{ -16.0, 2.5, 0.0 }, 1.0, 5.0, 32.0, BLUE);     // Draw a blue wall
                DrawCube(.{ 16.0, 2.5, 0.0 }, 1.0, 5.0, 32.0, LIME);      // Draw a green wall
                DrawCube(.{ 0.0, 2.5, 16.0 }, 32.0, 5.0, 1.0, GOLD);      // Draw a yellow wall

                // Draw some cubes around
                for i: 0..MAX_COLUMNS - 1
                {
                    DrawCube(positions[i], 2.0, heights[i], 2.0, colors[i]);
                    DrawCubeWires(positions[i], 2.0, heights[i], 2.0, MAROON);
                }

                // Draw player cube
                if (cameraMode == xx CameraMode.THIRD_PERSON)
                {
                    DrawCube(camera.target, 0.5, 0.5, 0.5, PURPLE);
                    DrawCubeWires(camera.target, 0.5, 0.5, 0.5, DARKPURPLE);
                }

            EndMode3D();

            // Draw info boxes
            DrawRectangle(5, 5, 330, 100, Fade(SKYBLUE, 0.5));
            DrawRectangleLines(5, 5, 330, 100, BLUE);

            DrawText("Camera controls:", 15, 15, 10, BLACK);
            DrawText("- Move keys: W, A, S, D, Space, Left-Ctrl", 15, 30, 10, BLACK);
            DrawText("- Look around: arrow keys or mouse", 15, 45, 10, BLACK);
            DrawText("- Camera mode keys: 1, 2, 3, 4", 15, 60, 10, BLACK);
            DrawText("- Zoom keys: num-plus, num-minus or mouse scroll", 15, 75, 10, BLACK);
            DrawText("- Camera projection key: P", 15, 90, 10, BLACK);

            DrawRectangle(600, 5, 195, 100, Fade(SKYBLUE, 0.5));
            DrawRectangleLines(600, 5, 195, 100, BLUE);

            DrawText("Camera status:", 610, 15, 10, BLACK);
            DrawText(TextFormat("- Mode: %", ifx (cameraMode == xx CameraMode.FREE)         then "FREE"         else
                                              ifx (cameraMode == xx CameraMode.FIRST_PERSON) then "FIRST_PERSON" else
                                              ifx (cameraMode == xx CameraMode.THIRD_PERSON) then "THIRD_PERSON" else
                                              ifx (cameraMode == xx CameraMode.ORBITAL)      then "ORBITAL"      else "CUSTOM"), 610, 30, 10, BLACK);
            DrawText(TextFormat("- Projection: %", ifx (camera.projection == xx CameraProjection.PERSPECTIVE)  then "PERSPECTIVE"  else
                                                    ifx (camera.projection == xx CameraProjection.ORTHOGRAPHIC) then "ORTHOGRAPHIC" else "CUSTOM"), 610, 45, 10, BLACK);
            DrawText(TextFormat("- Position: (%, %, %)", camera.position.x, camera.position.y, camera.position.z), 610, 60, 10, BLACK);
            DrawText(TextFormat("- Target:   (%, %, %)", camera.target.x  , camera.target.y  , camera.target.z)  , 610, 75, 10, BLACK);
            DrawText(TextFormat("- Up:       (%, %, %)", camera.up.x      , camera.up.y      , camera.up.z)      , 610, 90, 10, BLACK);

        EndDrawing();
    }

    CloseWindow();
}

CAMERA_CULL_DISTANCE_NEAR      :: RL_CULL_DISTANCE_NEAR;
CAMERA_CULL_DISTANCE_FAR       :: RL_CULL_DISTANCE_FAR;
CAMERA_MOVE_SPEED              :: 5.4;   // Units per second
CAMERA_ROTATION_SPEED          :: 0.03;
CAMERA_PAN_SPEED               :: 0.2;
CAMERA_MOUSE_MOVE_SENSITIVITY  :: 0.003; // Camera mouse movement sensitivity
CAMERA_ORBITAL_SPEED           :: 0.5;   // Camera orbital speed in xx CameraMode.ORBITAL mode,Radians per second

// Returns the cameras forward vector (normalized)
GetCameraForward :: (camera: *Camera) -> Vector3
{
    return Vector3Normalize(Vector3Subtract(camera.target, camera.position));
}

// Returns the cameras up vector (normalized)
// Note: The up vector might not be perpendicular to the forward vector
GetCameraUp :: (camera: *Camera) -> Vector3
{
    return Vector3Normalize(camera.up);
}

// Returns the cameras right vector (normalized)
GetCameraRight :: (camera: *Camera) -> Vector3
{
    forward := GetCameraForward(camera);
    up      := GetCameraUp(camera);

    return Vector3Normalize(Vector3CrossProduct(forward, up));
}

// Moves the camera in its forward direction
CameraMoveForward :: (camera: *Camera, distance: float, moveInWorldPlane: bool)
{
    forward := GetCameraForward(camera);

    if (moveInWorldPlane)
    {
        // Project vector onto world plane
        forward.y = 0;
        forward = Vector3Normalize(forward);
    }

    // Scale by distance
    forward = Vector3Scale(forward, distance);

    // Move position and target
    camera.position = Vector3Add(camera.position, forward);
    camera.target   = Vector3Add(camera.target, forward);
}

// Moves the camera in its up direction
CameraMoveUp :: (camera: *Camera, distance: float)
{
    up := GetCameraUp(camera);

    // Scale by distance
    up = Vector3Scale(up, distance);

    // Move position and target
    camera.position = Vector3Add(camera.position, up);
    camera.target   = Vector3Add(camera.target, up);
}

// Moves the camera target in its current right direction
CameraMoveRight :: (camera: *Camera, distance: float, moveInWorldPlane: bool)
{
    right := GetCameraRight(camera);

    if (moveInWorldPlane)
    {
        // Project vector onto world plane
        right.y = 0;
        right = Vector3Normalize(right);
    }

    // Scale by distance
    right = Vector3Scale(right, distance);

    // Move position and target
    camera.position = Vector3Add(camera.position, right);
    camera.target   = Vector3Add(camera.target, right);
}

// Moves the camera position closer/farther to/from the camera target
CameraMoveToTarget :: (camera: *Camera, delta: float)
{
    distance := Vector3Distance(camera.position, camera.target);

    // Apply delta
    distance += delta;

    // Distance must be greater than 0
    if (distance <= 0) distance = 0.001;

    // Set new distance by moving the position along the forward vector
    forward := GetCameraForward(camera);
    camera.position = Vector3Add(camera.target, Vector3Scale(forward, -distance));
}

// Rotates the camera around its up vector
// Yaw is "looking left and right"
// If rotateAroundTarget is false, the camera rotates around its position
// Note: angle must be provided in radians
CameraYaw :: (camera: *Camera, angle: float, rotateAroundTarget: bool)
{
    // Rotation axis
    up := GetCameraUp(camera);

    // View vector
    targetPosition := Vector3Subtract(camera.target, camera.position);

    // Rotate view vector around up axis
    targetPosition = Vector3RotateByAxisAngle(targetPosition, up, angle);

    if (rotateAroundTarget)
    {
        // Move position relative to target
        camera.position = Vector3Subtract(camera.target, targetPosition);
    }
    else // rotate around camera.position
    {
        // Move target relative to position
        camera.target = Vector3Add(camera.position, targetPosition);
    }
}

// Rotates the camera around its right vector, pitch is "looking up and down"
//  - lockView prevents camera overrotation (aka "somersaults")
//  - rotateAroundTarget defines if rotation is around target or around its position
//  - rotateUp rotates the up direction as well (typically only usefull in xx CameraMode.FREE)
// NOTE: angle must be provided in radians
CameraPitch :: (camera: *Camera, angle: float, lockView: bool, rotateAroundTarget: bool, rotateUp: bool)
{
    // Up direction
    up := GetCameraUp(camera);

    // View vector
    targetPosition := Vector3Subtract(camera.target, camera.position);

    if (lockView)
    {
        // In these camera modes we clamp the Pitch angle
        // to allow only viewing straight up or down.

        // Clamp view up
        maxAngleUp := Vector3Angle(up, targetPosition);
        maxAngleUp -= 0.001; // avoid numerical errors
        if (angle > maxAngleUp) angle = maxAngleUp;

        // Clamp view down
        maxAngleDown := Vector3Angle(Vector3Negate(up), targetPosition);
        maxAngleDown *= -1.0; // downwards angle is negative
        maxAngleDown += 0.001; // avoid numerical errors
        if (angle < maxAngleDown) angle = maxAngleDown;
    }

    // Rotation axis
    right := GetCameraRight(camera);

    // Rotate view vector around right axis
    targetPosition = Vector3RotateByAxisAngle(targetPosition, right, angle);

    if (rotateAroundTarget)
    {
        // Move position relative to target
        camera.position = Vector3Subtract(camera.target, targetPosition);
    }
    else // rotate around camera.position
    {
        // Move target relative to position
        camera.target = Vector3Add(camera.position, targetPosition);
    }

    if (rotateUp)
    {
        // Rotate up direction around right axis
        camera.up = Vector3RotateByAxisAngle(camera.up, right, angle);
    }
}

// Rotates the camera around its forward vector
// Roll is "turning your head sideways to the left or right"
// Note: angle must be provided in radians
CameraRoll :: (camera: *Camera, angle: float)
{
    // Rotation axis
    forward := GetCameraForward(camera);

    // Rotate up direction around forward axis
    camera.up = Vector3RotateByAxisAngle(camera.up, forward, angle);
}

// Returns the camera view matrix
 GetCameraViewMatrix :: (camera: *Camera) -> Matrix
{
    return MatrixLookAt(camera.position, camera.target, camera.up);
}

// Returns the camera projection matrix
GetCameraProjectionMatrix :: (camera: *Camera, aspect: float) -> Matrix
{
    if (camera.projection == xx CameraProjection.PERSPECTIVE)
    {
        return MatrixPerspective(camera.fovy*DEG2RAD, aspect, CAMERA_CULL_DISTANCE_NEAR, CAMERA_CULL_DISTANCE_FAR);
    }
    else if (camera.projection == xx CameraProjection.ORTHOGRAPHIC)
    {
        top   := camera.fovy/2.0;
        right := top*aspect;

        return MatrixOrtho(-right, right, -top, top, CAMERA_CULL_DISTANCE_NEAR, CAMERA_CULL_DISTANCE_FAR);
    }

    return MatrixIdentity();
}
