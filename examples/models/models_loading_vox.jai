/* ******************************************************************************************
*
*   raylib [models] example - Load models vox (MagicaVoxel)
*
*   Example originally created with raylib 4.0, last time updated with raylib 4.0
*
*   Example contributed by Johann Nadalutti (@procfxgen) and reviewed by Ramon Santamaria (@raysan5)
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2021-2024 Johann Nadalutti (@procfxgen) and Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#import "Basic";
#import "Raylib";

#load "rlights.jai";


MAX_VOX_FILES ::  4;
GLSL_VERSION  ::  330;


main :: () {
	// Initialization
	SCREEN_WIDTH  :: 800;
	SCREEN_HEIGHT :: 450;

	voxFileNames := string.[
		"resources/models/vox/chr_knight.vox",
		"resources/models/vox/chr_sword.vox",
		"resources/models/vox/monu9.vox",
		"resources/models/vox/fez.vox"
	];

	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [models] example - magicavoxel loading");

	// Define the camera to look into our 3d world
	camera: Camera;
	camera.position   = .{ 10.0, 10.0, 10.0 };            // Camera position
	camera.target     = .{ 0.0, 0.0, 0.0 };               // Camera looking at point
	camera.up         = .{ 0.0, 1.0, 0.0 };               // Camera up vector (rotation towards target)
	camera.fovy       = 45.0;                             // Camera field-of-view Y
	camera.projection = xx CameraProjection.PERSPECTIVE;  // Camera projection type

	// Load MagicaVoxel files
	models: [MAX_VOX_FILES] Model;

	for i: 0..MAX_VOX_FILES - 1
	{
		// Load VOX file and measure time
		t0 := GetTime() * 1000.0;
		models[i] = LoadModel(voxFileNames[i].data);
		t1 := GetTime() * 1000.0;

		TraceLog_CFormat(xx TraceLogLevel.WARNING, TextFormat("[%] File loaded in % ms", voxFileNames[i], t1 - t0));

		// Compute model translation matrix to center model on draw position (0, 0 , 0)
		bb := GetModelBoundingBox(models[i]);
		center: Vector3;
		center.x = bb.min.x + (((bb.max.x - bb.min.x) / 2));
		center.z = bb.min.z + (((bb.max.z - bb.min.z) / 2));

		matTranslate := MatrixTranslate(-center.x, 0, -center.z);
		models[i].transform = matTranslate;
	}

	currentModel := 0;

	// Load voxel shader
	shader := LoadShader(TextFormat("resources/shaders/glsl%/voxel_lighting.vs", GLSL_VERSION),
		TextFormat("resources/shaders/glsl%/voxel_lighting.fs", GLSL_VERSION));

	// Get some required shader locations
	shader.locs[xx ShaderLocationIndex.VECTOR_VIEW] = GetShaderLocation(shader, "viewPos");
	// NOTE: "matModel" location name is automatically assigned on shader loading,
	// no need to get the location again if using that uniform name
	//shader.locs[xx ShaderLocationIndex.MATRIX_MODEL] = GetShaderLocation(shader, "matModel");

	// Ambient light level (some basic lighting)
	ambientLoc := GetShaderLocation(shader, "ambient");
	ambient := float.[ 0.1, 0.1, 0.1, 1.0 ];
	SetShaderValue(shader, ambientLoc, *ambient, xx ShaderUniformDataType.VEC4);

	// Assign out lighting shader to model
	for i: 0..MAX_VOX_FILES - 1
	{
		m := models[i];
		for j: 0..m.materialCount - 1
		{
			m.materials[j].shader = shader;
		}
	}

	// Create lights
	lights: [MAX_LIGHTS] Light;
	lights[0] = CreateLight(.POINT, .{ -20,  20, -20 }, Vector3Zero(), GRAY, *shader);
	lights[1] = CreateLight(.POINT, .{  20, -20,  20 }, Vector3Zero(), GRAY, *shader);
	lights[2] = CreateLight(.POINT, .{ -20,  20,  20 }, Vector3Zero(), GRAY, *shader);
	lights[3] = CreateLight(.POINT, .{  20, -20, -20 }, Vector3Zero(), GRAY, *shader);


	SetTargetFPS(60);

	modelpos:  Vector3;
	camerarot: Vector3;


	while (!WindowShouldClose())
	{

		if (IsMouseButtonDown(xx MouseButton.MIDDLE))
		{
			mouseDelta := GetMouseDelta();
			camerarot.x = mouseDelta.x * 0.05;
			camerarot.y = mouseDelta.y * 0.05;
		}
		else
		{
			camerarot.x = 0;
			camerarot.y = 0;
		}

		UpdateCameraPro(*camera,
			.{
				xx (IsKeyDown(xx KeyboardKey.W) || IsKeyDown(xx KeyboardKey.UP))  * 0.1 -      // Move forward-backward
				xx (IsKeyDown(xx KeyboardKey.S) || IsKeyDown(xx KeyboardKey.DOWN)) * 0.1,
				xx (IsKeyDown(xx KeyboardKey.D) || IsKeyDown(xx KeyboardKey.RIGHT)) * 0.1 -   // Move right-left
				xx (IsKeyDown(xx KeyboardKey.A) || IsKeyDown(xx KeyboardKey.LEFT)) * 0.1,
				0.0                                                // Move up-down
		},
			camerarot,
			GetMouseWheelMove() * -2.0);                              // Move to target (zoom)

		// Cycle between models on mouse click
		if (IsMouseButtonPressed(xx MouseButton.LEFT)) currentModel = (currentModel + 1) % MAX_VOX_FILES;

		// Update the shader with the camera view vector (points towards { 0.0, 0.0, 0.0 })
		cameraPos := float.[ camera.position.x, camera.position.y, camera.position.z ];
		SetShaderValue(shader, shader.locs[xx ShaderLocationIndex.VECTOR_VIEW], *cameraPos, xx ShaderUniformDataType.VEC3);

		// Update light values (actually, only enable/disable them)
		for i: 0..MAX_LIGHTS - 1 UpdateLightValues(*shader, lights[i]);

		// Draw

		BeginDrawing();

		ClearBackground(RAYWHITE);

		// Draw 3D model
		BeginMode3D(camera);

		DrawModel(models[currentModel], modelpos, 1.0, WHITE);
		DrawGrid(10, 1.0);

		// Draw spheres to show where the lights are
		for i: 0..MAX_LIGHTS - 1
		{
			if (lights[i].enabled) DrawSphereEx(lights[i].position, 0.2, 8, 8, lights[i].color);
			else                   DrawSphereWires(lights[i].position, 0.2, 8, 8, ColorAlpha(lights[i].color, 0.3));
		}

		EndMode3D();

		// Display info
		DrawRectangle(10, 400, 340, 60, Fade(SKYBLUE, 0.5));
		DrawRectangleLines(10, 400, 340, 60, Fade(DARKBLUE, 0.5));
		DrawText("MOUSE LEFT BUTTON to CYCLE VOX MODELS", 40, 410, 10, BLUE);
		DrawText("MOUSE MIDDLE BUTTON to ZOOM OR ROTATE CAMERA", 40, 420, 10, BLUE);
		DrawText("UP-DOWN-LEFT-RIGHT KEYS to MOVE CAMERA", 40, 430, 10, BLUE);
		DrawText(TextFormat("File: %", GetFileName(voxFileNames[currentModel].data)), 10, 10, 20, GRAY);

		EndDrawing();

	}


	for i: 0..MAX_VOX_FILES - 1 UnloadModel(models[i]);

	CloseWindow();
}


