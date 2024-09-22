/* ******************************************************************************************
*
*   raylib [models] example - Mesh picking in 3d mode, ground plane, triangle, mesh
*
*   Example originally created with raylib 1.7, last time updated with raylib 4.0
*
*   Example contributed by Joel Davis (@joeld42) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2024 Joel Davis (@joeld42) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - mesh picking");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = .{ 20.0, 20.0, 20.0 };            // Camera position
    camera.target     = .{ 0.0, 8.0, 0.0 };               // Camera looking at point
    camera.up         = .{ 0.0, 1.6, 0.0 };               // Camera up vector (rotation towards target)
    camera.fovy       = 45.0;                             // Camera field-of-view Y
    camera.projection = xx CameraProjection.PERSPECTIVE;  // Camera projection type

    ray: Ray;        // Picking ray

    tower   := LoadModel("resources/models/obj/turret.obj");           // Load OBJ model
    texture := LoadTexture("resources/models/obj/turret_diffuse.png"); // Load model texture
    tower.materials[0].maps[xx MaterialMapIndex.ALBEDO].texture = texture;            // Set model diffuse texture

    towerPos  := Vector3.{ 0.0, 0.0, 0.0 };               // Set model position
    towerBBox := GetMeshBoundingBox(tower.meshes[0]);    // Get mesh bounding box

    // Ground quad
    g0 := Vector3.{ -50.0, 0.0, -50.0 };
    g1 := Vector3.{ -50.0, 0.0,  50.0 };
    g2 := Vector3.{  50.0, 0.0,  50.0 };
    g3 := Vector3.{  50.0, 0.0, -50.0 };

    // Test triangle
    ta := Vector3.{ -25.0, 0.5, 0.0 };
    tb := Vector3.{ -4.0, 2.5, 1.0 };
    tc := Vector3.{ -8.0, 6.5, 0.0 };

    bary := Vector3.{ 0.0, 0.0, 0.0 };

    // Test sphere
    sp := Vector3.{ -30.0, 5.0, 5.0 };
    sr := 4.0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsCursorHidden()) UpdateCamera(*camera, xx CameraMode.FIRST_PERSON);          // Update camera

        // Toggle camera controls
        if (IsMouseButtonPressed(xx MouseButton.RIGHT))
        {
            if (IsCursorHidden()) EnableCursor();
            else DisableCursor();
        }

        // Display information about closest hit
        collision: RayCollision;
        hitObjectName := "None";
        collision.distance = Math.FLOAT32_MAX;
        collision.hit      = false;
        cursorColor := WHITE;

        // Get ray and test against objects
        ray = GetMouseRay(GetMousePosition(), camera);

        // Check ray collision against ground quad
        groundHitInfo := GetRayCollisionQuad(ray, g0, g1, g2, g3);

        if ((groundHitInfo.hit) && (groundHitInfo.distance < collision.distance))
        {
            collision     = groundHitInfo;
            cursorColor   = GREEN;
            hitObjectName = "Ground";
        }

        // Check ray collision against test triangle
        triHitInfo := GetRayCollisionTriangle(ray, ta, tb, tc);

        if ((triHitInfo.hit) && (triHitInfo.distance < collision.distance))
        {
            collision     = triHitInfo;
            cursorColor   = PURPLE;
            hitObjectName = "Triangle";

            bary = Vector3Barycenter(collision.point, ta, tb, tc);
        }

        // Check ray collision against test sphere
        sphereHitInfo := GetRayCollisionSphere(ray, sp, sr);

        if ((sphereHitInfo.hit) && (sphereHitInfo.distance < collision.distance))
        {
            collision     = sphereHitInfo;
            cursorColor   = ORANGE;
            hitObjectName = "Sphere";
        }

        // Check ray collision against bounding box first, before trying the full ray-mesh test
        boxHitInfo := GetRayCollisionBox(ray, towerBBox);

        if ((boxHitInfo.hit) && (boxHitInfo.distance < collision.distance))
        {
            collision     = boxHitInfo;
            cursorColor   = ORANGE;
            hitObjectName = "Box";

            // Check ray collision against model meshes
            meshHitInfo: RayCollision;
            for m: 0..tower.meshCount - 1
            {
                // NOTE: We consider the model.transform for the collision check but
                // it can be checked against any transform Matrix, used when checking against same
                // model drawn multiple times with multiple transforms
                meshHitInfo = GetRayCollisionMesh(ray, tower.meshes[m], tower.transform);
                if (meshHitInfo.hit)
                {
                    // Save the closest hit mesh
                    if ((!collision.hit) || (collision.distance > meshHitInfo.distance)) collision = meshHitInfo;

                    break;  // Stop once one mesh collision is detected, the colliding mesh is m
                }
            }

            if (meshHitInfo.hit)
            {
                collision     = meshHitInfo;
                cursorColor   = ORANGE;
                hitObjectName = "Mesh";
            }
        }


        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                // Draw the tower
                // WARNING: If scale is different than 1.0,
                // not considered by GetRayCollisionModel()
                DrawModel(tower, towerPos, 1.0, WHITE);

                // Draw the test triangle
                DrawLine3D(ta, tb, PURPLE);
                DrawLine3D(tb, tc, PURPLE);
                DrawLine3D(tc, ta, PURPLE);

                // Draw the test sphere
                DrawSphereWires(sp, sr, 8, 8, PURPLE);

                // Draw the mesh bbox if we hit it
                if (boxHitInfo.hit) DrawBoundingBox(towerBBox, LIME);

                // If we hit something, draw the cursor at the hit point
                if (collision.hit)
                {
                    DrawCube(collision.point, 0.3, 0.3, 0.3, cursorColor);
                    DrawCubeWires(collision.point, 0.3, 0.3, 0.3, RED);

                    normalEnd: Vector3;
                    normalEnd.x = collision.point.x + collision.normal.x;
                    normalEnd.y = collision.point.y + collision.normal.y;
                    normalEnd.z = collision.point.z + collision.normal.z;

                    DrawLine3D(collision.point, normalEnd, RED);
                }

                DrawRay(ray, MAROON);

                DrawGrid(10, 10.0);

            EndMode3D();

            // Draw some debug GUI text
            DrawText(TextFormat("Hit Object: %", hitObjectName), 10, 50, 10, BLACK);

            if (collision.hit)
            {
                ypos := 70;

                DrawText(TextFormat("Distance: %", collision.distance), 10, xx ypos, 10, BLACK);

                DrawText(TextFormat("Hit Pos: % % %",
                                    collision.point.x,
                                    collision.point.y,
                                    collision.point.z), 10, xx (ypos + 15), 10, BLACK);

                DrawText(TextFormat("Hit Norm: % % %",
                                    collision.normal.x,
                                    collision.normal.y,
                                    collision.normal.z), 10, xx (ypos + 30), 10, BLACK);

                if (triHitInfo.hit && TextIsEqual(hitObjectName.data, "Triangle"))
                    DrawText(TextFormat("Barycenter: % % %",  bary.x, bary.y, bary.z), 10, xx (ypos + 45), 10, BLACK);
            }

            DrawText("Right click mouse to toggle camera controls", 10, 430, 10, GRAY);

            DrawText("(c) Turret 3D model by Alberto Cano", SCREEN_WIDTH - 200, SCREEN_HEIGHT - 20, 10, GRAY);

            DrawFPS(10, 10);

        EndDrawing();
    }

    UnloadModel(tower);         // Unload model
    UnloadTexture(texture);     // Unload texture

    CloseWindow();

}