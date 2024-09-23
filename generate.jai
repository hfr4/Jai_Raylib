#run build();

build :: () {
    set_build_options_dc(.{ do_output = false, write_added_strings = false });

    clone_raylib_and_raygui();
    compile_raylib();
    compile_raygui();
    create_module_folder();
    generate_bindings();
    build_examples();
}

clone_raylib_and_raygui :: () {
    if is_directory("vendors") delete_directory("vendors");
    make_directory_if_it_does_not_exist("vendors");

    print("Cloning Raylib 5.0 : ");
    result, output_string, error_string := run_command("git", "clone", "--depth", "1", "--branch", "5.0", "https://github.com/raysan5/raylib", "vendors/raylib", capture_and_return_output = true);
    if result.exit_code == 0 {
        print_color("SUCCESS\n", color=.GREEN);
    } else {
        print_color("FAILED\n", color=.RED);
        assert(false, "%", error_string);
    }

    print("Cloning Raygui 4.0 : ");
    result, output_string, error_string = run_command("git", "clone", "--depth", "1", "--branch", "4.0", "https://github.com/raysan5/raygui", "vendors/raygui", capture_and_return_output = true);
    if result.exit_code == 0 {
        print_color("SUCCESS\n", color=.GREEN);
    } else {
        print_color("FAILED\n", color=.RED);
        assert(false, "%", error_string);
    }
}

