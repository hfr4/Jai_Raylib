/* ******************************************************************************************
*
*   raylib [models] example - rlgl module usage with push/pop matrix transformations
*
*   NOTE: This example uses [rlgl] module functionality (pseudo-OpenGL 1.1 style coding)
*
*   Example originally created with raylib 2.5, last time updated with raylib 4.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    sunRadius := 4.0;
    earthRadius := 0.6;
    earthOrbitRadius := 8.0;
    moonRadius := 0.16;
    moonOrbitRadius := 1.5;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - rlgl module usage with push/pop matrix transformations");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 16.0, 16.0, 16.0 };           // Camera position
    camera.target     = .{ 0.0, 0.0, 0.0 };              // Camera looking at point
    camera.up         = .{ 0.0, 1.0, 0.0 };              // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                            // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE; // Camera projection type

    rotationSpeed := 0.2;         // General system rotation speed

    earthRotation := 0.0;         // Rotation of earth around itself (days) in degrees
    earthOrbitRotation := 0.0;    // Rotation of earth around the Sun (years) in degrees
    moonRotation := 0.0;          // Rotation of moon around itself
    moonOrbitRotation := 0.0;     // Rotation of moon around earth in degrees

    SetTargetFPS(60);

    while !WindowShouldClose() {

        UpdateCamera(*camera, xx CameraMode.ORBITAL);

        earthRotation      += (5.0*rotationSpeed);
        earthOrbitRotation += (365/360.0*(5.0*rotationSpeed)*rotationSpeed);
        moonRotation       += (2.0*rotationSpeed);
        moonOrbitRotation  += (8.0*rotationSpeed);


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                rlPushMatrix();
                    rlScalef(sunRadius, sunRadius, sunRadius);          // Scale Sun
                    DrawSphereBasic(GOLD);                              // Draw the Sun
                rlPopMatrix();

                rlPushMatrix();
                    rlRotatef(earthOrbitRotation, 0.0, 1.0, 0.0);    // Rotation for Earth orbit around Sun
                    rlTranslatef(earthOrbitRadius, 0.0, 0.0);         // Translation for Earth orbit

                    rlPushMatrix();
                        rlRotatef(earthRotation, 0.25, 1.0, 0.0);       // Rotation for Earth itself
                        rlScalef(earthRadius, earthRadius, earthRadius);// Scale Earth

                        DrawSphereBasic(BLUE);                          // Draw the Earth
                    rlPopMatrix();

                    rlRotatef(moonOrbitRotation, 0.0, 1.0, 0.0);     // Rotation for Moon orbit around Earth
                    rlTranslatef(moonOrbitRadius, 0.0, 0.0);          // Translation for Moon orbit
                    rlRotatef(moonRotation, 0.0, 1.0, 0.0);          // Rotation for Moon itself
                    rlScalef(moonRadius, moonRadius, moonRadius);       // Scale Moon

                    DrawSphereBasic(LIGHTGRAY);                         // Draw the Moon
                rlPopMatrix();

                // Some reference elements (not affected by previous matrix transformations)
                DrawCircle3D(.{ 0.0, 0.0, 0.0 }, earthOrbitRadius, .{ 1, 0, 0 }, 90.0, Fade(RED, 0.5));
                DrawGrid(20, 1.0);

            EndMode3D();

            DrawText("EARTH ORBITING AROUND THE SUN!", 400, 10, 20, MAROON);
            DrawFPS(10, 10);

        EndDrawing();
    }
    CloseWindow();
}


// Draw sphere without any matrix transformation
// NOTE: Sphere is drawn in world position ( 0, 0, 0 ) with radius 1.0
DrawSphereBasic ::(color: Color)
{
    rings  := 16;
    slices := 16;

    // Make sure there is enough space in the internal render batch
    // buffer to store all required vertex, batch is reseted if required
    rlCheckRenderBatchLimit(xx ((rings + 2)*slices*6));

    rlBegin(RL_TRIANGLES);
        rlColor4ub(color.r, color.g, color.b, color.a);

        for i: 0..(rings + 2) - 1
        {
            for j: 0..slices - 1
            {
                rlVertex3f(xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.sin(DEG2RAD*(j*360/slices))),
                           xx (Math.sin(DEG2RAD*(270+(180/(rings + 1))*i))),
                           xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.cos(DEG2RAD*(j*360/slices))));
                rlVertex3f(xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*((j+1)*360/slices))),
                           xx (Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1)))),
                           xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*((j+1)*360/slices))));
                rlVertex3f(xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*(j*360/slices))),
                           xx (Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1)))),
                           xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*(j*360/slices))));

                rlVertex3f(xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.sin(DEG2RAD*(j*360/slices))),
                           xx (Math.sin(DEG2RAD*(270+(180/(rings + 1))*i))),
                           xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.cos(DEG2RAD*(j*360/slices))));
                rlVertex3f(xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i)))*Math.sin(DEG2RAD*((j+1)*360/slices))),
                           xx (Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i)))),
                           xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i)))*Math.cos(DEG2RAD*((j+1)*360/slices))));
                rlVertex3f(xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*((j+1)*360/slices))),
                           xx (Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1)))),
                           xx (Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*((j+1)*360/slices))));
            }
        }
    rlEnd();
}
