//
// This file was auto-generated using the following command:
//
// jai generate.jai
//

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



RAYLIB_VERSION_MAJOR :: 5;
RAYLIB_VERSION_MINOR :: 0;
RAYLIB_VERSION_PATCH :: 0;
RAYLIB_VERSION :: "5.0";

PI :: 3.14159265358979323846;

DEG2RAD :: PI/180.0;

RAD2DEG :: 180.0/PI;

EPSILON :: 0.000001;

RLGL_VERSION :: "4.5";

RL_DEFAULT_BATCH_BUFFER_ELEMENTS :: 8192;

RL_DEFAULT_BATCH_BUFFERS :: 1;

RL_DEFAULT_BATCH_DRAWCALLS :: 256;

RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS :: 4;

RL_MAX_MATRIX_STACK_SIZE :: 32;

RL_MAX_SHADER_LOCATIONS :: 32;

RL_CULL_DISTANCE_NEAR :: 0.01;

RL_CULL_DISTANCE_FAR :: 1000.0;

RL_TEXTURE_WRAP_S :: 0x2802;
RL_TEXTURE_WRAP_T :: 0x2803;
RL_TEXTURE_MAG_FILTER :: 0x2800;
RL_TEXTURE_MIN_FILTER :: 0x2801;

RL_TEXTURE_FILTER_NEAREST :: 0x2600;
RL_TEXTURE_FILTER_LINEAR :: 0x2601;
RL_TEXTURE_FILTER_MIP_NEAREST :: 0x2700;
RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR :: 0x2702;
RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST :: 0x2701;
RL_TEXTURE_FILTER_MIP_LINEAR :: 0x2703;
RL_TEXTURE_FILTER_ANISOTROPIC :: 0x3000;
RL_TEXTURE_MIPMAP_BIAS_RATIO :: 0x4000;

RL_TEXTURE_WRAP_REPEAT :: 0x2901;
RL_TEXTURE_WRAP_CLAMP :: 0x812F;
RL_TEXTURE_WRAP_MIRROR_REPEAT :: 0x8370;
RL_TEXTURE_WRAP_MIRROR_CLAMP :: 0x8742;

RL_MODELVIEW :: 0x1700;
RL_PROJECTION :: 0x1701;
RL_TEXTURE :: 0x1702;

RL_LINES :: 0x0001;
RL_TRIANGLES :: 0x0004;
RL_QUADS :: 0x0007;

RL_UNSIGNED_BYTE :: 0x1401;
RL_FLOAT :: 0x1406;

RL_STREAM_DRAW :: 0x88E0;
RL_STREAM_READ :: 0x88E1;
RL_STREAM_COPY :: 0x88E2;
RL_STATIC_DRAW :: 0x88E4;
RL_STATIC_READ :: 0x88E5;
RL_STATIC_COPY :: 0x88E6;
RL_DYNAMIC_DRAW :: 0x88E8;
RL_DYNAMIC_READ :: 0x88E9;
RL_DYNAMIC_COPY :: 0x88EA;

RL_FRAGMENT_SHADER :: 0x8B30;
RL_VERTEX_SHADER :: 0x8B31;
RL_COMPUTE_SHADER :: 0x91B9;

RL_ZERO :: 0;
RL_ONE :: 1;
RL_SRC_COLOR :: 0x0300;
RL_ONE_MINUS_SRC_COLOR :: 0x0301;
RL_SRC_ALPHA :: 0x0302;
RL_ONE_MINUS_SRC_ALPHA :: 0x0303;
RL_DST_ALPHA :: 0x0304;
RL_ONE_MINUS_DST_ALPHA :: 0x0305;
RL_DST_COLOR :: 0x0306;
RL_ONE_MINUS_DST_COLOR :: 0x0307;
RL_SRC_ALPHA_SATURATE :: 0x0308;
RL_CONSTANT_COLOR :: 0x8001;
RL_ONE_MINUS_CONSTANT_COLOR :: 0x8002;
RL_CONSTANT_ALPHA :: 0x8003;
RL_ONE_MINUS_CONSTANT_ALPHA :: 0x8004;

RL_FUNC_ADD :: 0x8006;
RL_MIN :: 0x8007;
RL_MAX :: 0x8008;
RL_FUNC_SUBTRACT :: 0x800A;
RL_FUNC_REVERSE_SUBTRACT :: 0x800B;
RL_BLEND_EQUATION :: 0x8009;
RL_BLEND_EQUATION_RGB :: 0x8009;
RL_BLEND_EQUATION_ALPHA :: 0x883D;
RL_BLEND_DST_RGB :: 0x80C8;
RL_BLEND_SRC_RGB :: 0x80C9;
RL_BLEND_DST_ALPHA :: 0x80CA;
RL_BLEND_SRC_ALPHA :: 0x80CB;
RL_BLEND_COLOR :: 0x8005;

RAYGUI_VERSION_MAJOR :: 4;
RAYGUI_VERSION_MINOR :: 0;
RAYGUI_VERSION_PATCH :: 0;
RAYGUI_VERSION :: "4.0";

SCROLLBAR_LEFT_SIDE :: 0;
SCROLLBAR_RIGHT_SIDE :: 1;

Vector2 :: struct {
    x: float;
    y: float;
}

Vector3 :: struct {
    x: float;
    y: float;
    z: float;
}

Vector4 :: struct {
    x: float;
    y: float;
    z: float;
    w: float;
}

Quaternion :: Vector4;

Matrix :: struct {
    m0:  float;
    m4:  float;
    m8:  float;
    m12: float;
    m1:  float;
    m5:  float;
    m9:  float;
    m13: float;
    m2:  float;
    m6:  float;
    m10: float;
    m14: float;
    m3:  float;
    m7:  float;
    m11: float;
    m15: float;
}

Color :: struct {
    r: u8;
    g: u8;
    b: u8;
    a: u8;
}

Rectangle :: struct {
    x:      float;
    y:      float;
    width:  float;
    height: float;
}

Image :: struct {
    data:    *void;
    width:   s32;
    height:  s32;
    mipmaps: s32;
    format:  s32;
}

Texture :: struct {
    id:      u32;
    width:   s32;
    height:  s32;
    mipmaps: s32;
    format:  s32;
}

Texture2D :: Texture;

TextureCubemap :: Texture;

RenderTexture :: struct {
    id:      u32;
    texture: Texture;
    depth:   Texture;
}

RenderTexture2D :: RenderTexture;

NPatchInfo :: struct {
    source: Rectangle;
    left:   s32;
    top:    s32;
    right:  s32;
    bottom: s32;
    layout: s32;
}

GlyphInfo :: struct {
    value:    s32;
    offsetX:  s32;
    offsetY:  s32;
    advanceX: s32;
    image:    Image;
}

Font :: struct {
    baseSize:     s32;
    glyphCount:   s32;
    glyphPadding: s32;
    texture:      Texture2D;
    recs:         *Rectangle;
    glyphs:       *GlyphInfo;
}

Camera3D :: struct {
    position:   Vector3;
    target:     Vector3;
    up:         Vector3;
    fovy:       float;
    projection: s32;
}

Camera :: Camera3D;

Camera2D :: struct {
    offset:   Vector2;
    target:   Vector2;
    rotation: float;
    zoom:     float;
}

Mesh :: struct {
    vertexCount:   s32;
    triangleCount: s32;

    vertices:      *float;
    texcoords:     *float;
    texcoords2:    *float;
    normals:       *float;
    tangents:      *float;
    colors:        *u8;
    indices:       *u16;

    animVertices:  *float;
    animNormals:   *float;
    boneIds:       *u8;
    boneWeights:   *float;

    vaoId:         u32;
    vboId:         *u32;
}

Shader :: struct {
    id:   u32;
    locs: *s32;
}

MaterialMap :: struct {
    texture: Texture2D;
    color:   Color;
    value:   float;
}

Material :: struct {
    shader: Shader;
    maps:   *MaterialMap;
    params: [4] float;
}

Transform :: struct {
    translation: Vector3;
    rotation:    Quaternion;
    scale:       Vector3;
}

BoneInfo :: struct {
    name:   [32] u8;
    parent: s32;
}

Model :: struct {
    transform:     Matrix;

    meshCount:     s32;
    materialCount: s32;
    meshes:        *Mesh;
    materials:     *Material;
    meshMaterial:  *s32;

    boneCount:     s32;
    bones:         *BoneInfo;
    bindPose:      *Transform;
}

ModelAnimation :: struct {
    boneCount:  s32;
    frameCount: s32;
    bones:      *BoneInfo;
    framePoses: **Transform;
    name:       [32] u8;
}

Ray :: struct {
    position:  Vector3;
    direction: Vector3;
}

RayCollision :: struct {
    hit:      bool;
    distance: float;
    point:    Vector3;
    normal:   Vector3;
}

BoundingBox :: struct {
    min: Vector3;
    max: Vector3;
}

Wave :: struct {
    frameCount: u32;
    sampleRate: u32;
    sampleSize: u32;
    channels:   u32;
    data:       *void;
}

rAudioBuffer :: struct {}
rAudioProcessor :: struct {}

AudioStream :: struct {
    buffer:     *rAudioBuffer;
    processor:  *rAudioProcessor;

    sampleRate: u32;
    sampleSize: u32;
    channels:   u32;
}

Sound :: struct {
    stream:     AudioStream;
    frameCount: u32;
}

Music :: struct {
    stream:     AudioStream;
    frameCount: u32;
    looping:    bool;

    ctxType:    s32;
    ctxData:    *void;
}

VrDeviceInfo :: struct {
    hResolution:            s32;
    vResolution:            s32;
    hScreenSize:            float;
    vScreenSize:            float;
    vScreenCenter:          float;
    eyeToScreenDistance:    float;
    lensSeparationDistance: float;
    interpupillaryDistance: float;
    lensDistortionValues:   [4] float;
    chromaAbCorrection:     [4] float;
}

VrStereoConfig :: struct {
    projection:        [2] Matrix;
    viewOffset:        [2] Matrix;
    leftLensCenter:    [2] float;
    rightLensCenter:   [2] float;
    leftScreenCenter:  [2] float;
    rightScreenCenter: [2] float;
    scale:             [2] float;
    scaleIn:           [2] float;
}

FilePathList :: struct {
    capacity: u32;
    count:    u32;
    paths:    **u8;
}

AutomationEvent :: struct {
    frame:  u32;
    type:   u32;
    params: [4] s32;
}

AutomationEventList :: struct {
    capacity: u32;
    count:    u32;
    events:   *AutomationEvent;
}

ConfigFlags :: enum s32 {
    VSYNC_HINT               :: 64;
    FULLSCREEN_MODE          :: 2;
    WINDOW_RESIZABLE         :: 4;
    WINDOW_UNDECORATED       :: 8;
    WINDOW_HIDDEN            :: 128;
    WINDOW_MINIMIZED         :: 512;
    WINDOW_MAXIMIZED         :: 1024;
    WINDOW_UNFOCUSED         :: 2048;
    WINDOW_TOPMOST           :: 4096;
    WINDOW_ALWAYS_RUN        :: 256;
    WINDOW_TRANSPARENT       :: 16;
    WINDOW_HIGHDPI           :: 8192;
    WINDOW_MOUSE_PASSTHROUGH :: 16384;
    BORDERLESS_WINDOWED_MODE :: 32768;
    MSAA_4X_HINT             :: 32;
    INTERLACED_HINT          :: 65536;
}

TraceLogLevel :: enum s32 {
    ALL     :: 0;
    TRACE   :: 1;
    DEBUG   :: 2;
    INFO    :: 3;
    WARNING :: 4;
    ERROR   :: 5;
    FATAL   :: 6;
    NONE    :: 7;
}

KeyboardKey :: enum s32 {
    NULL          :: 0;

    APOSTROPHE    :: 39;
    COMMA         :: 44;
    MINUS         :: 45;
    PERIOD        :: 46;
    SLASH         :: 47;
    ZERO          :: 48;
    ONE           :: 49;
    TWO           :: 50;
    THREE         :: 51;
    FOUR          :: 52;
    FIVE          :: 53;
    SIX           :: 54;
    SEVEN         :: 55;
    EIGHT         :: 56;
    NINE          :: 57;
    SEMICOLON     :: 59;
    EQUAL         :: 61;
    A             :: 65;
    B             :: 66;
    C             :: 67;
    D             :: 68;
    E             :: 69;
    F             :: 70;
    G             :: 71;
    H             :: 72;
    I             :: 73;
    J             :: 74;
    K             :: 75;
    L             :: 76;
    M             :: 77;
    N             :: 78;
    O             :: 79;
    P             :: 80;
    Q             :: 81;
    R             :: 82;
    S             :: 83;
    T             :: 84;
    U             :: 85;
    V             :: 86;
    W             :: 87;
    X             :: 88;
    Y             :: 89;
    Z             :: 90;
    LEFT_BRACKET  :: 91;
    BACKSLASH     :: 92;
    RIGHT_BRACKET :: 93;
    GRAVE         :: 96;

    SPACE         :: 32;
    ESCAPE        :: 256;
    ENTER         :: 257;
    TAB           :: 258;
    BACKSPACE     :: 259;
    INSERT        :: 260;
    DELETE        :: 261;
    RIGHT         :: 262;
    LEFT          :: 263;
    DOWN          :: 264;
    UP            :: 265;
    PAGE_UP       :: 266;
    PAGE_DOWN     :: 267;
    HOME          :: 268;
    END           :: 269;
    CAPS_LOCK     :: 280;
    SCROLL_LOCK   :: 281;
    NUM_LOCK      :: 282;
    PRINT_SCREEN  :: 283;
    PAUSE         :: 284;
    F1            :: 290;
    F2            :: 291;
    F3            :: 292;
    F4            :: 293;
    F5            :: 294;
    F6            :: 295;
    F7            :: 296;
    F8            :: 297;
    F9            :: 298;
    F10           :: 299;
    F11           :: 300;
    F12           :: 301;
    LEFT_SHIFT    :: 340;
    LEFT_CONTROL  :: 341;
    LEFT_ALT      :: 342;
    LEFT_SUPER    :: 343;
    RIGHT_SHIFT   :: 344;
    RIGHT_CONTROL :: 345;
    RIGHT_ALT     :: 346;
    RIGHT_SUPER   :: 347;
    KB_MENU       :: 348;

    KP_0          :: 320;
    KP_1          :: 321;
    KP_2          :: 322;
    KP_3          :: 323;
    KP_4          :: 324;
    KP_5          :: 325;
    KP_6          :: 326;
    KP_7          :: 327;
    KP_8          :: 328;
    KP_9          :: 329;
    KP_DECIMAL    :: 330;
    KP_DIVIDE     :: 331;
    KP_MULTIPLY   :: 332;
    KP_SUBTRACT   :: 333;
    KP_ADD        :: 334;
    KP_ENTER      :: 335;
    KP_EQUAL      :: 336;

    BACK          :: 4;
    MENU          :: 82;
    VOLUME_UP     :: 24;
    VOLUME_DOWN   :: 25;
}

MouseButton :: enum s32 {
    LEFT    :: 0;
    RIGHT   :: 1;
    MIDDLE  :: 2;
    SIDE    :: 3;
    EXTRA   :: 4;
    FORWARD :: 5;
    BACK    :: 6;
}

MouseCursor :: enum s32 {
    DEFAULT       :: 0;
    ARROW         :: 1;
    IBEAM         :: 2;
    CROSSHAIR     :: 3;
    POINTING_HAND :: 4;
    RESIZE_EW     :: 5;
    RESIZE_NS     :: 6;
    RESIZE_NWSE   :: 7;
    RESIZE_NESW   :: 8;
    RESIZE_ALL    :: 9;
    NOT_ALLOWED   :: 10;
}