compile_raylib :: () {
    print("Compiling Raylib : \n\n");

    if is_directory("vendors/raylib/build") delete_directory("vendors/raylib/build");
    make_directory_if_it_does_not_exist("vendors/raylib/build");

    set_working_directory("vendors/raylib/build");

    // Configure CMake...
    run_command("cmake", "..", "-DBUILD_SHARED_LIBS=ON", "-DCMAKE_BUILD_TYPE=Release", "-DBUILD_EXAMPLES=FALSE");

    // Build the project...
    run_command("cmake", "--build", ".");

    set_working_directory(#filepath);

    print_color("SUCCESS\n", color=.GREEN);
}

compile_raygui :: () {
    print("Compiling Raygui : \n\n");

    if is_directory("vendors/raygui/build") delete_directory("vendors/raygui/build");
    make_directory_if_it_does_not_exist("vendors/raygui/build");

    // Look like we can't compile a single .h file...
    copy_file("vendors/raygui/src/raygui.h", "vendors/raygui/src/raygui.c");

    EXTRA :: string.[
        "/I" , "vendors/raylib/src/",
        "/D" , "_USRDLL",
        "/D" , "_WINDLL",
        "/D" , "_CRT_SECURE_NO_WARNINGS",
        "/D" , "RAYGUI_IMPLEMENTATION",
        "/D" , "BUILD_LIBTYPE_SHARED",
        "/wd", "4267",
    ];

    LIBRARY_FILES :: string.[
        "vendors/raylib/build/raylib/Debug/raylib.lib",
    ];

    ok := build_cpp_dynamic_lib("vendors/raygui/build/raygui", "vendors/raygui/src/raygui.c", extra = EXTRA, library_files = LIBRARY_FILES);

    print("\n");
    if ok {
        print_color("SUCCESS\n", color=.GREEN);
    } else {
        print_color("FAILED\n", color=.RED);
    }
}

create_module_folder :: () {
    if is_directory("Raylib") delete_directory("Raylib");
    make_directory_if_it_does_not_exist("Raylib");

    make_directory_if_it_does_not_exist("Raylib/lib");
    copy_file("vendors/raylib/build/raylib/Debug/raylib.dll", "Raylib/lib/raylib.dll");
    copy_file("vendors/raylib/build/raylib/Debug/raylib.lib", "Raylib/lib/raylib.lib");
    copy_file("vendors/raygui/build/raygui.dll"             , "Raylib/lib/raygui.dll");
    copy_file("vendors/raygui/build/raygui.lib"             , "Raylib/lib/raygui.lib");

    make_directory_if_it_does_not_exist("Raylib/include");
    copy_file("vendors/raylib/src/raylib.h" , "Raylib/include/raylib.h");
    copy_file("vendors/raylib/src/raymath.h", "Raylib/include/raymath.h");
    copy_file("vendors/raylib/src/rlgl.h"   , "Raylib/include/rlgl.h");
    copy_file("vendors/raygui/src/raygui.h" , "Raylib/include/raygui.h");
}

generate_bindings :: () {
    using options: Generate_Bindings_Options;
    strip_flags                         = 0;
    alias_original_enum_names           = false;
    c_enum_emulation                    = false;
    generate_library_declarations       = false;
    generate_printf_wrappers            = true;
    generate_compile_time_struct_checks = false;
    header                              = BINDINGS_HEADER;
    footer                              = BINDINGS_FOOTER;
    array_add(*libpaths     , "Raylib/lib");
    array_add(*libnames     , "raylib", "raygui");
    array_add(*include_paths, "Raylib/include");
    array_add(*source_files , "raylib.h", "raymath.h", "rlgl.h", "raygui.h");

    generate_bindings(options, "Raylib/module.jai");
}

build_examples :: () {
    for EXAMPLE_FOLDERS {
        bin_directory := tprint("examples/%/bin", it);
        make_directory_if_it_does_not_exist(bin_directory);
        copy_file("Raylib/lib/raylib.dll", tprint("%/raylib.dll", bin_directory));
        copy_file("Raylib/lib/raygui.dll", tprint("%/raygui.dll", bin_directory));

        resources_directory := tprint("%/resources", it);
        if is_directory(resources_directory) {
           copy_directory(resources_directory, tprint("%/resources", bin_directory));
        }
    }

    jai_path := get_path_of_running_executable();

    for EXAMPLE_FILES {
        file_path := tprint("examples/%", it);
        result, output_string, error_string := run_command(jai_path, file_path, "-import_dir", #filepath, "-output_path", "./bin", capture_and_return_output = true);

        print("% : ", it);
        if result.exit_code == 0 {
            print_color("SUCCESS", color=.GREEN);
        } else {
            print_color("FAILED", color=.RED);
            print("%", error_string);
        }
        print("\n");
    }
}

BINDINGS_HEADER :: #string DONE
va_list :: *void;

LIGHTGRAY  :: Color.{ 200, 200, 200, 255 };
GRAY       :: Color.{ 130, 130, 130, 255 };
DARKGRAY   :: Color.{ 80 , 80 , 80 , 255 };
YELLOW     :: Color.{ 253, 249, 0  , 255 };
GOLD       :: Color.{ 255, 203, 0  , 255 };
ORANGE     :: Color.{ 255, 161, 0  , 255 };
PINK       :: Color.{ 255, 109, 194, 255 };
RED        :: Color.{ 230, 41 , 55 , 255 };
MAROON     :: Color.{ 190, 33 , 55 , 255 };
GREEN      :: Color.{ 0  , 228, 48 , 255 };
LIME       :: Color.{ 0  , 158, 47 , 255 };
DARKGREEN  :: Color.{ 0  , 117, 44 , 255 };
SKYBLUE    :: Color.{ 102, 191, 255, 255 };
BLUE       :: Color.{ 0  , 121, 241, 255 };
DARKBLUE   :: Color.{ 0  , 82 , 172, 255 };
PURPLE     :: Color.{ 200, 122, 255, 255 };
VIOLET     :: Color.{ 135, 60 , 190, 255 };
DARKPURPLE :: Color.{ 112, 31 , 126, 255 };
BEIGE      :: Color.{ 211, 176, 131, 255 };
BROWN      :: Color.{ 127, 106, 79 , 255 };
DARKBROWN  :: Color.{ 76 , 63 , 47 , 255 };
WHITE      :: Color.{ 255, 255, 255, 255 };
BLACK      :: Color.{ 0  , 0  , 0  , 255 };
BLANK      :: Color.{ 0  , 0  , 0  , 0   };
MAGENTA    :: Color.{ 255, 0  , 255, 255 };
RAYWHITE   :: Color.{ 245, 245, 245, 255 };

MATERIAL_MAP_DIFFUSE    :: MaterialMapIndex.ALBEDO;
MATERIAL_MAP_SPECULAR   :: MaterialMapIndex.METALNESS;
SHADER_LOC_MAP_DIFFUSE  :: ShaderLocationIndex.MAP_ALBEDO;
SHADER_LOC_MAP_SPECULAR :: ShaderLocationIndex.MAP_METALNESS;
MOUSE_LEFT_BUTTON       :: MouseButton.LEFT;
MOUSE_RIGHT_BUTTON      :: MouseButton.RIGHT;
MOUSE_MIDDLE_BUTTON     :: MouseButton.MIDDLE;
DONE;

BINDINGS_FOOTER :: #string DONE
user32  :: #system_library,link_always "user32";
gdi32   :: #system_library,link_always "gdi32";
shell32 :: #system_library,link_always "shell32";
winmm   :: #system_library,link_always "winmm";

raylib :: #library "lib/raylib";
raygui :: #library "lib/raygui";
DONE;

EXAMPLE_FOLDERS :: string.[
    "audio",
    "core",
    "models",
    "shaders",
    "shapes",
    "text",
    "textures",
];

EXAMPLE_FILES :: string.[
    "audio/audio_mixed_processor.jai",
    "audio/audio_module_playing.jai",
    "audio/audio_music_stream.jai",
    "audio/audio_raw_stream.jai",
    "audio/audio_sound_loading.jai",
    "audio/audio_sound_multi.jai",
    "audio/audio_stream_effects.jai",

    "core/core_2d_camera_mouse_zoom.jai",
    "core/core_2d_camera_platformer.jai",
    "core/core_2d_camera_split_screen.jai",
    "core/core_2d_camera.jai",
    "core/core_3d_camera_first_person.jai",
    "core/core_3d_camera_free.jai",
    "core/core_3d_camera_mode.jai",
    "core/core_3d_camera_split_screen.jai",
    "core/core_3d_picking.jai",
    "core/core_automation_events.jai",
    "core/core_basic_screen_manager.jai",
    "core/core_basic_window_web.jai",
    "core/core_basic_window.jai",
    "core/core_custom_frame_control.jai",
    "core/core_custom_logging.jai",
    "core/core_drop_files.jai",
    "core/core_input_gamepad_info.jai",
    "core/core_input_gamepad.jai",
    "core/core_input_gestures_web.jai",
    "core/core_input_gestures.jai",
    "core/core_input_keys.jai",
    "core/core_input_mouse_wheel.jai",
    "core/core_input_mouse.jai",
    "core/core_input_multitouch.jai",
    // "core/core_loading_thread.jai", // TODO
    "core/core_random_values.jai",
    "core/core_scissor_test.jai",
    "core/core_smooth_pixelperfect.jai",
    "core/core_storage_values.jai", // TODO : saving/loading don't work
    "core/core_vr_simulator.jai",
    "core/core_window_flags.jai",
    "core/core_window_letterbox.jai",
    "core/core_window_should_close.jai",
    "core/core_world_screen.jai",

    "models/models_animation.jai",
    "models/models_billboard.jai",
    "models/models_box_collisions.jai",
    "models/models_cubicmap.jai",
    "models/models_draw_cube_texture.jai",
    "models/models_first_person_maze.jai",
    "models/models_geometric_shapes.jai",
    "models/models_heightmap.jai",
    "models/models_loading_gltf.jai",
    "models/models_loading_m3d.jai",
    "models/models_loading_vox.jai",
    "models/models_loading.jai",
    "models/models_mesh_generation.jai",
    "models/models_mesh_picking.jai",
    "models/models_orthographic_projection.jai",
    "models/models_rlgl_solar_system.jai",
    "models/models_skybox.jai",
    "models/models_waving_cubes.jai",
    "models/models_yaw_pitch_roll.jai",

    "shaders/shaders_basic_lighting.jai", // TODO : lights doesn't work
    "shaders/shaders_custom_uniform.jai",
    "shaders/shaders_deferred_render.jai", // TODO : shader don't work
    "shaders/shaders_eratosthenes.jai",
    "shaders/shaders_fog.jai",
    "shaders/shaders_hot_reloading.jai",
    "shaders/shaders_hybrid_render.jai",
    "shaders/shaders_julia_set.jai",
    "shaders/shaders_lightmap.jai", // TODO: ValidPointer error when closing window
    "shaders/shaders_mesh_instancing.jai",
    "shaders/shaders_model_shader.jai",
    "shaders/shaders_multi_sample2d.jai",
    "shaders/shaders_palette_switch.jai",
    "shaders/shaders_postprocessing.jai",
    "shaders/shaders_raymarching.jai",
    "shaders/shaders_shapes_textures.jai",
    "shaders/shaders_simple_mask.jai",
    "shaders/shaders_spotlight.jai",
    "shaders/shaders_texture_drawing.jai",
    "shaders/shaders_texture_outline.jai",
    "shaders/shaders_texture_tiling.jai",
    "shaders/shaders_texture_waves.jai",
    "shaders/shaders_write_depth.jai",

    "shapes/shapes_basic_shapes.jai",
    "shapes/shapes_bouncing_ball.jai",
    "shapes/shapes_collision_area.jai",
    "shapes/shapes_colors_palette.jai",
    "shapes/shapes_draw_circle_sector.jai",
    "shapes/shapes_draw_rectangle_rounded.jai",
    "shapes/shapes_draw_ring.jai",
    "shapes/shapes_easings_ball_anim.jai",
    "shapes/shapes_easings_box_anim.jai",
    "shapes/shapes_easings_rectangle_array.jai",
    "shapes/shapes_following_eyes.jai",
    "shapes/shapes_lines_bezier.jai",
    "shapes/shapes_logo_raylib_anim.jai",
    "shapes/shapes_logo_raylib.jai",
    "shapes/shapes_rectangle_scaling.jai",
    "shapes/shapes_splines_drawing.jai",
    "shapes/shapes_top_down_lights.jai",

    "text/text_codepoints_loading.jai",
    "text/text_draw_3d.jai",
    "text/text_font_filters.jai",
    "text/text_font_loading.jai",
    "text/text_font_sdf.jai",
    "text/text_font_spritefont.jai",
    "text/text_format_text.jai",
    "text/text_input_box.jai",
    "text/text_raylib_fonts.jai",
    "text/text_rectangle_bounds.jai",
    "text/text_unicode.jai",
    "text/text_writing_anim.jai",

    "textures/textures_background_scrolling.jai",
    "textures/textures_blend_modes.jai",
    "textures/textures_bunnymark.jai",
    "textures/textures_draw_tiled.jai",
    "textures/textures_fog_of_war.jai",
    "textures/textures_gif_player.jai",
    "textures/textures_image_drawing.jai",
    "textures/textures_image_generation.jai",
    "textures/textures_image_loading.jai",
    "textures/textures_image_processing.jai",
    "textures/textures_image_rotate.jai",
    "textures/textures_image_text.jai",
    "textures/textures_logo_raylib.jai",
    "textures/textures_mouse_painting.jai",
    "textures/textures_npatch_drawing.jai",
    "textures/textures_particles_blending.jai",
    "textures/textures_polygon.jai",
    "textures/textures_raw_data.jai", // TODO : problem with UnloadImage(checkedIm);
    "textures/textures_sprite_anim.jai",
    "textures/textures_sprite_button.jai",
    "textures/textures_sprite_explosion.jai",
    "textures/textures_srcrec_dstrec.jai",
    "textures/textures_svg_loading.jai",
    "textures/textures_textured_curve.jai",
    "textures/textures_to_image.jai",
];

#import "Basic";
#import "String";
#import "Compiler";
#import "File";
#import "File_Utilities";
#import "Bindings_Generator";
#import "System";
#import "Process";
#import "Print_Color";
#import "BuildCpp";
