# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo A | 7z x $DIR/armeabi/libcocos2d-x-debug.7z       -o$DIR/armeabi/debug
echo A | 7z x $DIR/armeabi/libcocos2d-x-release.7z     -o$DIR/armeabi/release
echo A | 7z x $DIR/armeabi-v7a/libcocos2d-x-debug.7z   -o$DIR/armeabi-v7a/debug
echo A | 7z x $DIR/armeabi-v7a/libcocos2d-x-release.7z -o$DIR/armeabi-v7a/release
echo A | 7z x $DIR/x86/libcocos2d-x-debug.7z           -o$DIR/x86/debug
echo A | 7z x $DIR/x86/libcocos2d-x-release.7z         -o$DIR/x86/release