GamepadButton :: enum s32 {
    UNKNOWN          :: 0;
    LEFT_FACE_UP     :: 1;
    LEFT_FACE_RIGHT  :: 2;
    LEFT_FACE_DOWN   :: 3;
    LEFT_FACE_LEFT   :: 4;
    RIGHT_FACE_UP    :: 5;
    RIGHT_FACE_RIGHT :: 6;
    RIGHT_FACE_DOWN  :: 7;
    RIGHT_FACE_LEFT  :: 8;
    LEFT_TRIGGER_1   :: 9;
    LEFT_TRIGGER_2   :: 10;
    RIGHT_TRIGGER_1  :: 11;
    RIGHT_TRIGGER_2  :: 12;
    MIDDLE_LEFT      :: 13;
    MIDDLE           :: 14;
    MIDDLE_RIGHT     :: 15;
    LEFT_THUMB       :: 16;
    RIGHT_THUMB      :: 17;
}

GamepadAxis :: enum s32 {
    LEFT_X        :: 0;
    LEFT_Y        :: 1;
    RIGHT_X       :: 2;
    RIGHT_Y       :: 3;
    LEFT_TRIGGER  :: 4;
    RIGHT_TRIGGER :: 5;
}

MaterialMapIndex :: enum s32 {
    ALBEDO     :: 0;
    METALNESS  :: 1;
    NORMAL     :: 2;
    ROUGHNESS  :: 3;
    OCCLUSION  :: 4;
    EMISSION   :: 5;
    HEIGHT     :: 6;
    CUBEMAP    :: 7;
    IRRADIANCE :: 8;
    PREFILTER  :: 9;
    BRDF       :: 10;
}

ShaderLocationIndex :: enum s32 {
    VERTEX_POSITION   :: 0;
    VERTEX_TEXCOORD01 :: 1;
    VERTEX_TEXCOORD02 :: 2;
    VERTEX_NORMAL     :: 3;
    VERTEX_TANGENT    :: 4;
    VERTEX_COLOR      :: 5;
    MATRIX_MVP        :: 6;
    MATRIX_VIEW       :: 7;
    MATRIX_PROJECTION :: 8;
    MATRIX_MODEL      :: 9;
    MATRIX_NORMAL     :: 10;
    VECTOR_VIEW       :: 11;
    COLOR_DIFFUSE     :: 12;
    COLOR_SPECULAR    :: 13;
    COLOR_AMBIENT     :: 14;
    MAP_ALBEDO        :: 15;
    MAP_METALNESS     :: 16;
    MAP_NORMAL        :: 17;
    MAP_ROUGHNESS     :: 18;
    MAP_OCCLUSION     :: 19;
    MAP_EMISSION      :: 20;
    MAP_HEIGHT        :: 21;
    MAP_CUBEMAP       :: 22;
    MAP_IRRADIANCE    :: 23;
    MAP_PREFILTER     :: 24;
    MAP_BRDF          :: 25;
}

ShaderUniformDataType :: enum s32 {
    FLOAT     :: 0;
    VEC2      :: 1;
    VEC3      :: 2;
    VEC4      :: 3;
    INT       :: 4;
    IVEC2     :: 5;
    IVEC3     :: 6;
    IVEC4     :: 7;
    SAMPLER2D :: 8;
}

ShaderAttributeDataType :: enum s32 {
    FLOAT :: 0;
    VEC2  :: 1;
    VEC3  :: 2;
    VEC4  :: 3;
}

PixelFormat :: enum s32 {
    UNCOMPRESSED_GRAYSCALE    :: 1;
    UNCOMPRESSED_GRAY_ALPHA   :: 2;
    UNCOMPRESSED_R5G6B5       :: 3;
    UNCOMPRESSED_R8G8B8       :: 4;
    UNCOMPRESSED_R5G5B5A1     :: 5;
    UNCOMPRESSED_R4G4B4A4     :: 6;
    UNCOMPRESSED_R8G8B8A8     :: 7;
    UNCOMPRESSED_R32          :: 8;
    UNCOMPRESSED_R32G32B32    :: 9;
    UNCOMPRESSED_R32G32B32A32 :: 10;
    UNCOMPRESSED_R16          :: 11;
    UNCOMPRESSED_R16G16B16    :: 12;
    UNCOMPRESSED_R16G16B16A16 :: 13;
    COMPRESSED_DXT1_RGB       :: 14;
    COMPRESSED_DXT1_RGBA      :: 15;
    COMPRESSED_DXT3_RGBA      :: 16;
    COMPRESSED_DXT5_RGBA      :: 17;
    COMPRESSED_ETC1_RGB       :: 18;
    COMPRESSED_ETC2_RGB       :: 19;
    COMPRESSED_ETC2_EAC_RGBA  :: 20;
    COMPRESSED_PVRT_RGB       :: 21;
    COMPRESSED_PVRT_RGBA      :: 22;
    COMPRESSED_ASTC_4x4_RGBA  :: 23;
    COMPRESSED_ASTC_8x8_RGBA  :: 24;
}

TextureFilter :: enum s32 {
    POINT           :: 0;
    BILINEAR        :: 1;
    TRILINEAR       :: 2;
    ANISOTROPIC_4X  :: 3;
    ANISOTROPIC_8X  :: 4;
    ANISOTROPIC_16X :: 5;
}

TextureWrap :: enum s32 {
    REPEAT        :: 0;
    CLAMP         :: 1;
    MIRROR_REPEAT :: 2;
    MIRROR_CLAMP  :: 3;
}

CubemapLayout :: enum s32 {
    AUTO_DETECT         :: 0;
    LINE_VERTICAL       :: 1;
    LINE_HORIZONTAL     :: 2;
    CROSS_THREE_BY_FOUR :: 3;
    CROSS_FOUR_BY_THREE :: 4;
    PANORAMA            :: 5;
}

FontType :: enum s32 {
    DEFAULT :: 0;
    BITMAP  :: 1;
    SDF     :: 2;
}

BlendMode :: enum s32 {
    ALPHA             :: 0;
    ADDITIVE          :: 1;
    MULTIPLIED        :: 2;
    ADD_COLORS        :: 3;
    SUBTRACT_COLORS   :: 4;
    ALPHA_PREMULTIPLY :: 5;
    CUSTOM            :: 6;
    CUSTOM_SEPARATE   :: 7;
}

Gesture :: enum s32 {
    NONE        :: 0;
    TAP         :: 1;
    DOUBLETAP   :: 2;
    HOLD        :: 4;
    DRAG        :: 8;
    SWIPE_RIGHT :: 16;
    SWIPE_LEFT  :: 32;
    SWIPE_UP    :: 64;
    SWIPE_DOWN  :: 128;
    PINCH_IN    :: 256;
    PINCH_OUT   :: 512;
}

CameraMode :: enum s32 {
    CUSTOM       :: 0;
    FREE         :: 1;
    ORBITAL      :: 2;
    FIRST_PERSON :: 3;
    THIRD_PERSON :: 4;
}

CameraProjection :: enum s32 {
    PERSPECTIVE  :: 0;
    ORTHOGRAPHIC :: 1;
}

NPatchLayout :: enum s32 {
    NINE_PATCH             :: 0;
    THREE_PATCH_VERTICAL   :: 1;
    THREE_PATCH_HORIZONTAL :: 2;
}

TraceLogCallback :: #type (logLevel: s32, text: *u8, args: va_list) -> void #c_call;
LoadFileDataCallback :: #type (fileName: *u8, dataSize: *s32) -> *u8 #c_call;
SaveFileDataCallback :: #type (fileName: *u8, data: *void, dataSize: s32) -> bool #c_call;
LoadFileTextCallback :: #type (fileName: *u8) -> *u8 #c_call;
SaveFileTextCallback :: #type (fileName: *u8, text: *u8) -> bool #c_call;

InitWindow :: (width: s32, height: s32, title: *u8) -> void #foreign raylib;
CloseWindow :: () -> void #foreign raylib;
WindowShouldClose :: () -> bool #foreign raylib;
IsWindowReady :: () -> bool #foreign raylib;
IsWindowFullscreen :: () -> bool #foreign raylib;
IsWindowHidden :: () -> bool #foreign raylib;
IsWindowMinimized :: () -> bool #foreign raylib;
IsWindowMaximized :: () -> bool #foreign raylib;
IsWindowFocused :: () -> bool #foreign raylib;
IsWindowResized :: () -> bool #foreign raylib;
IsWindowState :: (flag: u32) -> bool #foreign raylib;
SetWindowState :: (flags: u32) -> void #foreign raylib;
ClearWindowState :: (flags: u32) -> void #foreign raylib;
ToggleFullscreen :: () -> void #foreign raylib;
ToggleBorderlessWindowed :: () -> void #foreign raylib;
MaximizeWindow :: () -> void #foreign raylib;
MinimizeWindow :: () -> void #foreign raylib;
RestoreWindow :: () -> void #foreign raylib;
SetWindowIcon :: (image: Image) -> void #foreign raylib;
SetWindowIcons :: (images: *Image, count: s32) -> void #foreign raylib;
SetWindowTitle :: (title: *u8) -> void #foreign raylib;
SetWindowPosition :: (x: s32, y: s32) -> void #foreign raylib;
SetWindowMonitor :: (monitor: s32) -> void #foreign raylib;
SetWindowMinSize :: (width: s32, height: s32) -> void #foreign raylib;
SetWindowMaxSize :: (width: s32, height: s32) -> void #foreign raylib;
SetWindowSize :: (width: s32, height: s32) -> void #foreign raylib;
SetWindowOpacity :: (opacity: float) -> void #foreign raylib;
SetWindowFocused :: () -> void #foreign raylib;
GetWindowHandle :: () -> *void #foreign raylib;
GetScreenWidth :: () -> s32 #foreign raylib;
GetScreenHeight :: () -> s32 #foreign raylib;
GetRenderWidth :: () -> s32 #foreign raylib;
GetRenderHeight :: () -> s32 #foreign raylib;
GetMonitorCount :: () -> s32 #foreign raylib;
GetCurrentMonitor :: () -> s32 #foreign raylib;
GetMonitorPosition :: (monitor: s32) -> Vector2 #foreign raylib;
GetMonitorWidth :: (monitor: s32) -> s32 #foreign raylib;
GetMonitorHeight :: (monitor: s32) -> s32 #foreign raylib;
GetMonitorPhysicalWidth :: (monitor: s32) -> s32 #foreign raylib;
GetMonitorPhysicalHeight :: (monitor: s32) -> s32 #foreign raylib;
GetMonitorRefreshRate :: (monitor: s32) -> s32 #foreign raylib;
GetWindowPosition :: () -> Vector2 #foreign raylib;
GetWindowScaleDPI :: () -> Vector2 #foreign raylib;
GetMonitorName :: (monitor: s32) -> *u8 #foreign raylib;
SetClipboardText :: (text: *u8) -> void #foreign raylib;
GetClipboardText :: () -> *u8 #foreign raylib;
EnableEventWaiting :: () -> void #foreign raylib;
DisableEventWaiting :: () -> void #foreign raylib;

ShowCursor :: () -> void #foreign raylib;
HideCursor :: () -> void #foreign raylib;
IsCursorHidden :: () -> bool #foreign raylib;
EnableCursor :: () -> void #foreign raylib;
DisableCursor :: () -> void #foreign raylib;
IsCursorOnScreen :: () -> bool #foreign raylib;

ClearBackground :: (color: Color) -> void #foreign raylib;
BeginDrawing :: () -> void #foreign raylib;
EndDrawing :: () -> void #foreign raylib;
BeginMode2D :: (camera: Camera2D) -> void #foreign raylib;
EndMode2D :: () -> void #foreign raylib;
BeginMode3D :: (camera: Camera3D) -> void #foreign raylib;
EndMode3D :: () -> void #foreign raylib;
BeginTextureMode :: (target: RenderTexture2D) -> void #foreign raylib;
EndTextureMode :: () -> void #foreign raylib;
BeginShaderMode :: (shader: Shader) -> void #foreign raylib;
EndShaderMode :: () -> void #foreign raylib;
BeginBlendMode :: (mode: s32) -> void #foreign raylib;
EndBlendMode :: () -> void #foreign raylib;
BeginScissorMode :: (x: s32, y: s32, width: s32, height: s32) -> void #foreign raylib;
EndScissorMode :: () -> void #foreign raylib;
BeginVrStereoMode :: (config: VrStereoConfig) -> void #foreign raylib;
EndVrStereoMode :: () -> void #foreign raylib;

LoadVrStereoConfig :: (device: VrDeviceInfo) -> VrStereoConfig #foreign raylib;
UnloadVrStereoConfig :: (config: VrStereoConfig) -> void #foreign raylib;

LoadShader :: (vsFileName: *u8, fsFileName: *u8) -> Shader #foreign raylib;
LoadShaderFromMemory :: (vsCode: *u8, fsCode: *u8) -> Shader #foreign raylib;
IsShaderReady :: (shader: Shader) -> bool #foreign raylib;
GetShaderLocation :: (shader: Shader, uniformName: *u8) -> s32 #foreign raylib;
GetShaderLocationAttrib :: (shader: Shader, attribName: *u8) -> s32 #foreign raylib;
SetShaderValue :: (shader: Shader, locIndex: s32, value: *void, uniformType: s32) -> void #foreign raylib;
SetShaderValueV :: (shader: Shader, locIndex: s32, value: *void, uniformType: s32, count: s32) -> void #foreign raylib;
SetShaderValueMatrix :: (shader: Shader, locIndex: s32, mat: Matrix) -> void #foreign raylib;
SetShaderValueTexture :: (shader: Shader, locIndex: s32, texture: Texture2D) -> void #foreign raylib;
UnloadShader :: (shader: Shader) -> void #foreign raylib;

GetMouseRay :: (mousePosition: Vector2, camera: Camera) -> Ray #foreign raylib;
GetCameraMatrix :: (camera: Camera) -> Matrix #foreign raylib;
GetCameraMatrix2D :: (camera: Camera2D) -> Matrix #foreign raylib;
GetWorldToScreen :: (position: Vector3, camera: Camera) -> Vector2 #foreign raylib;
GetScreenToWorld2D :: (position: Vector2, camera: Camera2D) -> Vector2 #foreign raylib;
GetWorldToScreenEx :: (position: Vector3, camera: Camera, width: s32, height: s32) -> Vector2 #foreign raylib;
GetWorldToScreen2D :: (position: Vector2, camera: Camera2D) -> Vector2 #foreign raylib;

SetTargetFPS :: (fps: s32) -> void #foreign raylib;
GetFrameTime :: () -> float #foreign raylib;
GetTime :: () -> float64 #foreign raylib;
GetFPS :: () -> s32 #foreign raylib;

SwapScreenBuffer :: () -> void #foreign raylib;
PollInputEvents :: () -> void #foreign raylib;
WaitTime :: (seconds: float64) -> void #foreign raylib;

SetRandomSeed :: (seed: u32) -> void #foreign raylib;
GetRandomValue :: (min: s32, max: s32) -> s32 #foreign raylib;
LoadRandomSequence :: (count: u32, min: s32, max: s32) -> *s32 #foreign raylib;
UnloadRandomSequence :: (sequence: *s32) -> void #foreign raylib;

TakeScreenshot :: (fileName: *u8) -> void #foreign raylib;
SetConfigFlags :: (flags: u32) -> void #foreign raylib;
OpenURL :: (url: *u8) -> void #foreign raylib;

TraceLog_CFormat :: (logLevel: s32, text: *u8, __args: ..Any) -> void #foreign raylib "TraceLog";
TraceLog :: (logLevel: s32, text: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, text, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    TraceLog_CFormat(logLevel, "%s", formatted_text.data);
} @PrintLike
SetTraceLogLevel :: (logLevel: s32) -> void #foreign raylib;
MemAlloc :: (size: u32) -> *void #foreign raylib;
MemRealloc :: (ptr: *void, size: u32) -> *void #foreign raylib;
MemFree :: (ptr: *void) -> void #foreign raylib;

