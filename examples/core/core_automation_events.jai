/* ******************************************************************************************
*
*   raylib [core] example - automation events
*
*   Example originally created with raylib 5.0, last time updated with raylib 5.0
*
*   Example based on 2d_camera_platformer example by arvyy (@arvyy)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

GRAVITY         :: 400;
PLAYER_JUMP_SPD :: 350.0;
PLAYER_HOR_SPD  :: 200.0;

MAX_ENVIRONMENT_ELEMENTS :: 5;

Player :: struct {
    position: Vector2;
    speed:    float;
    canJump:  bool;
};

EnvElement :: struct {
    rect:     Rectangle;
    blocking: int;
    color:    Color;
};



main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - automation events");

    // Define player
    player: Player;
    player.position = .{ 400, 280 };
    player.speed    = 0;
    player.canJump  = false;

    // Define environment elements (platforms)
    envElements : [MAX_ENVIRONMENT_ELEMENTS]  EnvElement = .[
        .{ .{ 0  , 0  , 1000, 400 }, 0, LIGHTGRAY },
        .{ .{ 0  , 400, 1000, 200 }, 1, GRAY      },
        .{ .{ 300, 200, 400 , 10  }, 1, GRAY      },
        .{ .{ 250, 300, 100 , 10  }, 1, GRAY      },
        .{ .{ 650, 300, 100 , 10  }, 1, GRAY      },
    ];

    // Define camera
    camera: Camera2D;
    camera.target   = player.position;
    camera.offset   = .{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 };
    camera.rotation = 0.0;
    camera.zoom     = 1.0;

    // Automation events
    aelist := LoadAutomationEventList(null);  // Initialize list of automation events to record new events
    SetAutomationEventList(*aelist);
    eventRecording := false;
    eventPlaying   := false;

    frameCounter     : u8 = 0;
    playFrameCounter : u8 = 0;
    currentPlayFrame : u8 = 0;

    SetTargetFPS(60);

    while !WindowShouldClose() {

        deltaTime := 0.015;//GetFrameTime();

        // Dropped files logic

        if (IsFileDropped())
        {
            droppedFiles := LoadDroppedFiles();

            // Supports loading .rgs style files (text or binary) and .png style palette images
            if (IsFileExtension(droppedFiles.paths[0], ".txt;.rae"))
            {
                UnloadAutomationEventList(*aelist);
                aelist = LoadAutomationEventList(droppedFiles.paths[0]);

                eventRecording = false;

                // Reset scene state to play
                eventPlaying     = true;
                playFrameCounter = 0;
                currentPlayFrame = 0;

                player.position = .{ 400, 280 };
                player.speed    = 0;
                player.canJump  = false;

                camera.target   = player.position;
                camera.offset   = .{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 };
                camera.rotation = 0.0;
                camera.zoom     = 1.0;
            }

            UnloadDroppedFiles(droppedFiles);
        }


        // Update player

        if (IsKeyDown(xx KeyboardKey.LEFT))  player.position.x -= PLAYER_HOR_SPD*deltaTime;
        if (IsKeyDown(xx KeyboardKey.RIGHT)) player.position.x += PLAYER_HOR_SPD*deltaTime;
        if (IsKeyDown(xx KeyboardKey.SPACE) && player.canJump)
        {
            player.speed   = -PLAYER_JUMP_SPD;
            player.canJump = false;
        }

        hitObstacle := 0;
        for i: 0..MAX_ENVIRONMENT_ELEMENTS - 1
        {
            element := *envElements[i];
            p := *player.position;
            if (element.blocking &&
                element.rect.x <= p.x &&
                element.rect.x + element.rect.width >= p.x &&
                element.rect.y >= p.y &&
                element.rect.y <= p.y + player.speed*deltaTime)
            {
                hitObstacle  = 1;
                player.speed = 0.0;
                p.y          = element.rect.y;
            }
        }

        if (!hitObstacle)
        {
            player.position.y += player.speed*deltaTime;
            player.speed      += GRAVITY*deltaTime;
            player.canJump = false;
        }
        else player.canJump = true;

        if (IsKeyPressed(xx KeyboardKey.R))
        {
            // Reset game state
            player.position = .{ 400, 280 };
            player.speed    = 0;
            player.canJump  = false;

            camera.target   = player.position;
            camera.offset   = .{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 };
            camera.rotation = 0.0;
            camera.zoom     = 1.0;
        }


        // Events playing
        // NOTE: Logic must be before Camera update because it depends on mouse-wheel value,
        // that can be set by the played event... but some other inputs could be affected

        if (eventPlaying)
        {
            // NOTE: Multiple events could be executed in a single frame
            while (playFrameCounter == aelist.events[currentPlayFrame].frame)
            {
                PlayAutomationEvent(aelist.events[currentPlayFrame]);
                currentPlayFrame+= 1;

                if (currentPlayFrame == aelist.count)
                {
                    eventPlaying = false;
                    currentPlayFrame = 0;
                    playFrameCounter = 0;

                    TraceLog(xx TraceLogLevel.INFO, "FINISH PLAYING!");
                    break;
                }
            }

            playFrameCounter+= 1;
        }


        // Update camera

        camera.target = player.position;
        camera.offset = .{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 };
        minX :=  1000;
        minY :=  1000;
        maxX := -1000;
        maxY := -1000;

        // WARNING: On event replay, mouse-wheel internal value is set
        camera.zoom += (cast(float) GetMouseWheelMove()*0.05);
        if      (camera.zoom > 3.00) camera.zoom = 3.00;
        else if (camera.zoom < 0.25) camera.zoom = 0.25;

        for i: 0..MAX_ENVIRONMENT_ELEMENTS - 1
        {
            element := *envElements[i];
            minX = xx Min(element.rect.x                      , xx (minX) );
            maxX = xx Max(element.rect.x + element.rect.width , xx (maxX) );
            minY = xx Min(element.rect.y                      , xx (minY) );
            maxY = xx Max(element.rect.y + element.rect.height, xx (maxY) );
        }

        max := GetWorldToScreen2D(.{ xx maxX, xx maxY }, camera);
        min := GetWorldToScreen2D(.{ xx minX, xx minY }, camera);

        if (max.x < SCREEN_WIDTH)  camera.offset.x = SCREEN_WIDTH  - (max.x - SCREEN_WIDTH/2);
        if (max.y < SCREEN_HEIGHT) camera.offset.y = SCREEN_HEIGHT - (max.y - SCREEN_HEIGHT/2);
        if (min.x > 0)             camera.offset.x = SCREEN_WIDTH/2  - min.x;
        if (min.y > 0)             camera.offset.y = SCREEN_HEIGHT/2 - min.y;


        // Events management
        if (IsKeyPressed(xx KeyboardKey.S))    // Toggle events recording
        {
            if (!eventPlaying)
            {
                if (eventRecording)
                {
                    StopAutomationEventRecording();
                    eventRecording = false;

                    ExportAutomationEventList(aelist, "./automation.rae");

                    TraceLog(xx TraceLogLevel.INFO, "RECORDED FRAMES: %", aelist.count);
                }
                else
                {
                    SetAutomationEventBaseFrame(180);
                    StartAutomationEventRecording();
                    eventRecording = true;
                }
            }
        }
        else if (IsKeyPressed(xx KeyboardKey.A)) // Toggle events playing (WARNING: Starts next frame)
        {
            if (!eventRecording && (aelist.count > 0))
            {
                // Reset scene state to play
                eventPlaying = true;
                playFrameCounter = 0;
                currentPlayFrame = 0;

                player.position = .{ 400, 280 };
                player.speed = 0;
                player.canJump = false;

                camera.target = player.position;
                camera.offset = .{ SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 };
                camera.rotation = 0.0;
                camera.zoom = 1.0;
            }
        }

        if (eventRecording || eventPlaying) frameCounter+= 1;
        else frameCounter = 0;

        BeginDrawing();

            ClearBackground(LIGHTGRAY);

            BeginMode2D(camera);

                // Draw environment elements
                for i: 0..MAX_ENVIRONMENT_ELEMENTS - 1
                {
                    DrawRectangleRec(envElements[i].rect, envElements[i].color);
                }

                // Draw player rectangle
                DrawRectangleRec(.{ player.position.x - 20, player.position.y - 40, 40, 40 }, RED);

            EndMode2D();

            // Draw game controls
            DrawRectangle(10, 10, 290, 145, Fade(SKYBLUE, 0.5));
            DrawRectangleLines(10, 10, 290, 145, Fade(BLUE, 0.8));

            DrawText("Controls:", 20, 20, 10, BLACK);
            DrawText("- RIGHT | LEFT: Player movement", 30, 40, 10, DARKGRAY);
            DrawText("- SPACE: Player jump", 30, 60, 10, DARKGRAY);
            DrawText("- R: Reset game state", 30, 80, 10, DARKGRAY);

            DrawText("- S: START/STOP RECORDING INPUT EVENTS", 30, 110, 10, BLACK);
            DrawText("- A: REPLAY LAST RECORDED INPUT EVENTS", 30, 130, 10, BLACK);

            // Draw automation events recording indicator
            if (eventRecording)
            {
                DrawRectangle(10, 160, 290, 30, Fade(RED, 0.3));
                DrawRectangleLines(10, 160, 290, 30, Fade(MAROON, 0.8));
                DrawCircle(30, 175, 10, MAROON);

                if (((frameCounter/15)%2) == 1) DrawText(TextFormat("RECORDING EVENTS... [%]", aelist.count), 50, 170, 10, MAROON);
            }
            else if (eventPlaying)
            {
                DrawRectangle(10, 160, 290, 30, Fade(LIME, 0.3));
                DrawRectangleLines(10, 160, 290, 30, Fade(DARKGREEN, 0.8));
                DrawTriangle(.{ 20, 155 + 10 }, .{ 20, 155 + 30 }, .{ 40, 155 + 20 }, DARKGREEN);

                if (((frameCounter/15)%2) == 1) DrawText(TextFormat("PLAYING RECORDED EVENTS... [%]", currentPlayFrame), 50, 170, 10, DARKGREEN);
            }


        EndDrawing();
    }
    CloseWindow();
}