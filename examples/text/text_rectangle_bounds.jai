/* ******************************************************************************************
*
*   raylib [text] example - Rectangle bounds
*
*   Example originally created with raylib 2.5, last time updated with raylib 4.0
*
*   Example contributed by Vlad Adrian (@demizdor) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2018-2024 Vlad Adrian (@demizdor) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

main :: () {
    SCREEN_WIDTH  :: 800;
    SCREEN_HEIGHT :: 450;

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [text] example - draw text inside a rectangle");

    text := #string DONE
Text cannot escape    this container  ...word wrap also works when active so here's a long text for testing.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nec ullamcorper sit amet risus nullam eget felis eget.
DONE;

    resizing := false;
    wordWrap := true;

    container := Rectangle.{ 25.0, 25.0, SCREEN_WIDTH - 50.0, SCREEN_HEIGHT - 250.0 };
    resizer   := Rectangle.{ container.x + container.width - 17, container.y + container.height - 17, 14, 14 };

    // Minimum width and heigh for the container rectangle
    minWidth  : float32 = 60;
    minHeight : float32 = 60;
    maxWidth  : float32 = SCREEN_WIDTH  - 50.0;
    maxHeight : float32 = SCREEN_HEIGHT - 160.0;

    lastMouse   := Vector2.{ 0.0, 0.0 }; // Stores last mouse coordinates
    borderColor := MAROON;               // Container border color
    font        := GetFontDefault();    // Get default system font

    SetTargetFPS(60);

    while !WindowShouldClose() {

        if (IsKeyPressed(xx KeyboardKey.SPACE)) wordWrap = !wordWrap;

        mouse := GetMousePosition();

        // Check if the mouse is inside the container and toggle border color
        if (CheckCollisionPointRec(mouse, container)) borderColor = Fade(MAROON, 0.4);
        else if (!resizing)                           borderColor = MAROON;

        // Container resizing logic
        if (resizing)
        {
            if (IsMouseButtonReleased(xx MouseButton.LEFT)) resizing = false;

            width  := container.width + (mouse.x - lastMouse.x);
            height := container.height + (mouse.y - lastMouse.y);

            container.width  = ifx (width > minWidth)   then (ifx (width < maxWidth)   then width  else maxWidth)  else minWidth;
            container.height = ifx (height > minHeight) then (ifx (height < maxHeight) then height else maxHeight) else minHeight;
        }
        else
        {
            // Check if we're resizing
            if (IsMouseButtonDown(xx MouseButton.LEFT) && CheckCollisionPointRec(mouse, resizer)) resizing = true;
        }

        // Move resizer rectangle properly
        resizer.x = container.x + container.width  - 17;
        resizer.y = container.y + container.height - 17;

        lastMouse = mouse; // Update mouse

        BeginDrawing();

            ClearBackground(RAYWHITE);

            DrawRectangleLinesEx(container, 3, borderColor);    // Draw container border

            // Draw text in container (add some padding)
            DrawTextBoxed(font, text, Rectangle.{ container.x + 4, container.y + 4, container.width - 4, container.height - 4 }, 20.0, 2.0, wordWrap, GRAY);

            DrawRectangleRec(resizer, borderColor);             // Draw the resize box

            // Draw bottom info
            DrawRectangle(0, SCREEN_HEIGHT - 54, SCREEN_WIDTH, 54, GRAY);
            DrawRectangleRec(Rectangle.{ 382.0, SCREEN_HEIGHT - 34.0, 12.0, 12.0 }, MAROON);

            DrawText("Word Wrap: ", 313, SCREEN_HEIGHT-115, 20, BLACK);
            if (wordWrap) DrawText("ON", 447, SCREEN_HEIGHT - 115, 20, RED);
            else          DrawText("OFF", 447, SCREEN_HEIGHT - 115, 20, BLACK);

            DrawText("Press [SPACE] to toggle word wrap", 218, SCREEN_HEIGHT - 86, 20, GRAY);

            DrawText("Click hold & drag the    to resize the container", 155, SCREEN_HEIGHT - 38, 20, RAYWHITE);

        EndDrawing();
    }
    CloseWindow();
}


// Draw text using font inside rectangle limits
DrawTextBoxed :: (font: Font, text: string, rec: Rectangle, fontSize: float, spacing: float, wordWrap: bool, tint: Color)
{
    DrawTextBoxedSelectable(font, text, rec, fontSize, spacing, wordWrap, tint, 0, 0, WHITE, WHITE);
}

// Draw text using font inside rectangle limits with support for text selection
DrawTextBoxedSelectable :: (font: Font, text: string, rec: Rectangle, fontSize: float, spacing: float, wordWrap: bool, tint: Color, selectStart: int, selectLength: int, selectTint: Color, selectBackTint: Color)
{
    length := TextLength(text.data);  // Total length in bytes of the text, scanned by codepoints in loop

    textOffsetY := 0.0;       // Offset between lines (on line break '\n')
    textOffsetX := 0.0;       // Offset X to next character to draw

    scaleFactor := fontSize / cast(float) font.baseSize;     // Character rectangle scaling factor

    // Word/character wrapping mechanism variables
    State :: enum {
        MEASURE_STATE :: 0;
        DRAW_STATE    :: 1;
    }

    state : bool = ifx wordWrap then cast(bool) State.MEASURE_STATE else cast(bool) State.DRAW_STATE;

    startLine := -1;         // Index where to begin drawing (where a line begins)
    endLine   := -1;         // Index where to stop drawing (where a line ends)
    lastk     := -1;         // Holds last value of the character position

    i := 0;
    k := 0;
    while i < length
    {
        // Get next codepoint from byte string and glyph index in font
        codepointByteCount : s32 = 0;
        codepoint          := GetCodepoint(*text.data[i], *codepointByteCount);
        index              := GetGlyphIndex(font, codepoint);

        // NOTE: Normally we exit the decoding sequence as soon as a bad byte is found (and return 0x3)
        // but we need to draw all of the bad bytes using the '?' symbol moving one byte
        if (codepoint == 0x3) codepointByteCount = 1;
        i += (codepointByteCount - 1);

        glyphWidth := 0.0;
        if (codepoint != #char "\n")
        {
            glyphWidth = ifx (font.glyphs[index].advanceX == 0) then font.recs[index].width*scaleFactor else font.glyphs[index].advanceX*scaleFactor;

            if (i + 1 < length) glyphWidth = glyphWidth + spacing;
        }

        // NOTE: When wordWrap is ON we first measure how much of the text we can draw before going outside of the rec container
        // We store this info in startLine and endLine, then we change states, draw the text between those two variables
        // and change states again and again recursively until the end of the text (or until we get outside of the container).
        // When wordWrap is OFF we don't need the measure state so we go to the drawing state immediately
        // and begin drawing on the next line before we can get outside the container.
        if (state == cast(bool) State.MEASURE_STATE)
        {
            // TODO: There are multiple types of spaces in UNICODE, maybe it's a good idea to add support for more
            // Ref: http://jkorpela.fi/chars/spaces.html
            if ((codepoint == #char " ") || (codepoint == #char "\t") || (codepoint == #char "\n")) endLine = i;

            if ((textOffsetX + glyphWidth) > rec.width)
            {
                endLine = ifx (endLine < 1) then i else endLine;
                if (i == endLine)                                endLine -= codepointByteCount;
                if ((startLine + codepointByteCount) == endLine) endLine = (i - codepointByteCount);

                state = !state;
            }
            else if ((i + 1) == length)
            {
                endLine = i;
                state = !state;
            }
            else if (codepoint == #char "\n") state = !state;

            if (state == cast(bool) State.DRAW_STATE)
            {
                textOffsetX = 0;
                i = startLine;
                glyphWidth = 0;

                // Save character position when we switch states
                tmp := lastk;
                lastk = k - 1;
                k = tmp;
            }
        }
        else
        {
            if (codepoint == #char "\n")
            {
                if (!wordWrap)
                {
                    textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor;
                    textOffsetX = 0;
                }
            }
            else
            {
                if (!wordWrap && ((textOffsetX + glyphWidth) > rec.width))
                {
                    textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor;
                    textOffsetX = 0;
                }

                // When text overflows rectangle height limit, just stop drawing
                if ((textOffsetY + font.baseSize*scaleFactor) > rec.height) break;

                // Draw selection background
                isGlyphSelected := false;
                if ((selectStart >= 0) && (k >= selectStart) && (k < (selectStart + selectLength)))
                {
                    DrawRectangleRec(Rectangle.{ rec.x + textOffsetX - 1, rec.y + textOffsetY, glyphWidth, cast(float) font.baseSize*scaleFactor }, selectBackTint);
                    isGlyphSelected = true;
                }

                // Draw current character glyph
                if ((codepoint != #char " ") && (codepoint != #char "\t"))
                {
                    DrawTextCodepoint(font, codepoint, .{ rec.x + textOffsetX, rec.y + textOffsetY }, fontSize, ifx isGlyphSelected then selectTint else tint);
                }
            }

            if (wordWrap && (i == endLine))
            {
                textOffsetY += (font.baseSize + font.baseSize/2)*scaleFactor;
                textOffsetX = 0;
                startLine = endLine;
                endLine = -1;
                glyphWidth = 0;
                selectStart += lastk - k;
                k = lastk;

                state = !state;
            }
        }

        if ((textOffsetX != 0) || (codepoint != #char " ")) textOffsetX += glyphWidth;  // avoid leading spaces

        i += 1;
        k += 1;
    }
}