SetTraceLogCallback :: (callback: TraceLogCallback) -> void #foreign raylib;
SetLoadFileDataCallback :: (callback: LoadFileDataCallback) -> void #foreign raylib;
SetSaveFileDataCallback :: (callback: SaveFileDataCallback) -> void #foreign raylib;
SetLoadFileTextCallback :: (callback: LoadFileTextCallback) -> void #foreign raylib;
SetSaveFileTextCallback :: (callback: SaveFileTextCallback) -> void #foreign raylib;

LoadFileData :: (fileName: *u8, dataSize: *s32) -> *u8 #foreign raylib;
UnloadFileData :: (data: *u8) -> void #foreign raylib;
SaveFileData :: (fileName: *u8, data: *void, dataSize: s32) -> bool #foreign raylib;
ExportDataAsCode :: (data: *u8, dataSize: s32, fileName: *u8) -> bool #foreign raylib;
LoadFileText :: (fileName: *u8) -> *u8 #foreign raylib;
UnloadFileText :: (text: *u8) -> void #foreign raylib;
SaveFileText :: (fileName: *u8, text: *u8) -> bool #foreign raylib;

FileExists :: (fileName: *u8) -> bool #foreign raylib;
DirectoryExists :: (dirPath: *u8) -> bool #foreign raylib;
IsFileExtension :: (fileName: *u8, ext: *u8) -> bool #foreign raylib;
GetFileLength :: (fileName: *u8) -> s32 #foreign raylib;
GetFileExtension :: (fileName: *u8) -> *u8 #foreign raylib;
GetFileName :: (filePath: *u8) -> *u8 #foreign raylib;
GetFileNameWithoutExt :: (filePath: *u8) -> *u8 #foreign raylib;
GetDirectoryPath :: (filePath: *u8) -> *u8 #foreign raylib;
GetPrevDirectoryPath :: (dirPath: *u8) -> *u8 #foreign raylib;
GetWorkingDirectory :: () -> *u8 #foreign raylib;
GetApplicationDirectory :: () -> *u8 #foreign raylib;
ChangeDirectory :: (dir: *u8) -> bool #foreign raylib;
IsPathFile :: (path: *u8) -> bool #foreign raylib;
LoadDirectoryFiles :: (dirPath: *u8) -> FilePathList #foreign raylib;
LoadDirectoryFilesEx :: (basePath: *u8, filter: *u8, scanSubdirs: bool) -> FilePathList #foreign raylib;
UnloadDirectoryFiles :: (files: FilePathList) -> void #foreign raylib;
IsFileDropped :: () -> bool #foreign raylib;
LoadDroppedFiles :: () -> FilePathList #foreign raylib;
UnloadDroppedFiles :: (files: FilePathList) -> void #foreign raylib;
GetFileModTime :: (fileName: *u8) -> s32 #foreign raylib;

CompressData :: (data: *u8, dataSize: s32, compDataSize: *s32) -> *u8 #foreign raylib;
DecompressData :: (compData: *u8, compDataSize: s32, dataSize: *s32) -> *u8 #foreign raylib;
EncodeDataBase64 :: (data: *u8, dataSize: s32, outputSize: *s32) -> *u8 #foreign raylib;
DecodeDataBase64 :: (data: *u8, outputSize: *s32) -> *u8 #foreign raylib;

LoadAutomationEventList :: (fileName: *u8) -> AutomationEventList #foreign raylib;
UnloadAutomationEventList :: (list: *AutomationEventList) -> void #foreign raylib;
ExportAutomationEventList :: (list: AutomationEventList, fileName: *u8) -> bool #foreign raylib;
SetAutomationEventList :: (list: *AutomationEventList) -> void #foreign raylib;
SetAutomationEventBaseFrame :: (frame: s32) -> void #foreign raylib;
StartAutomationEventRecording :: () -> void #foreign raylib;
StopAutomationEventRecording :: () -> void #foreign raylib;
PlayAutomationEvent :: (event: AutomationEvent) -> void #foreign raylib;

IsKeyPressed :: (key: s32) -> bool #foreign raylib;
IsKeyPressedRepeat :: (key: s32) -> bool #foreign raylib;
IsKeyDown :: (key: s32) -> bool #foreign raylib;
IsKeyReleased :: (key: s32) -> bool #foreign raylib;
IsKeyUp :: (key: s32) -> bool #foreign raylib;
GetKeyPressed :: () -> s32 #foreign raylib;
GetCharPressed :: () -> s32 #foreign raylib;
SetExitKey :: (key: s32) -> void #foreign raylib;

IsGamepadAvailable :: (gamepad: s32) -> bool #foreign raylib;
GetGamepadName :: (gamepad: s32) -> *u8 #foreign raylib;
IsGamepadButtonPressed :: (gamepad: s32, button: s32) -> bool #foreign raylib;
IsGamepadButtonDown :: (gamepad: s32, button: s32) -> bool #foreign raylib;
IsGamepadButtonReleased :: (gamepad: s32, button: s32) -> bool #foreign raylib;
IsGamepadButtonUp :: (gamepad: s32, button: s32) -> bool #foreign raylib;
GetGamepadButtonPressed :: () -> s32 #foreign raylib;
GetGamepadAxisCount :: (gamepad: s32) -> s32 #foreign raylib;
GetGamepadAxisMovement :: (gamepad: s32, axis: s32) -> float #foreign raylib;
SetGamepadMappings :: (mappings: *u8) -> s32 #foreign raylib;

IsMouseButtonPressed :: (button: s32) -> bool #foreign raylib;
IsMouseButtonDown :: (button: s32) -> bool #foreign raylib;
IsMouseButtonReleased :: (button: s32) -> bool #foreign raylib;
IsMouseButtonUp :: (button: s32) -> bool #foreign raylib;
GetMouseX :: () -> s32 #foreign raylib;
GetMouseY :: () -> s32 #foreign raylib;
GetMousePosition :: () -> Vector2 #foreign raylib;
GetMouseDelta :: () -> Vector2 #foreign raylib;
SetMousePosition :: (x: s32, y: s32) -> void #foreign raylib;
SetMouseOffset :: (offsetX: s32, offsetY: s32) -> void #foreign raylib;
SetMouseScale :: (scaleX: float, scaleY: float) -> void #foreign raylib;
GetMouseWheelMove :: () -> float #foreign raylib;
GetMouseWheelMoveV :: () -> Vector2 #foreign raylib;
SetMouseCursor :: (cursor: s32) -> void #foreign raylib;

GetTouchX :: () -> s32 #foreign raylib;
GetTouchY :: () -> s32 #foreign raylib;
GetTouchPosition :: (index: s32) -> Vector2 #foreign raylib;
GetTouchPointId :: (index: s32) -> s32 #foreign raylib;
GetTouchPointCount :: () -> s32 #foreign raylib;

SetGesturesEnabled :: (flags: u32) -> void #foreign raylib;
IsGestureDetected :: (gesture: u32) -> bool #foreign raylib;
GetGestureDetected :: () -> s32 #foreign raylib;
GetGestureHoldDuration :: () -> float #foreign raylib;
GetGestureDragVector :: () -> Vector2 #foreign raylib;
GetGestureDragAngle :: () -> float #foreign raylib;
GetGesturePinchVector :: () -> Vector2 #foreign raylib;
GetGesturePinchAngle :: () -> float #foreign raylib;

UpdateCamera :: (camera: *Camera, mode: s32) -> void #foreign raylib;
UpdateCameraPro :: (camera: *Camera, movement: Vector3, rotation: Vector3, zoom: float) -> void #foreign raylib;

SetShapesTexture :: (texture: Texture2D, source: Rectangle) -> void #foreign raylib;

DrawPixel :: (posX: s32, posY: s32, color: Color) -> void #foreign raylib;
DrawPixelV :: (position: Vector2, color: Color) -> void #foreign raylib;
DrawLine :: (startPosX: s32, startPosY: s32, endPosX: s32, endPosY: s32, color: Color) -> void #foreign raylib;
DrawLineV :: (startPos: Vector2, endPos: Vector2, color: Color) -> void #foreign raylib;
DrawLineEx :: (startPos: Vector2, endPos: Vector2, thick: float, color: Color) -> void #foreign raylib;
DrawLineStrip :: (points: *Vector2, pointCount: s32, color: Color) -> void #foreign raylib;
DrawLineBezier :: (startPos: Vector2, endPos: Vector2, thick: float, color: Color) -> void #foreign raylib;
DrawCircle :: (centerX: s32, centerY: s32, radius: float, color: Color) -> void #foreign raylib;
DrawCircleSector :: (center: Vector2, radius: float, startAngle: float, endAngle: float, segments: s32, color: Color) -> void #foreign raylib;
DrawCircleSectorLines :: (center: Vector2, radius: float, startAngle: float, endAngle: float, segments: s32, color: Color) -> void #foreign raylib;
DrawCircleGradient :: (centerX: s32, centerY: s32, radius: float, color1: Color, color2: Color) -> void #foreign raylib;
DrawCircleV :: (center: Vector2, radius: float, color: Color) -> void #foreign raylib;
DrawCircleLines :: (centerX: s32, centerY: s32, radius: float, color: Color) -> void #foreign raylib;
DrawCircleLinesV :: (center: Vector2, radius: float, color: Color) -> void #foreign raylib;
DrawEllipse :: (centerX: s32, centerY: s32, radiusH: float, radiusV: float, color: Color) -> void #foreign raylib;
DrawEllipseLines :: (centerX: s32, centerY: s32, radiusH: float, radiusV: float, color: Color) -> void #foreign raylib;
DrawRing :: (center: Vector2, innerRadius: float, outerRadius: float, startAngle: float, endAngle: float, segments: s32, color: Color) -> void #foreign raylib;
DrawRingLines :: (center: Vector2, innerRadius: float, outerRadius: float, startAngle: float, endAngle: float, segments: s32, color: Color) -> void #foreign raylib;
DrawRectangle :: (posX: s32, posY: s32, width: s32, height: s32, color: Color) -> void #foreign raylib;
DrawRectangleV :: (position: Vector2, size: Vector2, color: Color) -> void #foreign raylib;
DrawRectangleRec :: (rec: Rectangle, color: Color) -> void #foreign raylib;
DrawRectanglePro :: (rec: Rectangle, origin: Vector2, rotation: float, color: Color) -> void #foreign raylib;
DrawRectangleGradientV :: (posX: s32, posY: s32, width: s32, height: s32, color1: Color, color2: Color) -> void #foreign raylib;
DrawRectangleGradientH :: (posX: s32, posY: s32, width: s32, height: s32, color1: Color, color2: Color) -> void #foreign raylib;
DrawRectangleGradientEx :: (rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) -> void #foreign raylib;
DrawRectangleLines :: (posX: s32, posY: s32, width: s32, height: s32, color: Color) -> void #foreign raylib;
DrawRectangleLinesEx :: (rec: Rectangle, lineThick: float, color: Color) -> void #foreign raylib;
DrawRectangleRounded :: (rec: Rectangle, roundness: float, segments: s32, color: Color) -> void #foreign raylib;
DrawRectangleRoundedLines :: (rec: Rectangle, roundness: float, segments: s32, lineThick: float, color: Color) -> void #foreign raylib;
DrawTriangle :: (v1: Vector2, v2: Vector2, v3: Vector2, color: Color) -> void #foreign raylib;
DrawTriangleLines :: (v1: Vector2, v2: Vector2, v3: Vector2, color: Color) -> void #foreign raylib;
DrawTriangleFan :: (points: *Vector2, pointCount: s32, color: Color) -> void #foreign raylib;
DrawTriangleStrip :: (points: *Vector2, pointCount: s32, color: Color) -> void #foreign raylib;
DrawPoly :: (center: Vector2, sides: s32, radius: float, rotation: float, color: Color) -> void #foreign raylib;
DrawPolyLines :: (center: Vector2, sides: s32, radius: float, rotation: float, color: Color) -> void #foreign raylib;
DrawPolyLinesEx :: (center: Vector2, sides: s32, radius: float, rotation: float, lineThick: float, color: Color) -> void #foreign raylib;

DrawSplineLinear :: (points: *Vector2, pointCount: s32, thick: float, color: Color) -> void #foreign raylib;
DrawSplineBasis :: (points: *Vector2, pointCount: s32, thick: float, color: Color) -> void #foreign raylib;
DrawSplineCatmullRom :: (points: *Vector2, pointCount: s32, thick: float, color: Color) -> void #foreign raylib;
DrawSplineBezierQuadratic :: (points: *Vector2, pointCount: s32, thick: float, color: Color) -> void #foreign raylib;
DrawSplineBezierCubic :: (points: *Vector2, pointCount: s32, thick: float, color: Color) -> void #foreign raylib;
DrawSplineSegmentLinear :: (p1: Vector2, p2: Vector2, thick: float, color: Color) -> void #foreign raylib;
DrawSplineSegmentBasis :: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, thick: float, color: Color) -> void #foreign raylib;
DrawSplineSegmentCatmullRom :: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, thick: float, color: Color) -> void #foreign raylib;
DrawSplineSegmentBezierQuadratic :: (p1: Vector2, c2: Vector2, p3: Vector2, thick: float, color: Color) -> void #foreign raylib;
DrawSplineSegmentBezierCubic :: (p1: Vector2, c2: Vector2, c3: Vector2, p4: Vector2, thick: float, color: Color) -> void #foreign raylib;

GetSplinePointLinear :: (startPos: Vector2, endPos: Vector2, t: float) -> Vector2 #foreign raylib;
GetSplinePointBasis :: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: float) -> Vector2 #foreign raylib;
GetSplinePointCatmullRom :: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: float) -> Vector2 #foreign raylib;
GetSplinePointBezierQuad :: (p1: Vector2, c2: Vector2, p3: Vector2, t: float) -> Vector2 #foreign raylib;
GetSplinePointBezierCubic :: (p1: Vector2, c2: Vector2, c3: Vector2, p4: Vector2, t: float) -> Vector2 #foreign raylib;

CheckCollisionRecs :: (rec1: Rectangle, rec2: Rectangle) -> bool #foreign raylib;
CheckCollisionCircles :: (center1: Vector2, radius1: float, center2: Vector2, radius2: float) -> bool #foreign raylib;
CheckCollisionCircleRec :: (center: Vector2, radius: float, rec: Rectangle) -> bool #foreign raylib;
CheckCollisionPointRec :: (point: Vector2, rec: Rectangle) -> bool #foreign raylib;
CheckCollisionPointCircle :: (point: Vector2, center: Vector2, radius: float) -> bool #foreign raylib;
CheckCollisionPointTriangle :: (point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) -> bool #foreign raylib;
CheckCollisionPointPoly :: (point: Vector2, points: *Vector2, pointCount: s32) -> bool #foreign raylib;
CheckCollisionLines :: (startPos1: Vector2, endPos1: Vector2, startPos2: Vector2, endPos2: Vector2, collisionPoint: *Vector2) -> bool #foreign raylib;
CheckCollisionPointLine :: (point: Vector2, p1: Vector2, p2: Vector2, threshold: s32) -> bool #foreign raylib;
GetCollisionRec :: (rec1: Rectangle, rec2: Rectangle) -> Rectangle #foreign raylib;

LoadImage :: (fileName: *u8) -> Image #foreign raylib;
LoadImageRaw :: (fileName: *u8, width: s32, height: s32, format: s32, headerSize: s32) -> Image #foreign raylib;
LoadImageSvg :: (fileNameOrString: *u8, width: s32, height: s32) -> Image #foreign raylib;
LoadImageAnim :: (fileName: *u8, frames: *s32) -> Image #foreign raylib;
LoadImageFromMemory :: (fileType: *u8, fileData: *u8, dataSize: s32) -> Image #foreign raylib;
LoadImageFromTexture :: (texture: Texture2D) -> Image #foreign raylib;
LoadImageFromScreen :: () -> Image #foreign raylib;
IsImageReady :: (image: Image) -> bool #foreign raylib;
UnloadImage :: (image: Image) -> void #foreign raylib;
ExportImage :: (image: Image, fileName: *u8) -> bool #foreign raylib;
ExportImageToMemory :: (image: Image, fileType: *u8, fileSize: *s32) -> *u8 #foreign raylib;
ExportImageAsCode :: (image: Image, fileName: *u8) -> bool #foreign raylib;

