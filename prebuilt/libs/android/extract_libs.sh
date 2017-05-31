# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR
echo Y | 7z x $DIR/armeabi/libcocos2d-x-debug.7z       -o$DIR/armeabi/debug
echo Y | 7z x $DIR/armeabi/libcocos2d-x-release.7z     -o$DIR/armeabi/release
echo Y | 7z x $DIR/armeabi-v7a/libcocos2d-x-debug.7z   -o$DIR/armeabi-v7a/debug
echo Y | 7z x $DIR/armeabi-v7a/libcocos2d-x-release.7z -o$DIR/armeabi-v7a/release
echo Y | 7z x $DIR/x86/libcocos2d-x-debug.7z           -o$DIR/x86/debug
echo Y | 7z x $DIR/x86/libcocos2d-x-release.7z         -o$DIR/x86/release