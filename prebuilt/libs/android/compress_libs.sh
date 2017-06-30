# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR=$DIR/../../../templates/cpp-template-default/proj.android-studio

# Build all.
$PROJECT_DIR/gradlew -p $PROJECT_DIR assemble

ARM_32_STRIP_PATH=$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/arm-linux-androideabi/bin/strip
ARM_64_STRIP_PATH=$NDK_ROOT/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/aarch64-linux-android/bin/strip
X86_64_STRIP_PATH=$NDK_ROOT/toolchains/x86-4.9/prebuilt/darwin-x86_64/i686-linux-android/bin/strip

LIBS=(
    libaudioengine
    libbox2d
    libbullet
    libcocos2d
    libcocos2dandroid
    libcocos2dxinternal
    libcocos3d
    libcocosbuilder
    libcocosdenshion
    libcpufeatures
    libextension
    libnetwork
    libpvmp3dec
    librecast
    libspine
    libcocosbuilder
    libui
    libvorbisidec
)

# $1 excutable
# $2 input
# $3 output
function strip() {
    echo $1 $2 $3
    for LIB in "${LIBS[@]}"
    do
        echo $1 -S $2/$LIB.a -o $3/$LIB.a
        $1 -S $2/$LIB.a -o $3/$LIB.a
    done
}

OBJ_DIR=$PROJECT_DIR/app/src/main/obj
LIBS_DIR=$DIR

# Strip debug symbols.
strip $ARM_32_STRIP_PATH "$OBJ_DIR/debug/local/armeabi"       $LIBS_DIR/armeabi/debug
strip $ARM_32_STRIP_PATH "$OBJ_DIR/release/local/armeabi"     $LIBS_DIR/armeabi/release

strip $ARM_32_STRIP_PATH "$OBJ_DIR/debug/local/armeabi-v7a"   $LIBS_DIR/armeabi-v7a/debug
strip $ARM_32_STRIP_PATH "$OBJ_DIR/release/local/armeabi-v7a" $LIBS_DIR/armeabi-v7a/release

strip $X86_64_STRIP_PATH "$OBJ_DIR/debug/local/x86"           $LIBS_DIR/x86/debug
strip $X86_64_STRIP_PATH "$OBJ_DIR/release/local/x86"         $LIBS_DIR/x86/release

# $1 = source file
# $2 = destination file
function compress() {
    # Compress using 7z:
    # 7z -mmt -bb3 -mx=9 -mfb=273 a libcocos2d-x-debug.7z libcocos2d-x-debug.a
    echo ==== Compress: $1 to $2 ====
    7z -mmt -bb3 -mx=9 -mfb=273 a $2 $1
}

# Compress using 7z.
compress "$LIBS_DIR/armeabi/debug/*.a"       $LIBS_DIR/armeabi/libcocos2d-x-debug.7z
compress "$LIBS_DIR/armeabi/release/*.a"     $LIBS_DIR/armeabi/libcocos2d-x-release.7z
compress "$LIBS_DIR/armeabi-v7a/debug/*.a"   $LIBS_DIR/armeabi-v7a/libcocos2d-x-debug.7z
compress "$LIBS_DIR/armeabi-v7a/release/*.a" $LIBS_DIR/armeabi-v7a/libcocos2d-x-release.7z
compress "$LIBS_DIR/x86/debug/*.a"           $LIBS_DIR/x86/libcocos2d-x-debug.7z
compress "$LIBS_DIR/x86/release/*.a"         $LIBS_DIR/x86/libcocos2d-x-release.7z