GenImageColor :: (width: s32, height: s32, color: Color) -> Image #foreign raylib;
GenImageGradientLinear :: (width: s32, height: s32, direction: s32, start: Color, end: Color) -> Image #foreign raylib;
GenImageGradientRadial :: (width: s32, height: s32, density: float, inner: Color, outer: Color) -> Image #foreign raylib;
GenImageGradientSquare :: (width: s32, height: s32, density: float, inner: Color, outer: Color) -> Image #foreign raylib;
GenImageChecked :: (width: s32, height: s32, checksX: s32, checksY: s32, col1: Color, col2: Color) -> Image #foreign raylib;
GenImageWhiteNoise :: (width: s32, height: s32, factor: float) -> Image #foreign raylib;
GenImagePerlinNoise :: (width: s32, height: s32, offsetX: s32, offsetY: s32, scale: float) -> Image #foreign raylib;
GenImageCellular :: (width: s32, height: s32, tileSize: s32) -> Image #foreign raylib;
GenImageText :: (width: s32, height: s32, text: *u8) -> Image #foreign raylib;

ImageCopy :: (image: Image) -> Image #foreign raylib;
ImageFromImage :: (image: Image, rec: Rectangle) -> Image #foreign raylib;
ImageText :: (text: *u8, fontSize: s32, color: Color) -> Image #foreign raylib;
ImageTextEx :: (font: Font, text: *u8, fontSize: float, spacing: float, tint: Color) -> Image #foreign raylib;
ImageFormat :: (image: *Image, newFormat: s32) -> void #foreign raylib;
ImageToPOT :: (image: *Image, fill: Color) -> void #foreign raylib;
ImageCrop :: (image: *Image, crop: Rectangle) -> void #foreign raylib;
ImageAlphaCrop :: (image: *Image, threshold: float) -> void #foreign raylib;
ImageAlphaClear :: (image: *Image, color: Color, threshold: float) -> void #foreign raylib;
ImageAlphaMask :: (image: *Image, alphaMask: Image) -> void #foreign raylib;
ImageAlphaPremultiply :: (image: *Image) -> void #foreign raylib;
ImageBlurGaussian :: (image: *Image, blurSize: s32) -> void #foreign raylib;
ImageResize :: (image: *Image, newWidth: s32, newHeight: s32) -> void #foreign raylib;
ImageResizeNN :: (image: *Image, newWidth: s32, newHeight: s32) -> void #foreign raylib;
ImageResizeCanvas :: (image: *Image, newWidth: s32, newHeight: s32, offsetX: s32, offsetY: s32, fill: Color) -> void #foreign raylib;
ImageMipmaps :: (image: *Image) -> void #foreign raylib;
ImageDither :: (image: *Image, rBpp: s32, gBpp: s32, bBpp: s32, aBpp: s32) -> void #foreign raylib;
ImageFlipVertical :: (image: *Image) -> void #foreign raylib;
ImageFlipHorizontal :: (image: *Image) -> void #foreign raylib;
ImageRotate :: (image: *Image, degrees: s32) -> void #foreign raylib;
ImageRotateCW :: (image: *Image) -> void #foreign raylib;
ImageRotateCCW :: (image: *Image) -> void #foreign raylib;
ImageColorTint :: (image: *Image, color: Color) -> void #foreign raylib;
ImageColorInvert :: (image: *Image) -> void #foreign raylib;
ImageColorGrayscale :: (image: *Image) -> void #foreign raylib;
ImageColorContrast :: (image: *Image, contrast: float) -> void #foreign raylib;
ImageColorBrightness :: (image: *Image, brightness: s32) -> void #foreign raylib;
ImageColorReplace :: (image: *Image, color: Color, replace: Color) -> void #foreign raylib;
LoadImageColors :: (image: Image) -> *Color #foreign raylib;
LoadImagePalette :: (image: Image, maxPaletteSize: s32, colorCount: *s32) -> *Color #foreign raylib;
UnloadImageColors :: (colors: *Color) -> void #foreign raylib;
UnloadImagePalette :: (colors: *Color) -> void #foreign raylib;
GetImageAlphaBorder :: (image: Image, threshold: float) -> Rectangle #foreign raylib;
GetImageColor :: (image: Image, x: s32, y: s32) -> Color #foreign raylib;

ImageClearBackground :: (dst: *Image, color: Color) -> void #foreign raylib;
ImageDrawPixel :: (dst: *Image, posX: s32, posY: s32, color: Color) -> void #foreign raylib;
ImageDrawPixelV :: (dst: *Image, position: Vector2, color: Color) -> void #foreign raylib;
ImageDrawLine :: (dst: *Image, startPosX: s32, startPosY: s32, endPosX: s32, endPosY: s32, color: Color) -> void #foreign raylib;
ImageDrawLineV :: (dst: *Image, start: Vector2, end: Vector2, color: Color) -> void #foreign raylib;
ImageDrawCircle :: (dst: *Image, centerX: s32, centerY: s32, radius: s32, color: Color) -> void #foreign raylib;
ImageDrawCircleV :: (dst: *Image, center: Vector2, radius: s32, color: Color) -> void #foreign raylib;
ImageDrawCircleLines :: (dst: *Image, centerX: s32, centerY: s32, radius: s32, color: Color) -> void #foreign raylib;
ImageDrawCircleLinesV :: (dst: *Image, center: Vector2, radius: s32, color: Color) -> void #foreign raylib;
ImageDrawRectangle :: (dst: *Image, posX: s32, posY: s32, width: s32, height: s32, color: Color) -> void #foreign raylib;
ImageDrawRectangleV :: (dst: *Image, position: Vector2, size: Vector2, color: Color) -> void #foreign raylib;
ImageDrawRectangleRec :: (dst: *Image, rec: Rectangle, color: Color) -> void #foreign raylib;
ImageDrawRectangleLines :: (dst: *Image, rec: Rectangle, thick: s32, color: Color) -> void #foreign raylib;
ImageDraw :: (dst: *Image, src: Image, srcRec: Rectangle, dstRec: Rectangle, tint: Color) -> void #foreign raylib;
ImageDrawText :: (dst: *Image, text: *u8, posX: s32, posY: s32, fontSize: s32, color: Color) -> void #foreign raylib;
ImageDrawTextEx :: (dst: *Image, font: Font, text: *u8, position: Vector2, fontSize: float, spacing: float, tint: Color) -> void #foreign raylib;

LoadTexture :: (fileName: *u8) -> Texture2D #foreign raylib;
LoadTextureFromImage :: (image: Image) -> Texture2D #foreign raylib;
LoadTextureCubemap :: (image: Image, layout: s32) -> TextureCubemap #foreign raylib;
LoadRenderTexture :: (width: s32, height: s32) -> RenderTexture2D #foreign raylib;
IsTextureReady :: (texture: Texture2D) -> bool #foreign raylib;
UnloadTexture :: (texture: Texture2D) -> void #foreign raylib;
IsRenderTextureReady :: (target: RenderTexture2D) -> bool #foreign raylib;
UnloadRenderTexture :: (target: RenderTexture2D) -> void #foreign raylib;
UpdateTexture :: (texture: Texture2D, pixels: *void) -> void #foreign raylib;
UpdateTextureRec :: (texture: Texture2D, rec: Rectangle, pixels: *void) -> void #foreign raylib;

GenTextureMipmaps :: (texture: *Texture2D) -> void #foreign raylib;
SetTextureFilter :: (texture: Texture2D, filter: s32) -> void #foreign raylib;
SetTextureWrap :: (texture: Texture2D, wrap: s32) -> void #foreign raylib;

DrawTexture :: (texture: Texture2D, posX: s32, posY: s32, tint: Color) -> void #foreign raylib;
DrawTextureV :: (texture: Texture2D, position: Vector2, tint: Color) -> void #foreign raylib;
DrawTextureEx :: (texture: Texture2D, position: Vector2, rotation: float, scale: float, tint: Color) -> void #foreign raylib;
DrawTextureRec :: (texture: Texture2D, source: Rectangle, position: Vector2, tint: Color) -> void #foreign raylib;
DrawTexturePro :: (texture: Texture2D, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: float, tint: Color) -> void #foreign raylib;
DrawTextureNPatch :: (texture: Texture2D, nPatchInfo: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: float, tint: Color) -> void #foreign raylib;

Fade :: (color: Color, alpha: float) -> Color #foreign raylib;
ColorToInt :: (color: Color) -> s32 #foreign raylib;
ColorNormalize :: (color: Color) -> Vector4 #foreign raylib;
ColorFromNormalized :: (normalized: Vector4) -> Color #foreign raylib;
ColorToHSV :: (color: Color) -> Vector3 #foreign raylib;
ColorFromHSV :: (hue: float, saturation: float, value: float) -> Color #foreign raylib;
ColorTint :: (color: Color, tint: Color) -> Color #foreign raylib;
ColorBrightness :: (color: Color, factor: float) -> Color #foreign raylib;
ColorContrast :: (color: Color, contrast: float) -> Color #foreign raylib;
ColorAlpha :: (color: Color, alpha: float) -> Color #foreign raylib;
ColorAlphaBlend :: (dst: Color, src: Color, tint: Color) -> Color #foreign raylib;
GetColor :: (hexValue: u32) -> Color #foreign raylib;
GetPixelColor :: (srcPtr: *void, format: s32) -> Color #foreign raylib;
SetPixelColor :: (dstPtr: *void, color: Color, format: s32) -> void #foreign raylib;
GetPixelDataSize :: (width: s32, height: s32, format: s32) -> s32 #foreign raylib;

GetFontDefault :: () -> Font #foreign raylib;
LoadFont :: (fileName: *u8) -> Font #foreign raylib;
LoadFontEx :: (fileName: *u8, fontSize: s32, codepoints: *s32, codepointCount: s32) -> Font #foreign raylib;
LoadFontFromImage :: (image: Image, key: Color, firstChar: s32) -> Font #foreign raylib;
LoadFontFromMemory :: (fileType: *u8, fileData: *u8, dataSize: s32, fontSize: s32, codepoints: *s32, codepointCount: s32) -> Font #foreign raylib;
IsFontReady :: (font: Font) -> bool #foreign raylib;
LoadFontData :: (fileData: *u8, dataSize: s32, fontSize: s32, codepoints: *s32, codepointCount: s32, type: s32) -> *GlyphInfo #foreign raylib;
GenImageFontAtlas :: (glyphs: *GlyphInfo, glyphRecs: **Rectangle, glyphCount: s32, fontSize: s32, padding: s32, packMethod: s32) -> Image #foreign raylib;
UnloadFontData :: (glyphs: *GlyphInfo, glyphCount: s32) -> void #foreign raylib;
UnloadFont :: (font: Font) -> void #foreign raylib;
ExportFontAsCode :: (font: Font, fileName: *u8) -> bool #foreign raylib;

DrawFPS :: (posX: s32, posY: s32) -> void #foreign raylib;
DrawText :: (text: *u8, posX: s32, posY: s32, fontSize: s32, color: Color) -> void #foreign raylib;
DrawTextEx :: (font: Font, text: *u8, position: Vector2, fontSize: float, spacing: float, tint: Color) -> void #foreign raylib;
DrawTextPro :: (font: Font, text: *u8, position: Vector2, origin: Vector2, rotation: float, fontSize: float, spacing: float, tint: Color) -> void #foreign raylib;
DrawTextCodepoint :: (font: Font, codepoint: s32, position: Vector2, fontSize: float, tint: Color) -> void #foreign raylib;
DrawTextCodepoints :: (font: Font, codepoints: *s32, codepointCount: s32, position: Vector2, fontSize: float, spacing: float, tint: Color) -> void #foreign raylib;

SetTextLineSpacing :: (spacing: s32) -> void #foreign raylib;
MeasureText :: (text: *u8, fontSize: s32) -> s32 #foreign raylib;
MeasureTextEx :: (font: Font, text: *u8, fontSize: float, spacing: float) -> Vector2 #foreign raylib;
GetGlyphIndex :: (font: Font, codepoint: s32) -> s32 #foreign raylib;
GetGlyphInfo :: (font: Font, codepoint: s32) -> GlyphInfo #foreign raylib;
GetGlyphAtlasRec :: (font: Font, codepoint: s32) -> Rectangle #foreign raylib;

LoadUTF8 :: (codepoints: *s32, length: s32) -> *u8 #foreign raylib;
UnloadUTF8 :: (text: *u8) -> void #foreign raylib;
LoadCodepoints :: (text: *u8, count: *s32) -> *s32 #foreign raylib;
UnloadCodepoints :: (codepoints: *s32) -> void #foreign raylib;
GetCodepointCount :: (text: *u8) -> s32 #foreign raylib;
GetCodepoint :: (text: *u8, codepointSize: *s32) -> s32 #foreign raylib;
GetCodepointNext :: (text: *u8, codepointSize: *s32) -> s32 #foreign raylib;
GetCodepointPrevious :: (text: *u8, codepointSize: *s32) -> s32 #foreign raylib;
CodepointToUTF8 :: (codepoint: s32, utf8Size: *s32) -> *u8 #foreign raylib;

TextCopy :: (dst: *u8, src: *u8) -> s32 #foreign raylib;
TextIsEqual :: (text1: *u8, text2: *u8) -> bool #foreign raylib;
TextLength :: (text: *u8) -> u32 #foreign raylib;
TextFormat_CFormat :: (text: *u8, __args: ..Any) -> *u8 #foreign raylib "TextFormat";
TextFormat :: (text: string, __args: ..Any) -> *u8 {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, text, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return TextFormat_CFormat("%s", formatted_text.data);
} @PrintLike
TextSubtext :: (text: *u8, position: s32, length: s32) -> *u8 #foreign raylib;
TextReplace :: (text: *u8, replace: *u8, by: *u8) -> *u8 #foreign raylib;
TextInsert :: (text: *u8, insert: *u8, position: s32) -> *u8 #foreign raylib;
TextJoin :: (textList: **u8, count: s32, delimiter: *u8) -> *u8 #foreign raylib;
TextSplit :: (text: *u8, delimiter: u8, count: *s32) -> **u8 #foreign raylib;
TextAppend :: (text: *u8, append: *u8, position: *s32) -> void #foreign raylib;
TextFindIndex :: (text: *u8, find: *u8) -> s32 #foreign raylib;
TextToUpper :: (text: *u8) -> *u8 #foreign raylib;
TextToLower :: (text: *u8) -> *u8 #foreign raylib;
TextToPascal :: (text: *u8) -> *u8 #foreign raylib;
TextToInteger :: (text: *u8) -> s32 #foreign raylib;

