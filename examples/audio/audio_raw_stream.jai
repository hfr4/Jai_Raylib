/* ******************************************************************************************
*
*   raylib [audio] example - Raw audio streaming
*
*   Example originally created with raylib 1.6, last time updated with raylib 4.2
*
*   Example created by Ramon Santamaria (@raysan5) and reviewed by James Hofmann (@triplefox)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5) and James Hofmann (@triplefox)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

Math :: #import "Math";

MAX_SAMPLES            ::   512;
MAX_SAMPLES_PER_UPDATE ::  4096;

// Cycles per second (hz)
frequency := 440.0;

// Audio frequency, for smoothing
audioFrequency := 440.0;

// Previous value, used to test if sine needs to be rewritten, and to smoothly modulate frequency
oldFrequency := 1.0;

// Index for audio rendering
sineIdx := 0.0;

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [audio] example - raw audio streaming");

    InitAudioDevice();

    SetAudioStreamBufferSizeDefault(MAX_SAMPLES_PER_UPDATE);

    // Init raw audio stream (sample rate: 44100, sample size: 16bit-u16, channels: 1-mono)
    stream := LoadAudioStream(44100, 16, 1);

    SetAudioStreamCallback(stream, AudioInputCallback);

    // Buffer for the single cycle waveform we are synthesizing
    data := cast(*u16) alloc(MAX_SAMPLES * size_of(u16));

    // Frame buffer, describing the waveform when repeated over the course of a frame
    writeBuf := cast(*u16) alloc(MAX_SAMPLES_PER_UPDATE * size_of(u16));

    PlayAudioStream(stream);        // Start processing stream buffer (no data loaded currently)

    // Position read in to determine next frequency
    mousePosition := Vector2.{ -100.0, -100.0 };

    /*
    // Cycles per second (hz)
    frequency := 440.0;

    // Previous value, used to test if sine needs to be rewritten, and to smoothly modulate frequency
    oldFrequency := 1.0;

    // Cursor to read and copy the samples of the sine wave buffer
    readCursor := 0;
    */

    // Computed size in samples of the sine wave
    waveLength : s32 = 1;

    position := Vector2.{ 0, 0 };

    SetTargetFPS(30);


    while !WindowShouldClose() {

        // Sample mouse input.
        mousePosition = GetMousePosition();

        if (IsMouseButtonDown(xx MouseButton.LEFT))
        {
            fp := cast(float) (mousePosition.y);
            frequency = 40.0 + cast(float) (fp);

            pan := cast(float) (mousePosition.x) / cast(float) SCREEN_WIDTH;
            SetAudioStreamPan(stream, pan);
        }

        // Rewrite the sine wave
        // Compute two cycles to allow the buffer padding, simplifying any modulation, resampling, etc.
        if (frequency != oldFrequency)
        {
            // Compute wavelength. Limit size in both directions.
            //oldWavelength := waveLength;
            waveLength = cast(s32) (22050/frequency);
            if (waveLength > MAX_SAMPLES/2) waveLength = MAX_SAMPLES/2;
            if (waveLength < 1)             waveLength = 1;

            // Write sine wave
            for i: 0..waveLength * 2 - 1
            {
                data[i] = cast(u16) (Math.sin(((2*PI*cast(float) i/waveLength)))*32000);
            }
            // Make sure the rest of the line is flat
            for j: waveLength * 2..MAX_SAMPLES - 1
            {
                data[j] = cast(u16) 0;
            }

            // Scale read cursor's position to minimize transition artifacts
            //readCursor = cast(s32) (readCursor * (cast(float) waveLength / cast(float) oldWavelength));
            oldFrequency = frequency;
        }

        /*
        // Refill audio stream if required
        if (IsAudioStreamProcessed(stream))
        {
            // Synthesize a buffer that is exactly the requested size
            writeCursor := 0;

            while (writeCursor < MAX_SAMPLES_PER_UPDATE)
            {
                // Start by trying to write the whole chunk at once
                writeLength := MAX_SAMPLES_PER_UPDATE-writeCursor;

                // Limit to the maximum readable size
                readLength := waveLength-readCursor;

                if (writeLength > readLength) writeLength = readLength;

                // Write the slice
                memcpy(writeBuf + writeCursor, data + readCursor, writeLength*sizeof(u16));

                // Update cursors and loop audio
                readCursor = (readCursor + writeLength) % waveLength;

                writeCursor += writeLength;
            }

            // Copy finished frame to audio stream
            UpdateAudioStream(stream, writeBuf, MAX_SAMPLES_PER_UPDATE);
        }
        */

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawText(TextFormat("sine frequency: %",cast(s32) frequency), GetScreenWidth() - 220, 10, 20, RED);
            DrawText("click mouse button to change frequency or pan", 10, 10, 20, DARKGRAY);

            // Draw the current buffer state proportionate to the screen
            for i: 0..SCREEN_WIDTH - 1
            {
                position.x = cast(float) i;
                position.y = 250 + 50*data[i*MAX_SAMPLES/SCREEN_WIDTH]/32000.0;

                DrawPixelV(position, RED);
            }

        EndDrawing();
    }

    free(data);
    free(writeBuf);

    UnloadAudioStream(stream);   // Close raw audio stream and delete buffers from RAM
    CloseAudioDevice();

    CloseWindow();
}
// Audio input processing callback
AudioInputCallback :: (buffer: *void, frames: u32) #c_call {
    new_context: Context;
    push_context new_context {
        audioFrequency = frequency + (audioFrequency - frequency) * 0.95;

        incr := audioFrequency/44100.0;
        d    := cast(*u16) buffer;

        for i: 0..frames - 1 {
            d[i] = xx (32000.0 * Math.sin(2 * PI * sineIdx));
            sineIdx += incr;
            if (sineIdx > 1.0) sineIdx -= 1.0;
        }
    }
}
