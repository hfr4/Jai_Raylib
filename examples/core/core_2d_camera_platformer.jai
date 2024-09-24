/* ******************************************************************************************
*
*   raylib [core] example - 2D Camera platformer
*
*   Example originally created with raylib 2.5, last time updated with raylib 3.0
*
*   Example contributed by arvyy (@arvyy) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2019-2023 arvyy (@arvyy)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

G               :: 400;
PLAYER_JUMP_SPD :: 350.0;
PLAYER_HOR_SPD  :: 200.0;

Player :: struct {
    position: Vector2;
    speed:    float;
    canJump:  bool;
}

EnvItem :: struct {
    rect:     Rectangle;
    blocking: int;
    color:    Color;
}

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera");

    player: Player;
    player.position = .{ 400, 280 };
    player.speed    = 0;
    player.canJump  = false;

    envItems := EnvItem.[
        .{ .{ 0  , 0  , 1000, 400 }, 0, LIGHTGRAY },
        .{ .{ 0  , 400, 1000, 200 }, 1, GRAY      },
        .{ .{ 300, 200, 400 , 10  }, 1, GRAY      },
        .{ .{ 250, 300, 100 , 10  }, 1, GRAY      },
        .{ .{ 650, 300, 100 , 10  }, 1, GRAY      },
    ];

    camera: Camera2D;
    camera.target   = player.position;
    camera.offset   = .{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 };
    camera.rotation = 0.0;
    camera.zoom     = 1.0;

    cameraUpdaters := UpateCameraType.[
        UpdateCameraCenter,
        UpdateCameraCenterInsideMap,
        UpdateCameraCenterSmoothFollow,
        UpdateCameraEvenOutOnLanding,
        UpdateCameraPlayerBoundsPush,
    ];

    cameraOption := 0;

    cameraDescriptions := string.[
        "Follow player center",
        "Follow player center, but clamp to map edges",
        "Follow player center; smoothed",
        "Follow player center horizontally; update player center vertically after landing",
        "Player push camera on getting too close to screen edge",
    ];

    SetTargetFPS(60);

    while !WindowShouldClose() {

        deltaTime := GetFrameTime();

        UpdatePlayer(*player, envItems, deltaTime);

        camera.zoom += (cast(float) GetMouseWheelMove() * 0.05);

        if      (camera.zoom > 3.0)  camera.zoom = 3.0;
        else if (camera.zoom < 0.25) camera.zoom = 0.25;

        if (IsKeyPressed(xx KeyboardKey.R))
        {
            camera.zoom     = 1.0;
            player.position = .{ 400, 280 };
        }

        if (IsKeyPressed(xx KeyboardKey.C)) cameraOption = (cameraOption + 1) % cameraUpdaters.count;

        // Call update camera function by its pointer
        cameraUpdaters[cameraOption](*camera, *player, envItems, deltaTime, SCREEN_WIDTH, SCREEN_HEIGHT);

        BeginDrawing();

            ClearBackground(LIGHTGRAY);

            BeginMode2D(camera);

                for envItems DrawRectangleRec(it.rect, it.color);

                playerRect := Rectangle.{ player.position.x - 20, player.position.y - 40, 40.0, 40.0 };
                DrawRectangleRec(playerRect, RED);

                DrawCircleV(player.position, 5.0, GOLD);

            EndMode2D();

            DrawText("Controls:", 20, 20, 10, BLACK);
            DrawText("- Right/Left to move", 40, 40, 10, DARKGRAY);
            DrawText("- Space to jump", 40, 60, 10, DARKGRAY);
            DrawText("- Mouse Wheel to Zoom in-out, R to reset zoom", 40, 80, 10, DARKGRAY);
            DrawText("- C to change camera mode", 40, 100, 10, DARKGRAY);
            DrawText("Current camera mode:", 20, 120, 10, BLACK);
            DrawText(to_c_string(cameraDescriptions[cameraOption]), 40, 140, 10, DARKGRAY);

        EndDrawing();
    }

    CloseWindow();
}
UpdatePlayer :: (player: *Player, envItems: [] EnvItem, delta: float)
{
    if (IsKeyDown(xx KeyboardKey.LEFT))  player.position.x -= PLAYER_HOR_SPD*delta;
    if (IsKeyDown(xx KeyboardKey.RIGHT)) player.position.x += PLAYER_HOR_SPD*delta;
    if (IsKeyDown(xx KeyboardKey.SPACE) && player.canJump)
    {
        player.speed   = -PLAYER_JUMP_SPD;
        player.canJump = false;
    }

    hitObstacle := false;
    for envItems
    {
        p := *player.position;
        if (it.blocking &&
            it.rect.x                 <= p.x &&
            it.rect.x + it.rect.width >= p.x &&
            it.rect.y                 >= p.y &&
            it.rect.y                 <= p.y + player.speed*delta)
        {
            hitObstacle = true;
            player.speed = 0.0;
            p.y = it.rect.y;
            break;
        }
    }

    if (!hitObstacle)
    {
        player.position.y += player.speed*delta;
        player.speed      += G*delta;
        player.canJump     = false;
    }
    else player.canJump = true;
}

UpateCameraType :: #type (camera: *Camera2D, player: *Player, envItems: [] EnvItem, delta: float, width: int, height: int);

UpdateCameraCenter :: (camera: *Camera2D, player: *Player, envItems: [] EnvItem, delta: float, width: int, height: int) {
    camera.offset = .{ width/2.0, height/2.0 };
    camera.target = player.position;
}

UpdateCameraCenterInsideMap :: (camera: *Camera2D, player: *Player, envItems: [] EnvItem, delta: float, width: int, height: int) {
    camera.target = player.position;
    camera.offset = .{ width/2.0, height/2.0 };
    minX :=  1000.0;
    minY :=  1000.0;
    maxX := -1000.0;
    maxY := -1000.0;

    for envItems {
        minX = Min(it.rect.x, minX);
        maxX = Max(it.rect.x + it.rect.width, maxX);
        minY = Min(it.rect.y, minY);
        maxY = Max(it.rect.y + it.rect.height, maxY);
    }

    max := GetWorldToScreen2D(Vector2.{ maxX, maxY }, camera);
    min := GetWorldToScreen2D(Vector2.{ minX, minY }, camera);

    if (max.x < xx width)  camera.offset.x = width    - (max.x - width/2);
    if (max.y < xx height) camera.offset.y = height   - (max.y - height/2);
    if (min.x > 0)         camera.offset.x = width/2  - min.x;
    if (min.y > 0)         camera.offset.y = height/2 - min.y;
}

UpdateCameraCenterSmoothFollow :: (camera: *Camera2D, player: *Player, envItems: [] EnvItem, delta: float, width: int, height: int) {
    MIN_SPEED         :: 30.0;
    MIN_EFFECT_LENGTH :: 10.0;
    FRACTION_SPEED    :: 0.8;

    camera.offset = .{ width/2.0, height/2.0 };
    diff   := Vector2Subtract(player.position, camera.target);
    length := Vector2Length(diff);

    if (length > MIN_EFFECT_LENGTH)
    {
        speed := max(FRACTION_SPEED*length, MIN_SPEED);
        camera.target = Vector2Add(camera.target, Vector2Scale(diff, speed*delta/length));
    }
}

eveningOut := false;
evenOutTarget: float;
UpdateCameraEvenOutOnLanding :: (camera: *Camera2D, player: *Player, envItems: [] EnvItem, delta: float, width: int, height: int) {
    EVEN_OUT_SPEED :: 700.0;

    camera.offset = .{ width/2.0, height/2.0 };
    camera.target.x = player.position.x;

    if (eveningOut)
    {
        if (evenOutTarget > camera.target.y)
        {
            camera.target.y += EVEN_OUT_SPEED*delta;

            if (camera.target.y > evenOutTarget)
            {
                camera.target.y = evenOutTarget;
                eveningOut = false;
            }
        }
        else
        {
            camera.target.y -= EVEN_OUT_SPEED*delta;

            if (camera.target.y < evenOutTarget)
            {
                camera.target.y = evenOutTarget;
                eveningOut = false;
            }
        }
    }
    else
    {
        if (player.canJump && (player.speed == 0) && (player.position.y != camera.target.y))
        {
            eveningOut = true;
            evenOutTarget = player.position.y;
        }
    }
}

UpdateCameraPlayerBoundsPush :: (camera: *Camera2D, player: *Player, envItems: [] EnvItem, delta: float, width: int, height: int)
{
    BBOX :: Vector2.{ 0.2, 0.2 };

    bboxWorldMin := GetScreenToWorld2D(Vector2.{ (1 - BBOX.x)*0.5*width, (1 - BBOX.y)*0.5*height }, camera);
    bboxWorldMax := GetScreenToWorld2D(Vector2.{ (1 + BBOX.x)*0.5*width, (1 + BBOX.y)*0.5*height }, camera);
    camera.offset = .{ (1 - BBOX.x)*0.5 * width, (1 - BBOX.y)*0.5*height };

    if (player.position.x < bboxWorldMin.x) camera.target.x = player.position.x;
    if (player.position.y < bboxWorldMin.y) camera.target.y = player.position.y;
    if (player.position.x > bboxWorldMax.x) camera.target.x = bboxWorldMin.x + (player.position.x - bboxWorldMax.x);
    if (player.position.y > bboxWorldMax.y) camera.target.y = bboxWorldMin.y + (player.position.y - bboxWorldMax.y);
}