DrawLine3D :: (startPos: Vector3, endPos: Vector3, color: Color) -> void #foreign raylib;
DrawPoint3D :: (position: Vector3, color: Color) -> void #foreign raylib;
DrawCircle3D :: (center: Vector3, radius: float, rotationAxis: Vector3, rotationAngle: float, color: Color) -> void #foreign raylib;
DrawTriangle3D :: (v1: Vector3, v2: Vector3, v3: Vector3, color: Color) -> void #foreign raylib;
DrawTriangleStrip3D :: (points: *Vector3, pointCount: s32, color: Color) -> void #foreign raylib;
DrawCube :: (position: Vector3, width: float, height: float, length: float, color: Color) -> void #foreign raylib;
DrawCubeV :: (position: Vector3, size: Vector3, color: Color) -> void #foreign raylib;
DrawCubeWires :: (position: Vector3, width: float, height: float, length: float, color: Color) -> void #foreign raylib;
DrawCubeWiresV :: (position: Vector3, size: Vector3, color: Color) -> void #foreign raylib;
DrawSphere :: (centerPos: Vector3, radius: float, color: Color) -> void #foreign raylib;
DrawSphereEx :: (centerPos: Vector3, radius: float, rings: s32, slices: s32, color: Color) -> void #foreign raylib;
DrawSphereWires :: (centerPos: Vector3, radius: float, rings: s32, slices: s32, color: Color) -> void #foreign raylib;
DrawCylinder :: (position: Vector3, radiusTop: float, radiusBottom: float, height: float, slices: s32, color: Color) -> void #foreign raylib;
DrawCylinderEx :: (startPos: Vector3, endPos: Vector3, startRadius: float, endRadius: float, sides: s32, color: Color) -> void #foreign raylib;
DrawCylinderWires :: (position: Vector3, radiusTop: float, radiusBottom: float, height: float, slices: s32, color: Color) -> void #foreign raylib;
DrawCylinderWiresEx :: (startPos: Vector3, endPos: Vector3, startRadius: float, endRadius: float, sides: s32, color: Color) -> void #foreign raylib;
DrawCapsule :: (startPos: Vector3, endPos: Vector3, radius: float, slices: s32, rings: s32, color: Color) -> void #foreign raylib;
DrawCapsuleWires :: (startPos: Vector3, endPos: Vector3, radius: float, slices: s32, rings: s32, color: Color) -> void #foreign raylib;
DrawPlane :: (centerPos: Vector3, size: Vector2, color: Color) -> void #foreign raylib;
DrawRay :: (ray: Ray, color: Color) -> void #foreign raylib;
DrawGrid :: (slices: s32, spacing: float) -> void #foreign raylib;

LoadModel :: (fileName: *u8) -> Model #foreign raylib;
LoadModelFromMesh :: (mesh: Mesh) -> Model #foreign raylib;
IsModelReady :: (model: Model) -> bool #foreign raylib;
UnloadModel :: (model: Model) -> void #foreign raylib;
GetModelBoundingBox :: (model: Model) -> BoundingBox #foreign raylib;

DrawModel :: (model: Model, position: Vector3, scale: float, tint: Color) -> void #foreign raylib;
DrawModelEx :: (model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: float, scale: Vector3, tint: Color) -> void #foreign raylib;
DrawModelWires :: (model: Model, position: Vector3, scale: float, tint: Color) -> void #foreign raylib;
DrawModelWiresEx :: (model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: float, scale: Vector3, tint: Color) -> void #foreign raylib;
DrawBoundingBox :: (box: BoundingBox, color: Color) -> void #foreign raylib;
DrawBillboard :: (camera: Camera, texture: Texture2D, position: Vector3, size: float, tint: Color) -> void #foreign raylib;
DrawBillboardRec :: (camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, size: Vector2, tint: Color) -> void #foreign raylib;
DrawBillboardPro :: (camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, up: Vector3, size: Vector2, origin: Vector2, rotation: float, tint: Color) -> void #foreign raylib;

UploadMesh :: (mesh: *Mesh, dynamic: bool) -> void #foreign raylib;
UpdateMeshBuffer :: (mesh: Mesh, index: s32, data: *void, dataSize: s32, offset: s32) -> void #foreign raylib;
UnloadMesh :: (mesh: Mesh) -> void #foreign raylib;
DrawMesh :: (mesh: Mesh, material: Material, transform: Matrix) -> void #foreign raylib;
DrawMeshInstanced :: (mesh: Mesh, material: Material, transforms: *Matrix, instances: s32) -> void #foreign raylib;
ExportMesh :: (mesh: Mesh, fileName: *u8) -> bool #foreign raylib;
GetMeshBoundingBox :: (mesh: Mesh) -> BoundingBox #foreign raylib;
GenMeshTangents :: (mesh: *Mesh) -> void #foreign raylib;

GenMeshPoly :: (sides: s32, radius: float) -> Mesh #foreign raylib;
GenMeshPlane :: (width: float, length: float, resX: s32, resZ: s32) -> Mesh #foreign raylib;
GenMeshCube :: (width: float, height: float, length: float) -> Mesh #foreign raylib;
GenMeshSphere :: (radius: float, rings: s32, slices: s32) -> Mesh #foreign raylib;
GenMeshHemiSphere :: (radius: float, rings: s32, slices: s32) -> Mesh #foreign raylib;
GenMeshCylinder :: (radius: float, height: float, slices: s32) -> Mesh #foreign raylib;
GenMeshCone :: (radius: float, height: float, slices: s32) -> Mesh #foreign raylib;
GenMeshTorus :: (radius: float, size: float, radSeg: s32, sides: s32) -> Mesh #foreign raylib;
GenMeshKnot :: (radius: float, size: float, radSeg: s32, sides: s32) -> Mesh #foreign raylib;
GenMeshHeightmap :: (heightmap: Image, size: Vector3) -> Mesh #foreign raylib;
GenMeshCubicmap :: (cubicmap: Image, cubeSize: Vector3) -> Mesh #foreign raylib;

LoadMaterials :: (fileName: *u8, materialCount: *s32) -> *Material #foreign raylib;
LoadMaterialDefault :: () -> Material #foreign raylib;
IsMaterialReady :: (material: Material) -> bool #foreign raylib;
UnloadMaterial :: (material: Material) -> void #foreign raylib;
SetMaterialTexture :: (material: *Material, mapType: s32, texture: Texture2D) -> void #foreign raylib;
SetModelMeshMaterial :: (model: *Model, meshId: s32, materialId: s32) -> void #foreign raylib;

LoadModelAnimations :: (fileName: *u8, animCount: *s32) -> *ModelAnimation #foreign raylib;
UpdateModelAnimation :: (model: Model, anim: ModelAnimation, frame: s32) -> void #foreign raylib;
UnloadModelAnimation :: (anim: ModelAnimation) -> void #foreign raylib;
UnloadModelAnimations :: (animations: *ModelAnimation, animCount: s32) -> void #foreign raylib;
IsModelAnimationValid :: (model: Model, anim: ModelAnimation) -> bool #foreign raylib;

CheckCollisionSpheres :: (center1: Vector3, radius1: float, center2: Vector3, radius2: float) -> bool #foreign raylib;
CheckCollisionBoxes :: (box1: BoundingBox, box2: BoundingBox) -> bool #foreign raylib;
CheckCollisionBoxSphere :: (box: BoundingBox, center: Vector3, radius: float) -> bool #foreign raylib;
GetRayCollisionSphere :: (ray: Ray, center: Vector3, radius: float) -> RayCollision #foreign raylib;
GetRayCollisionBox :: (ray: Ray, box: BoundingBox) -> RayCollision #foreign raylib;
GetRayCollisionMesh :: (ray: Ray, mesh: Mesh, transform: Matrix) -> RayCollision #foreign raylib;
GetRayCollisionTriangle :: (ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3) -> RayCollision #foreign raylib;
GetRayCollisionQuad :: (ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3, p4: Vector3) -> RayCollision #foreign raylib;

AudioCallback :: #type (bufferData: *void, frames: u32) -> void #c_call;

InitAudioDevice :: () -> void #foreign raylib;
CloseAudioDevice :: () -> void #foreign raylib;
IsAudioDeviceReady :: () -> bool #foreign raylib;
SetMasterVolume :: (volume: float) -> void #foreign raylib;
GetMasterVolume :: () -> float #foreign raylib;

LoadWave :: (fileName: *u8) -> Wave #foreign raylib;
LoadWaveFromMemory :: (fileType: *u8, fileData: *u8, dataSize: s32) -> Wave #foreign raylib;
IsWaveReady :: (wave: Wave) -> bool #foreign raylib;
LoadSound :: (fileName: *u8) -> Sound #foreign raylib;
LoadSoundFromWave :: (wave: Wave) -> Sound #foreign raylib;
LoadSoundAlias :: (source: Sound) -> Sound #foreign raylib;
IsSoundReady :: (sound: Sound) -> bool #foreign raylib;
UpdateSound :: (sound: Sound, data: *void, sampleCount: s32) -> void #foreign raylib;
UnloadWave :: (wave: Wave) -> void #foreign raylib;
UnloadSound :: (sound: Sound) -> void #foreign raylib;
UnloadSoundAlias :: (alias: Sound) -> void #foreign raylib;
ExportWave :: (wave: Wave, fileName: *u8) -> bool #foreign raylib;
ExportWaveAsCode :: (wave: Wave, fileName: *u8) -> bool #foreign raylib;

PlaySound :: (sound: Sound) -> void #foreign raylib;
StopSound :: (sound: Sound) -> void #foreign raylib;
PauseSound :: (sound: Sound) -> void #foreign raylib;
ResumeSound :: (sound: Sound) -> void #foreign raylib;
IsSoundPlaying :: (sound: Sound) -> bool #foreign raylib;
SetSoundVolume :: (sound: Sound, volume: float) -> void #foreign raylib;
SetSoundPitch :: (sound: Sound, pitch: float) -> void #foreign raylib;
SetSoundPan :: (sound: Sound, pan: float) -> void #foreign raylib;
WaveCopy :: (wave: Wave) -> Wave #foreign raylib;
WaveCrop :: (wave: *Wave, initSample: s32, finalSample: s32) -> void #foreign raylib;
WaveFormat :: (wave: *Wave, sampleRate: s32, sampleSize: s32, channels: s32) -> void #foreign raylib;
LoadWaveSamples :: (wave: Wave) -> *float #foreign raylib;
UnloadWaveSamples :: (samples: *float) -> void #foreign raylib;

LoadMusicStream :: (fileName: *u8) -> Music #foreign raylib;
LoadMusicStreamFromMemory :: (fileType: *u8, data: *u8, dataSize: s32) -> Music #foreign raylib;
IsMusicReady :: (music: Music) -> bool #foreign raylib;
UnloadMusicStream :: (music: Music) -> void #foreign raylib;
PlayMusicStream :: (music: Music) -> void #foreign raylib;
IsMusicStreamPlaying :: (music: Music) -> bool #foreign raylib;
UpdateMusicStream :: (music: Music) -> void #foreign raylib;
StopMusicStream :: (music: Music) -> void #foreign raylib;
PauseMusicStream :: (music: Music) -> void #foreign raylib;
ResumeMusicStream :: (music: Music) -> void #foreign raylib;
SeekMusicStream :: (music: Music, position: float) -> void #foreign raylib;
SetMusicVolume :: (music: Music, volume: float) -> void #foreign raylib;
SetMusicPitch :: (music: Music, pitch: float) -> void #foreign raylib;
SetMusicPan :: (music: Music, pan: float) -> void #foreign raylib;
GetMusicTimeLength :: (music: Music) -> float #foreign raylib;
GetMusicTimePlayed :: (music: Music) -> float #foreign raylib;

LoadAudioStream :: (sampleRate: u32, sampleSize: u32, channels: u32) -> AudioStream #foreign raylib;
IsAudioStreamReady :: (stream: AudioStream) -> bool #foreign raylib;
UnloadAudioStream :: (stream: AudioStream) -> void #foreign raylib;
UpdateAudioStream :: (stream: AudioStream, data: *void, frameCount: s32) -> void #foreign raylib;
IsAudioStreamProcessed :: (stream: AudioStream) -> bool #foreign raylib;
PlayAudioStream :: (stream: AudioStream) -> void #foreign raylib;
PauseAudioStream :: (stream: AudioStream) -> void #foreign raylib;
ResumeAudioStream :: (stream: AudioStream) -> void #foreign raylib;
IsAudioStreamPlaying :: (stream: AudioStream) -> bool #foreign raylib;
StopAudioStream :: (stream: AudioStream) -> void #foreign raylib;
SetAudioStreamVolume :: (stream: AudioStream, volume: float) -> void #foreign raylib;
SetAudioStreamPitch :: (stream: AudioStream, pitch: float) -> void #foreign raylib;
SetAudioStreamPan :: (stream: AudioStream, pan: float) -> void #foreign raylib;
SetAudioStreamBufferSizeDefault :: (size: s32) -> void #foreign raylib;
SetAudioStreamCallback :: (stream: AudioStream, callback: AudioCallback) -> void #foreign raylib;

AttachAudioStreamProcessor :: (stream: AudioStream, processor: AudioCallback) -> void #foreign raylib;
DetachAudioStreamProcessor :: (stream: AudioStream, processor: AudioCallback) -> void #foreign raylib;

AttachAudioMixedProcessor :: (processor: AudioCallback) -> void #foreign raylib;
DetachAudioMixedProcessor :: (processor: AudioCallback) -> void #foreign raylib;

float3 :: struct {
    v: [3] float;
}

float16 :: struct {
    v: [16] float;
}

Clamp :: (value: float, min: float, max: float) -> float #foreign raylib;

Lerp :: (start: float, end: float, amount: float) -> float #foreign raylib;

Normalize :: (value: float, start: float, end: float) -> float #foreign raylib;

Remap :: (value: float, inputStart: float, inputEnd: float, outputStart: float, outputEnd: float) -> float #foreign raylib;

Wrap :: (value: float, min: float, max: float) -> float #foreign raylib;

FloatEquals :: (x: float, y: float) -> s32 #foreign raylib;

Vector2Zero :: () -> Vector2 #foreign raylib;

Vector2One :: () -> Vector2 #foreign raylib;

Vector2Add :: (v1: Vector2, v2: Vector2) -> Vector2 #foreign raylib;

Vector2AddValue :: (v: Vector2, add: float) -> Vector2 #foreign raylib;

Vector2Subtract :: (v1: Vector2, v2: Vector2) -> Vector2 #foreign raylib;

Vector2SubtractValue :: (v: Vector2, sub: float) -> Vector2 #foreign raylib;

Vector2Length :: (v: Vector2) -> float #foreign raylib;

Vector2LengthSqr :: (v: Vector2) -> float #foreign raylib;

Vector2DotProduct :: (v1: Vector2, v2: Vector2) -> float #foreign raylib;

Vector2Distance :: (v1: Vector2, v2: Vector2) -> float #foreign raylib;

Vector2DistanceSqr :: (v1: Vector2, v2: Vector2) -> float #foreign raylib;

Vector2Angle :: (v1: Vector2, v2: Vector2) -> float #foreign raylib;

Vector2LineAngle :: (start: Vector2, end: Vector2) -> float #foreign raylib;

Vector2Scale :: (v: Vector2, scale: float) -> Vector2 #foreign raylib;

Vector2Multiply :: (v1: Vector2, v2: Vector2) -> Vector2 #foreign raylib;

Vector2Negate :: (v: Vector2) -> Vector2 #foreign raylib;

Vector2Divide :: (v1: Vector2, v2: Vector2) -> Vector2 #foreign raylib;

Vector2Normalize :: (v: Vector2) -> Vector2 #foreign raylib;

Vector2Transform :: (v: Vector2, mat: Matrix) -> Vector2 #foreign raylib;

Vector2Lerp :: (v1: Vector2, v2: Vector2, amount: float) -> Vector2 #foreign raylib;

Vector2Reflect :: (v: Vector2, normal: Vector2) -> Vector2 #foreign raylib;

Vector2Rotate :: (v: Vector2, angle: float) -> Vector2 #foreign raylib;

Vector2MoveTowards :: (v: Vector2, target: Vector2, maxDistance: float) -> Vector2 #foreign raylib;

Vector2Invert :: (v: Vector2) -> Vector2 #foreign raylib;

Vector2Clamp :: (v: Vector2, min: Vector2, max: Vector2) -> Vector2 #foreign raylib;

Vector2ClampValue :: (v: Vector2, min: float, max: float) -> Vector2 #foreign raylib;

