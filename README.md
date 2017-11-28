# Cocos2d-x Lite with Pod

## Changes

- Update tinyxml2 to 4.0.1
- Removed:
  - 3D nodes + particles
  - Navmesh
  - 2D + 3D Physics
  - Cocos Studio parser
  - VR
  - Lua + JS

## Prerequisite

- Dependencies:
  - 7z: `brew install p7zip`
  - Git LFS: `brew install git-lfs`
- For Android:
  - Android NDK r10e (`r10e` tag): [Download](https://dl.google.com/android/repository/android-ndk-r10e-darwin-x86_64.zip)
  - Android NDK r16 (`master` branch): [Download](https://dl.google.com/android/repository/android-ndk-r16-darwin-x86_64.zip)

## Drawbacks

- Cannot use `⌘ + ⇧ + O` to search for source files in Xcode.
- Breakpoints in Xcode.

## Integration

### iOS and macOS

- Modify `Podfile`
```
pod 'cocos2d-x', :git => 'https://github.com/Senspark/cocos2d-x-lite'
```

- Note: installing this pod will automatically overrides `~/.lldbinit-Xcode` to set the source files for debugging.

### Android

- Clone the repository to the project dir (i.e. the directory which contains `Classes`):

  - NDK r10e: `git clone -b r10e https://github.com/Senspark/cocos2d-x-lite cocos2d`
  - NDK r16: `git clone https://github.com/Senspark/cocos2d-x-lite cocos2d`

- Extract the prebuilt libraries:

```
cocos2d/prebuilt/libs/android/extract_libs.sh
```

- Project directory structure (see `templates/cpp-template-default` for example):

```
project-dir
├─── Classes
├─── cocos2d
├─── proj.android-studio
│    ├─── build.gradle
│    ├─── settings.gradle
│    └─── app
│         ├─── build.gradle
│         └─── src
│              └─── main
│                   ├─── AndroidManifest.xml
│                   ├─── java
│                   ├─── jni
│                   │    └─── Android.mk
│                   └─── res
├─── proj.ios_mac
└─── Resources
```

- Modify `settings.gradle`:

```
include ':libcocos2dx'
project(':libcocos2dx').projectDir = new File(settingsDir, '../cocos2d/cocos/platform/android/libcocos2dx')
```

- Modify `build.gradle`:

```
compile project(':libcocos2dx')
```

- Modify `Android.mk`:

```
$(call import-add-path, $(LOCAL_PATH)/../../../../../cocos2d

LOCAL_STATIC_LIBRARIES := cocos2dx_static

$(call import-module, cocos/prebuilt-mk)
```

## Build from source

### iOS and macOS

- Comment out `spec.prepare_command` in `cocos2d-x.podspec`:

```
  spec.prepare_command = <<-CMD
    # echo settings set target.source-map /Volumes/Setup/Android/projects/senspark/sde2/cocos2d/ $(pwd) > ~/.lldbinit-Xcode
    # echo Y | 7z x prebuilt/libs/ios/libcocos2d-x-debug.7z   -oprebuilt/libs/ios
    # echo Y | 7z x prebuilt/libs/ios/libcocos2d-x-release.7z -oprebuilt/libs/ios
    # echo Y | 7z x prebuilt/libs/mac/libcocos2d-x-debug.7z   -oprebuilt/libs/mac
    # echo Y | 7z x prebuilt/libs/mac/libcocos2d-x-release.7z -oprebuilt/libs/mac
  CMD
```

- Run:

```
cd prebuilt/proj.ios_mac
pod install
sh build.sh
```

- Header files will be generated in `prebuilt/include/ios` and `prebuilt/include/mac`
- Prebuilt libraries will be generated and zipped in `prebuilt/libs/ios` and `prebuilt/libs/mac`

### Android

- Change `$(call import-module, cocos/prebuilt-mk)` to `$(call import-module, cocos)` in `templates/cpp-template-default/proj.android-studio/app/src/main/jni/Android.mk`

- Create `local.properties`:

```
echo -e 'sdk.dir='$ANDROID_SDK_ROOT'\nndk.dir='$NDK_ROOT > templates/cpp-template-default/proj.android-studio/local.properties
```

- Run:

```
sh prebuilt/libs/android/compress_libs.sh
```

- Prebuilt libraries will be generated and zipped in `prebuilt/libs/android`