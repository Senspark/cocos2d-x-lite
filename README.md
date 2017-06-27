# Cocos2d-x-3.15 Lite with Pod

## Changes

- Update tinyxml2 to 4.0.1
- Remove 3D particles and cocostudio.

## Prerequisite

- Dependencies:
  - 7z: `brew install p7zip`
  - Git LFS: `brew install git-lfs`
- Android NDK r10e (for Android installation): [Download](https://dl.google.com/android/repository/android-ndk-r10e-darwin-x86_64.zip)

## Drawbacks

- Cannot use `⌘ + ⇧ + O` to search for source files in Xcode.

## Integration

### iOS and MacOS

- Modify `Podfile`

```
pod 'cocos2d-x', :git => 'https://github.com/Senspark/cocos2d-x-3.15'
```

- Note: installing this pod will automatically overrides `~/.lldbinit-Xcode` to set the source files for debugging.

### Android

- Clone the repository to the project dir (i.e. the directory which contains `Classes`):

```
git clone https://github.com/Senspark/cocos2d-x-3.15 cocos2d
```

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