Vector2Equals :: (p: Vector2, q: Vector2) -> s32 #foreign raylib;

Vector3Zero :: () -> Vector3 #foreign raylib;

Vector3One :: () -> Vector3 #foreign raylib;

Vector3Add :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3AddValue :: (v: Vector3, add: float) -> Vector3 #foreign raylib;

Vector3Subtract :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3SubtractValue :: (v: Vector3, sub: float) -> Vector3 #foreign raylib;

Vector3Scale :: (v: Vector3, scalar: float) -> Vector3 #foreign raylib;

Vector3Multiply :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3CrossProduct :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3Perpendicular :: (v: Vector3) -> Vector3 #foreign raylib;

Vector3Length :: (v: Vector3) -> float #foreign raylib;

Vector3LengthSqr :: (v: Vector3) -> float #foreign raylib;

Vector3DotProduct :: (v1: Vector3, v2: Vector3) -> float #foreign raylib;

Vector3Distance :: (v1: Vector3, v2: Vector3) -> float #foreign raylib;

Vector3DistanceSqr :: (v1: Vector3, v2: Vector3) -> float #foreign raylib;

Vector3Angle :: (v1: Vector3, v2: Vector3) -> float #foreign raylib;

Vector3Negate :: (v: Vector3) -> Vector3 #foreign raylib;

Vector3Divide :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3Normalize :: (v: Vector3) -> Vector3 #foreign raylib;

Vector3Project :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3Reject :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3OrthoNormalize :: (v1: *Vector3, v2: *Vector3) -> void #foreign raylib;

Vector3Transform :: (v: Vector3, mat: Matrix) -> Vector3 #foreign raylib;

Vector3RotateByQuaternion :: (v: Vector3, q: Quaternion) -> Vector3 #foreign raylib;

Vector3RotateByAxisAngle :: (v: Vector3, axis: Vector3, angle: float) -> Vector3 #foreign raylib;

Vector3Lerp :: (v1: Vector3, v2: Vector3, amount: float) -> Vector3 #foreign raylib;

Vector3Reflect :: (v: Vector3, normal: Vector3) -> Vector3 #foreign raylib;

Vector3Min :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3Max :: (v1: Vector3, v2: Vector3) -> Vector3 #foreign raylib;

Vector3Barycenter :: (p: Vector3, a: Vector3, b: Vector3, c: Vector3) -> Vector3 #foreign raylib;

Vector3Unproject :: (source: Vector3, projection: Matrix, view: Matrix) -> Vector3 #foreign raylib;

Vector3ToFloatV :: (v: Vector3) -> float3 #foreign raylib;

Vector3Invert :: (v: Vector3) -> Vector3 #foreign raylib;

Vector3Clamp :: (v: Vector3, min: Vector3, max: Vector3) -> Vector3 #foreign raylib;

Vector3ClampValue :: (v: Vector3, min: float, max: float) -> Vector3 #foreign raylib;

Vector3Equals :: (p: Vector3, q: Vector3) -> s32 #foreign raylib;

Vector3Refract :: (v: Vector3, n: Vector3, r: float) -> Vector3 #foreign raylib;

MatrixDeterminant :: (mat: Matrix) -> float #foreign raylib;

MatrixTrace :: (mat: Matrix) -> float #foreign raylib;

MatrixTranspose :: (mat: Matrix) -> Matrix #foreign raylib;

MatrixInvert :: (mat: Matrix) -> Matrix #foreign raylib;

MatrixIdentity :: () -> Matrix #foreign raylib;

MatrixAdd :: (left: Matrix, right: Matrix) -> Matrix #foreign raylib;

MatrixSubtract :: (left: Matrix, right: Matrix) -> Matrix #foreign raylib;

MatrixMultiply :: (left: Matrix, right: Matrix) -> Matrix #foreign raylib;

MatrixTranslate :: (x: float, y: float, z: float) -> Matrix #foreign raylib;

MatrixRotate :: (axis: Vector3, angle: float) -> Matrix #foreign raylib;

MatrixRotateX :: (angle: float) -> Matrix #foreign raylib;

MatrixRotateY :: (angle: float) -> Matrix #foreign raylib;

MatrixRotateZ :: (angle: float) -> Matrix #foreign raylib;

MatrixRotateXYZ :: (angle: Vector3) -> Matrix #foreign raylib;

MatrixRotateZYX :: (angle: Vector3) -> Matrix #foreign raylib;

MatrixScale :: (x: float, y: float, z: float) -> Matrix #foreign raylib;

MatrixFrustum :: (left: float64, right: float64, bottom: float64, top: float64, near: float64, far: float64) -> Matrix #foreign raylib;

MatrixPerspective :: (fovY: float64, aspect: float64, nearPlane: float64, farPlane: float64) -> Matrix #foreign raylib;

MatrixOrtho :: (left: float64, right: float64, bottom: float64, top: float64, nearPlane: float64, farPlane: float64) -> Matrix #foreign raylib;

MatrixLookAt :: (eye: Vector3, target: Vector3, up: Vector3) -> Matrix #foreign raylib;

MatrixToFloatV :: (mat: Matrix) -> float16 #foreign raylib;

QuaternionAdd :: (q1: Quaternion, q2: Quaternion) -> Quaternion #foreign raylib;

QuaternionAddValue :: (q: Quaternion, add: float) -> Quaternion #foreign raylib;

QuaternionSubtract :: (q1: Quaternion, q2: Quaternion) -> Quaternion #foreign raylib;

QuaternionSubtractValue :: (q: Quaternion, sub: float) -> Quaternion #foreign raylib;

QuaternionIdentity :: () -> Quaternion #foreign raylib;

QuaternionLength :: (q: Quaternion) -> float #foreign raylib;

QuaternionNormalize :: (q: Quaternion) -> Quaternion #foreign raylib;

QuaternionInvert :: (q: Quaternion) -> Quaternion #foreign raylib;

QuaternionMultiply :: (q1: Quaternion, q2: Quaternion) -> Quaternion #foreign raylib;

QuaternionScale :: (q: Quaternion, mul: float) -> Quaternion #foreign raylib;

QuaternionDivide :: (q1: Quaternion, q2: Quaternion) -> Quaternion #foreign raylib;

QuaternionLerp :: (q1: Quaternion, q2: Quaternion, amount: float) -> Quaternion #foreign raylib;

QuaternionNlerp :: (q1: Quaternion, q2: Quaternion, amount: float) -> Quaternion #foreign raylib;

QuaternionSlerp :: (q1: Quaternion, q2: Quaternion, amount: float) -> Quaternion #foreign raylib;

QuaternionFromVector3ToVector3 :: (from: Vector3, to: Vector3) -> Quaternion #foreign raylib;

QuaternionFromMatrix :: (mat: Matrix) -> Quaternion #foreign raylib;

QuaternionToMatrix :: (q: Quaternion) -> Matrix #foreign raylib;

QuaternionFromAxisAngle :: (axis: Vector3, angle: float) -> Quaternion #foreign raylib;

QuaternionToAxisAngle :: (q: Quaternion, outAxis: *Vector3, outAngle: *float) -> void #foreign raylib;

QuaternionFromEuler :: (pitch: float, yaw: float, roll: float) -> Quaternion #foreign raylib;

QuaternionToEuler :: (q: Quaternion) -> Vector3 #foreign raylib;

QuaternionTransform :: (q: Quaternion, mat: Matrix) -> Quaternion #foreign raylib;

QuaternionEquals :: (p: Quaternion, q: Quaternion) -> s32 #foreign raylib;

rlVertexBuffer :: struct {
    elementCount: s32;

    vertices:     *float;
    texcoords:    *float;
    colors:       *u8;

    indices:      *u32;

    vaoId:        u32;
    vboId:        [4] u32;
}

rlDrawCall :: struct {
    mode:            s32;
    vertexCount:     s32;
    vertexAlignment: s32;

    textureId:       u32;
}

rlRenderBatch :: struct {
    bufferCount:   s32;
    currentBuffer: s32;
    vertexBuffer:  *rlVertexBuffer;

    draws:         *rlDrawCall;
    drawCounter:   s32;
    currentDepth:  float;
}

rlGlVersion :: enum s32 {
    _11   :: 1;
    _21   :: 2;
    _33   :: 3;
    _43   :: 4;
    ES_20 :: 5;
    ES_30 :: 6;
}

rlTraceLogLevel :: enum s32 {
    ALL     :: 0;
    TRACE   :: 1;
    DEBUG   :: 2;
    INFO    :: 3;
    WARNING :: 4;
    ERROR   :: 5;
    FATAL   :: 6;
    NONE    :: 7;
}

rlPixelFormat :: enum s32 {
    UNCOMPRESSED_GRAYSCALE    :: 1;
    UNCOMPRESSED_GRAY_ALPHA   :: 2;
    UNCOMPRESSED_R5G6B5       :: 3;
    UNCOMPRESSED_R8G8B8       :: 4;
    UNCOMPRESSED_R5G5B5A1     :: 5;
    UNCOMPRESSED_R4G4B4A4     :: 6;
    UNCOMPRESSED_R8G8B8A8     :: 7;
    UNCOMPRESSED_R32          :: 8;
    UNCOMPRESSED_R32G32B32    :: 9;
    UNCOMPRESSED_R32G32B32A32 :: 10;
    UNCOMPRESSED_R16          :: 11;
    UNCOMPRESSED_R16G16B16    :: 12;
    UNCOMPRESSED_R16G16B16A16 :: 13;
    COMPRESSED_DXT1_RGB       :: 14;
    COMPRESSED_DXT1_RGBA      :: 15;
    COMPRESSED_DXT3_RGBA      :: 16;
    COMPRESSED_DXT5_RGBA      :: 17;
    COMPRESSED_ETC1_RGB       :: 18;
    COMPRESSED_ETC2_RGB       :: 19;
    COMPRESSED_ETC2_EAC_RGBA  :: 20;
    COMPRESSED_PVRT_RGB       :: 21;
    COMPRESSED_PVRT_RGBA      :: 22;
    COMPRESSED_ASTC_4x4_RGBA  :: 23;
    COMPRESSED_ASTC_8x8_RGBA  :: 24;
}

rlTextureFilter :: enum s32 {
    POINT           :: 0;
    BILINEAR        :: 1;
    TRILINEAR       :: 2;
    ANISOTROPIC_4X  :: 3;
    ANISOTROPIC_8X  :: 4;
    ANISOTROPIC_16X :: 5;
}

rlBlendMode :: enum s32 {
    ALPHA             :: 0;
    ADDITIVE          :: 1;
    MULTIPLIED        :: 2;
    ADD_COLORS        :: 3;
    SUBTRACT_COLORS   :: 4;
    ALPHA_PREMULTIPLY :: 5;
    CUSTOM            :: 6;
    CUSTOM_SEPARATE   :: 7;
}

rlShaderLocationIndex :: enum s32 {
    VERTEX_POSITION   :: 0;
    VERTEX_TEXCOORD01 :: 1;
    VERTEX_TEXCOORD02 :: 2;
    VERTEX_NORMAL     :: 3;
    VERTEX_TANGENT    :: 4;
    VERTEX_COLOR      :: 5;
    MATRIX_MVP        :: 6;
    MATRIX_VIEW       :: 7;
    MATRIX_PROJECTION :: 8;
    MATRIX_MODEL      :: 9;
    MATRIX_NORMAL     :: 10;
    VECTOR_VIEW       :: 11;
    COLOR_DIFFUSE     :: 12;
    COLOR_SPECULAR    :: 13;
    COLOR_AMBIENT     :: 14;
    MAP_ALBEDO        :: 15;
    MAP_METALNESS     :: 16;
    MAP_NORMAL        :: 17;
    MAP_ROUGHNESS     :: 18;
    MAP_OCCLUSION     :: 19;
    MAP_EMISSION      :: 20;
    MAP_HEIGHT        :: 21;
    MAP_CUBEMAP       :: 22;
    MAP_IRRADIANCE    :: 23;
    MAP_PREFILTER     :: 24;
    MAP_BRDF          :: 25;
}

rlShaderUniformDataType :: enum s32 {
    FLOAT     :: 0;
    VEC2      :: 1;
    VEC3      :: 2;
    VEC4      :: 3;
    INT       :: 4;
    IVEC2     :: 5;
    IVEC3     :: 6;
    IVEC4     :: 7;
    SAMPLER2D :: 8;
}

rlShaderAttributeDataType :: enum s32 {
    FLOAT :: 0;
    VEC2  :: 1;
    VEC3  :: 2;
    VEC4  :: 3;
}

rlFramebufferAttachType :: enum s32 {
    COLOR_CHANNEL0 :: 0;
    COLOR_CHANNEL1 :: 1;
    COLOR_CHANNEL2 :: 2;
    COLOR_CHANNEL3 :: 3;
    COLOR_CHANNEL4 :: 4;
    COLOR_CHANNEL5 :: 5;
    COLOR_CHANNEL6 :: 6;
    COLOR_CHANNEL7 :: 7;
    DEPTH          :: 100;
    STENCIL        :: 200;
}

rlFramebufferAttachTextureType :: enum s32 {
    CUBEMAP_POSITIVE_X :: 0;
    CUBEMAP_NEGATIVE_X :: 1;
    CUBEMAP_POSITIVE_Y :: 2;
    CUBEMAP_NEGATIVE_Y :: 3;
    CUBEMAP_POSITIVE_Z :: 4;
    CUBEMAP_NEGATIVE_Z :: 5;
    TEXTURE2D          :: 100;
    RENDERBUFFER       :: 200;
}

rlCullMode :: enum s32 {
    FRONT :: 0;
    BACK  :: 1;
}

rlMatrixMode :: (mode: s32) -> void #foreign raylib;
rlPushMatrix :: () -> void #foreign raylib;
rlPopMatrix :: () -> void #foreign raylib;
rlLoadIdentity :: () -> void #foreign raylib;
rlTranslatef :: (x: float, y: float, z: float) -> void #foreign raylib;
rlRotatef :: (angle: float, x: float, y: float, z: float) -> void #foreign raylib;
rlScalef :: (x: float, y: float, z: float) -> void #foreign raylib;
rlMultMatrixf :: (matf: *float) -> void #foreign raylib;
rlFrustum :: (left: float64, right: float64, bottom: float64, top: float64, znear: float64, zfar: float64) -> void #foreign raylib;
rlOrtho :: (left: float64, right: float64, bottom: float64, top: float64, znear: float64, zfar: float64) -> void #foreign raylib;
rlViewport :: (x: s32, y: s32, width: s32, height: s32) -> void #foreign raylib;

rlBegin :: (mode: s32) -> void #foreign raylib;
rlEnd :: () -> void #foreign raylib;
rlVertex2i :: (x: s32, y: s32) -> void #foreign raylib;
rlVertex2f :: (x: float, y: float) -> void #foreign raylib;
rlVertex3f :: (x: float, y: float, z: float) -> void #foreign raylib;
rlTexCoord2f :: (x: float, y: float) -> void #foreign raylib;
rlNormal3f :: (x: float, y: float, z: float) -> void #foreign raylib;
rlColor4ub :: (r: u8, g: u8, b: u8, a: u8) -> void #foreign raylib;
rlColor3f :: (x: float, y: float, z: float) -> void #foreign raylib;
rlColor4f :: (x: float, y: float, z: float, w: float) -> void #foreign raylib;

rlEnableVertexArray :: (vaoId: u32) -> bool #foreign raylib;
rlDisableVertexArray :: () -> void #foreign raylib;
rlEnableVertexBuffer :: (id: u32) -> void #foreign raylib;
rlDisableVertexBuffer :: () -> void #foreign raylib;
rlEnableVertexBufferElement :: (id: u32) -> void #foreign raylib;
rlDisableVertexBufferElement :: () -> void #foreign raylib;
rlEnableVertexAttribute :: (index: u32) -> void #foreign raylib;
rlDisableVertexAttribute :: (index: u32) -> void #foreign raylib;

rlActiveTextureSlot :: (slot: s32) -> void #foreign raylib;
rlEnableTexture :: (id: u32) -> void #foreign raylib;
rlDisableTexture :: () -> void #foreign raylib;
rlEnableTextureCubemap :: (id: u32) -> void #foreign raylib;
rlDisableTextureCubemap :: () -> void #foreign raylib;
rlTextureParameters :: (id: u32, param: s32, value: s32) -> void #foreign raylib;
rlCubemapParameters :: (id: u32, param: s32, value: s32) -> void #foreign raylib;

rlEnableShader :: (id: u32) -> void #foreign raylib;
rlDisableShader :: () -> void #foreign raylib;

rlEnableFramebuffer :: (id: u32) -> void #foreign raylib;
rlDisableFramebuffer :: () -> void #foreign raylib;
rlActiveDrawBuffers :: (count: s32) -> void #foreign raylib;
rlBlitFramebuffer :: (srcX: s32, srcY: s32, srcWidth: s32, srcHeight: s32, dstX: s32, dstY: s32, dstWidth: s32, dstHeight: s32, bufferMask: s32) -> void #foreign raylib;

rlEnableColorBlend :: () -> void #foreign raylib;
rlDisableColorBlend :: () -> void #foreign raylib;
rlEnableDepthTest :: () -> void #foreign raylib;
rlDisableDepthTest :: () -> void #foreign raylib;
rlEnableDepthMask :: () -> void #foreign raylib;
rlDisableDepthMask :: () -> void #foreign raylib;
rlEnableBackfaceCulling :: () -> void #foreign raylib;
rlDisableBackfaceCulling :: () -> void #foreign raylib;
rlSetCullFace :: (mode: s32) -> void #foreign raylib;
rlEnableScissorTest :: () -> void #foreign raylib;
rlDisableScissorTest :: () -> void #foreign raylib;
rlScissor :: (x: s32, y: s32, width: s32, height: s32) -> void #foreign raylib;
rlEnableWireMode :: () -> void #foreign raylib;
rlEnablePointMode :: () -> void #foreign raylib;
rlDisableWireMode :: () -> void #foreign raylib;
rlSetLineWidth :: (width: float) -> void #foreign raylib;
rlGetLineWidth :: () -> float #foreign raylib;
rlEnableSmoothLines :: () -> void #foreign raylib;
rlDisableSmoothLines :: () -> void #foreign raylib;
rlEnableStereoRender :: () -> void #foreign raylib;
rlDisableStereoRender :: () -> void #foreign raylib;
rlIsStereoRenderEnabled :: () -> bool #foreign raylib;

rlClearColor :: (r: u8, g: u8, b: u8, a: u8) -> void #foreign raylib;
rlClearScreenBuffers :: () -> void #foreign raylib;
rlCheckErrors :: () -> void #foreign raylib;
rlSetBlendMode :: (mode: s32) -> void #foreign raylib;
rlSetBlendFactors :: (glSrcFactor: s32, glDstFactor: s32, glEquation: s32) -> void #foreign raylib;
rlSetBlendFactorsSeparate :: (glSrcRGB: s32, glDstRGB: s32, glSrcAlpha: s32, glDstAlpha: s32, glEqRGB: s32, glEqAlpha: s32) -> void #foreign raylib;

rlglInit :: (width: s32, height: s32) -> void #foreign raylib;
rlglClose :: () -> void #foreign raylib;
rlLoadExtensions :: (loader: *void) -> void #foreign raylib;
rlGetVersion :: () -> s32 #foreign raylib;
rlSetFramebufferWidth :: (width: s32) -> void #foreign raylib;
rlGetFramebufferWidth :: () -> s32 #foreign raylib;
rlSetFramebufferHeight :: (height: s32) -> void #foreign raylib;
rlGetFramebufferHeight :: () -> s32 #foreign raylib;

rlGetTextureIdDefault :: () -> u32 #foreign raylib;
rlGetShaderIdDefault :: () -> u32 #foreign raylib;
rlGetShaderLocsDefault :: () -> *s32 #foreign raylib;

rlLoadRenderBatch :: (numBuffers: s32, bufferElements: s32) -> rlRenderBatch #foreign raylib;
rlUnloadRenderBatch :: (batch: rlRenderBatch) -> void #foreign raylib;
rlDrawRenderBatch :: (batch: *rlRenderBatch) -> void #foreign raylib;
rlSetRenderBatchActive :: (batch: *rlRenderBatch) -> void #foreign raylib;
rlDrawRenderBatchActive :: () -> void #foreign raylib;
rlCheckRenderBatchLimit :: (vCount: s32) -> bool #foreign raylib;

rlSetTexture :: (id: u32) -> void #foreign raylib;

rlLoadVertexArray :: () -> u32 #foreign raylib;
rlLoadVertexBuffer :: (buffer: *void, size: s32, dynamic: bool) -> u32 #foreign raylib;
rlLoadVertexBufferElement :: (buffer: *void, size: s32, dynamic: bool) -> u32 #foreign raylib;
rlUpdateVertexBuffer :: (bufferId: u32, data: *void, dataSize: s32, offset: s32) -> void #foreign raylib;
rlUpdateVertexBufferElements :: (id: u32, data: *void, dataSize: s32, offset: s32) -> void #foreign raylib;
rlUnloadVertexArray :: (vaoId: u32) -> void #foreign raylib;
rlUnloadVertexBuffer :: (vboId: u32) -> void #foreign raylib;
rlSetVertexAttribute :: (index: u32, compSize: s32, type: s32, normalized: bool, stride: s32, pointer: *void) -> void #foreign raylib;
rlSetVertexAttributeDivisor :: (index: u32, divisor: s32) -> void #foreign raylib;
rlSetVertexAttributeDefault :: (locIndex: s32, value: *void, attribType: s32, count: s32) -> void #foreign raylib;
rlDrawVertexArray :: (offset: s32, count: s32) -> void #foreign raylib;
rlDrawVertexArrayElements :: (offset: s32, count: s32, buffer: *void) -> void #foreign raylib;
rlDrawVertexArrayInstanced :: (offset: s32, count: s32, instances: s32) -> void #foreign raylib;
rlDrawVertexArrayElementsInstanced :: (offset: s32, count: s32, buffer: *void, instances: s32) -> void #foreign raylib;

rlLoadTexture :: (data: *void, width: s32, height: s32, format: s32, mipmapCount: s32) -> u32 #foreign raylib;
rlLoadTextureDepth :: (width: s32, height: s32, useRenderBuffer: bool) -> u32 #foreign raylib;
rlLoadTextureCubemap :: (data: *void, size: s32, format: s32) -> u32 #foreign raylib;
rlUpdateTexture :: (id: u32, offsetX: s32, offsetY: s32, width: s32, height: s32, format: s32, data: *void) -> void #foreign raylib;
rlGetGlTextureFormats :: (format: s32, glInternalFormat: *u32, glFormat: *u32, glType: *u32) -> void #foreign raylib;
rlGetPixelFormatName :: (format: u32) -> *u8 #foreign raylib;
rlUnloadTexture :: (id: u32) -> void #foreign raylib;
rlGenTextureMipmaps :: (id: u32, width: s32, height: s32, format: s32, mipmaps: *s32) -> void #foreign raylib;
rlReadTexturePixels :: (id: u32, width: s32, height: s32, format: s32) -> *void #foreign raylib;
rlReadScreenPixels :: (width: s32, height: s32) -> *u8 #foreign raylib;

rlLoadFramebuffer :: (width: s32, height: s32) -> u32 #foreign raylib;
rlFramebufferAttach :: (fboId: u32, texId: u32, attachType: s32, texType: s32, mipLevel: s32) -> void #foreign raylib;
rlFramebufferComplete :: (id: u32) -> bool #foreign raylib;
rlUnloadFramebuffer :: (id: u32) -> void #foreign raylib;

rlLoadShaderCode :: (vsCode: *u8, fsCode: *u8) -> u32 #foreign raylib;
rlCompileShader :: (shaderCode: *u8, type: s32) -> u32 #foreign raylib;
rlLoadShaderProgram :: (vShaderId: u32, fShaderId: u32) -> u32 #foreign raylib;
rlUnloadShaderProgram :: (id: u32) -> void #foreign raylib;
rlGetLocationUniform :: (shaderId: u32, uniformName: *u8) -> s32 #foreign raylib;
rlGetLocationAttrib :: (shaderId: u32, attribName: *u8) -> s32 #foreign raylib;
rlSetUniform :: (locIndex: s32, value: *void, uniformType: s32, count: s32) -> void #foreign raylib;
rlSetUniformMatrix :: (locIndex: s32, mat: Matrix) -> void #foreign raylib;
rlSetUniformSampler :: (locIndex: s32, textureId: u32) -> void #foreign raylib;
rlSetShader :: (id: u32, locs: *s32) -> void #foreign raylib;

rlLoadComputeShaderProgram :: (shaderId: u32) -> u32 #foreign raylib;
rlComputeShaderDispatch :: (groupX: u32, groupY: u32, groupZ: u32) -> void #foreign raylib;

rlLoadShaderBuffer :: (size: u32, data: *void, usageHint: s32) -> u32 #foreign raylib;
rlUnloadShaderBuffer :: (ssboId: u32) -> void #foreign raylib;
rlUpdateShaderBuffer :: (id: u32, data: *void, dataSize: u32, offset: u32) -> void #foreign raylib;
rlBindShaderBuffer :: (id: u32, index: u32) -> void #foreign raylib;
rlReadShaderBuffer :: (id: u32, dest: *void, count: u32, offset: u32) -> void #foreign raylib;
rlCopyShaderBuffer :: (destId: u32, srcId: u32, destOffset: u32, srcOffset: u32, count: u32) -> void #foreign raylib;
rlGetShaderBufferSize :: (id: u32) -> u32 #foreign raylib;

rlBindImageTexture :: (id: u32, index: u32, format: s32, readonly: bool) -> void #foreign raylib;

rlGetMatrixModelview :: () -> Matrix #foreign raylib;
rlGetMatrixProjection :: () -> Matrix #foreign raylib;
rlGetMatrixTransform :: () -> Matrix #foreign raylib;
rlGetMatrixProjectionStereo :: (eye: s32) -> Matrix #foreign raylib;
rlGetMatrixViewOffsetStereo :: (eye: s32) -> Matrix #foreign raylib;
rlSetMatrixProjection :: (proj: Matrix) -> void #foreign raylib;
rlSetMatrixModelview :: (view: Matrix) -> void #foreign raylib;
rlSetMatrixProjectionStereo :: (right: Matrix, left: Matrix) -> void #foreign raylib;
rlSetMatrixViewOffsetStereo :: (right: Matrix, left: Matrix) -> void #foreign raylib;

rlLoadDrawCube :: () -> void #foreign raylib;
rlLoadDrawQuad :: () -> void #foreign raylib;

GuiStyleProp :: struct {
    controlId:     u16;
    propertyId:    u16;
    propertyValue: s32;
}

GuiState :: enum s32 {
    NORMAL   :: 0;
    FOCUSED  :: 1;
    PRESSED  :: 2;
    DISABLED :: 3;
}

GuiTextAlignment :: enum s32 {
    LEFT   :: 0;
    CENTER :: 1;
    RIGHT  :: 2;
}

GuiTextAlignmentVertical :: enum s32 {
    TOP    :: 0;
    MIDDLE :: 1;
    BOTTOM :: 2;
}

GuiTextWrapMode :: enum s32 {
    NONE :: 0;
    CHAR :: 1;
    WORD :: 2;
}

GuiControl :: enum s32 {
    DEFAULT     :: 0;

    LABEL       :: 1;
    BUTTON      :: 2;
    TOGGLE      :: 3;
    SLIDER      :: 4;
    PROGRESSBAR :: 5;
    CHECKBOX    :: 6;
    COMBOBOX    :: 7;
    DROPDOWNBOX :: 8;
    TEXTBOX     :: 9;
    VALUEBOX    :: 10;
    SPINNER     :: 11;
    LISTVIEW    :: 12;
    COLORPICKER :: 13;
    SCROLLBAR   :: 14;
    STATUSBAR   :: 15;
}

GuiControlProperty :: enum s32 {
    BORDER_COLOR_NORMAL   :: 0;
    BASE_COLOR_NORMAL     :: 1;
    TEXT_COLOR_NORMAL     :: 2;
    BORDER_COLOR_FOCUSED  :: 3;
    BASE_COLOR_FOCUSED    :: 4;
    TEXT_COLOR_FOCUSED    :: 5;
    BORDER_COLOR_PRESSED  :: 6;
    BASE_COLOR_PRESSED    :: 7;
    TEXT_COLOR_PRESSED    :: 8;
    BORDER_COLOR_DISABLED :: 9;
    BASE_COLOR_DISABLED   :: 10;
    TEXT_COLOR_DISABLED   :: 11;
    BORDER_WIDTH          :: 12;

    TEXT_PADDING          :: 13;
    TEXT_ALIGNMENT        :: 14;
}

GuiDefaultProperty :: enum s32 {
    TEXT_SIZE               :: 16;
    TEXT_SPACING            :: 17;
    LINE_COLOR              :: 18;
    BACKGROUND_COLOR        :: 19;
    TEXT_LINE_SPACING       :: 20;
    TEXT_ALIGNMENT_VERTICAL :: 21;
    TEXT_WRAP_MODE          :: 22;
}

GuiToggleProperty :: enum s32 {
    GROUP_PADDING :: 16;
}

GuiSliderProperty :: enum s32 {
    WIDTH   :: 16;
    PADDING :: 17;
}

GuiProgressBarProperty :: enum s32 {
    PROGRESS_PADDING :: 16;
}

GuiScrollBarProperty :: enum s32 {
    ARROWS_SIZE           :: 16;
    ARROWS_VISIBLE        :: 17;
    SCROLL_SLIDER_PADDING :: 18;
    SCROLL_SLIDER_SIZE    :: 19;
    SCROLL_PADDING        :: 20;
    SCROLL_SPEED          :: 21;
}

GuiCheckBoxProperty :: enum s32 {
    CHECK_PADDING :: 16;
}

GuiComboBoxProperty :: enum s32 {
    WIDTH   :: 16;
    SPACING :: 17;
}

GuiDropdownBoxProperty :: enum s32 {
    ARROW_PADDING          :: 16;
    DROPDOWN_ITEMS_SPACING :: 17;
}

GuiTextBoxProperty :: enum s32 {
    TEXT_READONLY :: 16;
}

GuiSpinnerProperty :: enum s32 {
    WIDTH   :: 16;
    SPACING :: 17;
}

GuiListViewProperty :: enum s32 {
    LIST_ITEMS_HEIGHT  :: 16;
    LIST_ITEMS_SPACING :: 17;
    SCROLLBAR_WIDTH    :: 18;
    SCROLLBAR_SIDE     :: 19;
}

GuiColorPickerProperty :: enum s32 {
    COLOR_SELECTOR_SIZE      :: 16;
    HUEBAR_WIDTH             :: 17;
    HUEBAR_PADDING           :: 18;
    HUEBAR_SELECTOR_HEIGHT   :: 19;
    HUEBAR_SELECTOR_OVERFLOW :: 20;
}

GuiEnable :: () -> void #foreign raygui;
GuiDisable :: () -> void #foreign raygui;
GuiLock :: () -> void #foreign raygui;
GuiUnlock :: () -> void #foreign raygui;
GuiIsLocked :: () -> bool #foreign raygui;
GuiSetAlpha :: (alpha: float) -> void #foreign raygui;
GuiSetState :: (state: s32) -> void #foreign raygui;
GuiGetState :: () -> s32 #foreign raygui;

GuiSetFont :: (font: Font) -> void #foreign raygui;
GuiGetFont :: () -> Font #foreign raygui;

GuiSetStyle :: (control: s32, property: s32, value: s32) -> void #foreign raygui;
GuiGetStyle :: (control: s32, property: s32) -> s32 #foreign raygui;

GuiLoadStyle :: (fileName: *u8) -> void #foreign raygui;
GuiLoadStyleDefault :: () -> void #foreign raygui;

GuiEnableTooltip :: () -> void #foreign raygui;
GuiDisableTooltip :: () -> void #foreign raygui;
GuiSetTooltip :: (tooltip: *u8) -> void #foreign raygui;

GuiIconText :: (iconId: s32, text: *u8) -> *u8 #foreign raygui;

GuiSetIconScale :: (scale: s32) -> void #foreign raygui;
GuiGetIcons :: () -> *u32 #foreign raygui;
GuiLoadIcons :: (fileName: *u8, loadIconsName: bool) -> **u8 #foreign raygui;
GuiDrawIcon :: (iconId: s32, posX: s32, posY: s32, pixelSize: s32, color: Color) -> void #foreign raygui;

GuiWindowBox :: (bounds: Rectangle, title: *u8) -> s32 #foreign raygui;
GuiGroupBox :: (bounds: Rectangle, text: *u8) -> s32 #foreign raygui;
GuiLine :: (bounds: Rectangle, text: *u8) -> s32 #foreign raygui;
GuiPanel :: (bounds: Rectangle, text: *u8) -> s32 #foreign raygui;
GuiTabBar :: (bounds: Rectangle, text: **u8, count: s32, active: *s32) -> s32 #foreign raygui;
GuiScrollPanel :: (bounds: Rectangle, text: *u8, content: Rectangle, scroll: *Vector2, view: *Rectangle) -> s32 #foreign raygui;

GuiLabel :: (bounds: Rectangle, text: *u8) -> s32 #foreign raygui;
GuiButton :: (bounds: Rectangle, text: *u8) -> s32 #foreign raygui;
GuiLabelButton :: (bounds: Rectangle, text: *u8) -> s32 #foreign raygui;
GuiToggle :: (bounds: Rectangle, text: *u8, active: *bool) -> s32 #foreign raygui;
GuiToggleGroup :: (bounds: Rectangle, text: *u8, active: *s32) -> s32 #foreign raygui;
GuiToggleSlider :: (bounds: Rectangle, text: *u8, active: *s32) -> s32 #foreign raygui;
GuiCheckBox :: (bounds: Rectangle, text: *u8, checked: *bool) -> s32 #foreign raygui;
GuiComboBox :: (bounds: Rectangle, text: *u8, active: *s32) -> s32 #foreign raygui;

GuiDropdownBox :: (bounds: Rectangle, text: *u8, active: *s32, editMode: bool) -> s32 #foreign raygui;
GuiSpinner :: (bounds: Rectangle, text: *u8, value: *s32, minValue: s32, maxValue: s32, editMode: bool) -> s32 #foreign raygui;
GuiValueBox :: (bounds: Rectangle, text: *u8, value: *s32, minValue: s32, maxValue: s32, editMode: bool) -> s32 #foreign raygui;
GuiTextBox :: (bounds: Rectangle, text: *u8, textSize: s32, editMode: bool) -> s32 #foreign raygui;

GuiSlider :: (bounds: Rectangle, textLeft: *u8, textRight: *u8, value: *float, minValue: float, maxValue: float) -> s32 #foreign raygui;
GuiSliderBar :: (bounds: Rectangle, textLeft: *u8, textRight: *u8, value: *float, minValue: float, maxValue: float) -> s32 #foreign raygui;
GuiProgressBar :: (bounds: Rectangle, textLeft: *u8, textRight: *u8, value: *float, minValue: float, maxValue: float) -> s32 #foreign raygui;
GuiStatusBar :: (bounds: Rectangle, text: *u8) -> s32 #foreign raygui;
GuiDummyRec :: (bounds: Rectangle, text: *u8) -> s32 #foreign raygui;
GuiGrid :: (bounds: Rectangle, text: *u8, spacing: float, subdivs: s32, mouseCell: *Vector2) -> s32 #foreign raygui;

GuiListView :: (bounds: Rectangle, text: *u8, scrollIndex: *s32, active: *s32) -> s32 #foreign raygui;
GuiListViewEx :: (bounds: Rectangle, text: **u8, count: s32, scrollIndex: *s32, active: *s32, focus: *s32) -> s32 #foreign raygui;
GuiMessageBox :: (bounds: Rectangle, title: *u8, message: *u8, buttons: *u8) -> s32 #foreign raygui;
GuiTextInputBox :: (bounds: Rectangle, title: *u8, message: *u8, buttons: *u8, text: *u8, textMaxSize: s32, secretViewActive: *bool) -> s32 #foreign raygui;
GuiColorPicker :: (bounds: Rectangle, text: *u8, color: *Color) -> s32 #foreign raygui;
GuiColorPanel :: (bounds: Rectangle, text: *u8, color: *Color) -> s32 #foreign raygui;
GuiColorBarAlpha :: (bounds: Rectangle, text: *u8, alpha: *float) -> s32 #foreign raygui;
GuiColorBarHue :: (bounds: Rectangle, text: *u8, value: *float) -> s32 #foreign raygui;
GuiColorPickerHSV :: (bounds: Rectangle, text: *u8, colorHsv: *Vector3) -> s32 #foreign raygui;
GuiColorPanelHSV :: (bounds: Rectangle, text: *u8, colorHsv: *Vector3) -> s32 #foreign raygui;

GuiIconName :: enum s32 {
    NONE                    :: 0;
    FOLDER_FILE_OPEN        :: 1;
    FILE_SAVE_CLASSIC       :: 2;
    FOLDER_OPEN             :: 3;
    FOLDER_SAVE             :: 4;
    FILE_OPEN               :: 5;
    FILE_SAVE               :: 6;
    FILE_EXPORT             :: 7;
    FILE_ADD                :: 8;
    FILE_DELETE             :: 9;
    FILETYPE_TEXT           :: 10;
    FILETYPE_AUDIO          :: 11;
    FILETYPE_IMAGE          :: 12;
    FILETYPE_PLAY           :: 13;
    FILETYPE_VIDEO          :: 14;
    FILETYPE_INFO           :: 15;
    FILE_COPY               :: 16;
    FILE_CUT                :: 17;
    FILE_PASTE              :: 18;
    CURSOR_HAND             :: 19;
    CURSOR_POINTER          :: 20;
    CURSOR_CLASSIC          :: 21;
    PENCIL                  :: 22;
    PENCIL_BIG              :: 23;
    BRUSH_CLASSIC           :: 24;
    BRUSH_PAINTER           :: 25;
    WATER_DROP              :: 26;
    COLOR_PICKER            :: 27;
    RUBBER                  :: 28;
    COLOR_BUCKET            :: 29;
    TEXT_T                  :: 30;
    TEXT_A                  :: 31;
    SCALE                   :: 32;
    RESIZE                  :: 33;
    FILTER_POINT            :: 34;
    FILTER_BILINEAR         :: 35;
    CROP                    :: 36;
    CROP_ALPHA              :: 37;
    SQUARE_TOGGLE           :: 38;
    SYMMETRY                :: 39;
    SYMMETRY_HORIZONTAL     :: 40;
    SYMMETRY_VERTICAL       :: 41;
    LENS                    :: 42;
    LENS_BIG                :: 43;
    EYE_ON                  :: 44;
    EYE_OFF                 :: 45;
    FILTER_TOP              :: 46;
    FILTER                  :: 47;
    TARGET_POINT            :: 48;
    TARGET_SMALL            :: 49;
    TARGET_BIG              :: 50;
    TARGET_MOVE             :: 51;
    CURSOR_MOVE             :: 52;
    CURSOR_SCALE            :: 53;
    CURSOR_SCALE_RIGHT      :: 54;
    CURSOR_SCALE_LEFT       :: 55;
    UNDO                    :: 56;
    REDO                    :: 57;
    REREDO                  :: 58;
    MUTATE                  :: 59;
    ROTATE                  :: 60;
    REPEAT                  :: 61;
    SHUFFLE                 :: 62;
    EMPTYBOX                :: 63;
    TARGET                  :: 64;
    TARGET_SMALL_FILL       :: 65;
    TARGET_BIG_FILL         :: 66;
    TARGET_MOVE_FILL        :: 67;
    CURSOR_MOVE_FILL        :: 68;
    CURSOR_SCALE_FILL       :: 69;
    CURSOR_SCALE_RIGHT_FILL :: 70;
    CURSOR_SCALE_LEFT_FILL  :: 71;
    UNDO_FILL               :: 72;
    REDO_FILL               :: 73;
    REREDO_FILL             :: 74;
    MUTATE_FILL             :: 75;
    ROTATE_FILL             :: 76;
    REPEAT_FILL             :: 77;
    SHUFFLE_FILL            :: 78;
    EMPTYBOX_SMALL          :: 79;
    BOX                     :: 80;
    BOX_TOP                 :: 81;
    BOX_TOP_RIGHT           :: 82;
    BOX_RIGHT               :: 83;
    BOX_BOTTOM_RIGHT        :: 84;
    BOX_BOTTOM              :: 85;
    BOX_BOTTOM_LEFT         :: 86;
    BOX_LEFT                :: 87;
    BOX_TOP_LEFT            :: 88;
    BOX_CENTER              :: 89;
    BOX_CIRCLE_MASK         :: 90;
    POT                     :: 91;
    ALPHA_MULTIPLY          :: 92;
    ALPHA_CLEAR             :: 93;
    DITHERING               :: 94;
    MIPMAPS                 :: 95;
    BOX_GRID                :: 96;
    GRID                    :: 97;
    BOX_CORNERS_SMALL       :: 98;
    BOX_CORNERS_BIG         :: 99;
    FOUR_BOXES              :: 100;
    GRID_FILL               :: 101;
    BOX_MULTISIZE           :: 102;
    ZOOM_SMALL              :: 103;
    ZOOM_MEDIUM             :: 104;
    ZOOM_BIG                :: 105;
    ZOOM_ALL                :: 106;
    ZOOM_CENTER             :: 107;
    BOX_DOTS_SMALL          :: 108;
    BOX_DOTS_BIG            :: 109;
    BOX_CONCENTRIC          :: 110;
    BOX_GRID_BIG            :: 111;
    OK_TICK                 :: 112;
    CROSS                   :: 113;
    ARROW_LEFT              :: 114;
    ARROW_RIGHT             :: 115;
    ARROW_DOWN              :: 116;
    ARROW_UP                :: 117;
    ARROW_LEFT_FILL         :: 118;
    ARROW_RIGHT_FILL        :: 119;
    ARROW_DOWN_FILL         :: 120;
    ARROW_UP_FILL           :: 121;
    AUDIO                   :: 122;
    FX                      :: 123;
    WAVE                    :: 124;
    WAVE_SINUS              :: 125;
    WAVE_SQUARE             :: 126;
    WAVE_TRIANGULAR         :: 127;
    CROSS_SMALL             :: 128;
    PLAYER_PREVIOUS         :: 129;
    PLAYER_PLAY_BACK        :: 130;
    PLAYER_PLAY             :: 131;
    PLAYER_PAUSE            :: 132;
    PLAYER_STOP             :: 133;
    PLAYER_NEXT             :: 134;
    PLAYER_RECORD           :: 135;
    MAGNET                  :: 136;
    LOCK_CLOSE              :: 137;
    LOCK_OPEN               :: 138;
    CLOCK                   :: 139;
    TOOLS                   :: 140;
    GEAR                    :: 141;
    GEAR_BIG                :: 142;
    BIN                     :: 143;
    HAND_POINTER            :: 144;
    LASER                   :: 145;
    COIN                    :: 146;
    EXPLOSION               :: 147;
    _1UP                    :: 148;
    PLAYER                  :: 149;
    PLAYER_JUMP             :: 150;
    KEY                     :: 151;
    DEMON                   :: 152;
    TEXT_POPUP              :: 153;
    GEAR_EX                 :: 154;
    CRACK                   :: 155;
    CRACK_POINTS            :: 156;
    STAR                    :: 157;
    DOOR                    :: 158;
    EXIT                    :: 159;
    MODE_2D                 :: 160;
    MODE_3D                 :: 161;
    CUBE                    :: 162;
    CUBE_FACE_TOP           :: 163;
    CUBE_FACE_LEFT          :: 164;
    CUBE_FACE_FRONT         :: 165;
    CUBE_FACE_BOTTOM        :: 166;
    CUBE_FACE_RIGHT         :: 167;
    CUBE_FACE_BACK          :: 168;
    CAMERA                  :: 169;
    SPECIAL                 :: 170;
    LINK_NET                :: 171;
    LINK_BOXES              :: 172;
    LINK_MULTI              :: 173;
    LINK                    :: 174;
    LINK_BROKE              :: 175;
    TEXT_NOTES              :: 176;
    NOTEBOOK                :: 177;
    SUITCASE                :: 178;
    SUITCASE_ZIP            :: 179;
    MAILBOX                 :: 180;
    MONITOR                 :: 181;
    PRINTER                 :: 182;
    PHOTO_CAMERA            :: 183;
    PHOTO_CAMERA_FLASH      :: 184;
    HOUSE                   :: 185;
    HEART                   :: 186;
    CORNER                  :: 187;
    VERTICAL_BARS           :: 188;
    VERTICAL_BARS_FILL      :: 189;
    LIFE_BARS               :: 190;
    INFO                    :: 191;
    CROSSLINE               :: 192;
    HELP                    :: 193;
    FILETYPE_ALPHA          :: 194;
    FILETYPE_HOME           :: 195;
    LAYERS_VISIBLE          :: 196;
    LAYERS                  :: 197;
    WINDOW                  :: 198;
    HIDPI                   :: 199;
    FILETYPE_BINARY         :: 200;
    HEX                     :: 201;
    SHIELD                  :: 202;
    FILE_NEW                :: 203;
    FOLDER_ADD              :: 204;
    ALARM                   :: 205;
    CPU                     :: 206;
    ROM                     :: 207;
    STEP_OVER               :: 208;
    STEP_INTO               :: 209;
    STEP_OUT                :: 210;
    RESTART                 :: 211;
    BREAKPOINT_ON           :: 212;
    BREAKPOINT_OFF          :: 213;
    BURGER_MENU             :: 214;
    CASE_SENSITIVE          :: 215;
    REG_EXP                 :: 216;
    FOLDER                  :: 217;
    FILE                    :: 218;
    SAND_TIMER              :: 219;
    _220                    :: 220;
    _221                    :: 221;
    _222                    :: 222;
    _223                    :: 223;
    _224                    :: 224;
    _225                    :: 225;
    _226                    :: 226;
    _227                    :: 227;
    _228                    :: 228;
    _229                    :: 229;
    _230                    :: 230;
    _231                    :: 231;
    _232                    :: 232;
    _233                    :: 233;
    _234                    :: 234;
    _235                    :: 235;
    _236                    :: 236;
    _237                    :: 237;
    _238                    :: 238;
    _239                    :: 239;
    _240                    :: 240;
    _241                    :: 241;
    _242                    :: 242;
    _243                    :: 243;
    _244                    :: 244;
    _245                    :: 245;
    _246                    :: 246;
    _247                    :: 247;
    _248                    :: 248;
    _249                    :: 249;
    _250                    :: 250;
    _251                    :: 251;
    _252                    :: 252;
    _253                    :: 253;
    _254                    :: 254;
    _255                    :: 255;
}

#scope_file

#import "Basic"; // For push_context

user32  :: #system_library,link_always "user32";
gdi32   :: #system_library,link_always "gdi32";
shell32 :: #system_library,link_always "shell32";
winmm   :: #system_library,link_always "winmm";

raylib :: #library "lib/raylib";
raygui :: #library "lib/raygui";
