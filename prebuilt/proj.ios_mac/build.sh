xcodebuild -workspace cocos2d_prebuilt.xcworkspace -scheme Pods-common-libcocos2d_prebuilt_desktop -configuration Debug   -sdk macosx          ONLY_ACTIVE_ARCH=NO -arch x86_64
xcodebuild -workspace cocos2d_prebuilt.xcworkspace -scheme Pods-common-libcocos2d_prebuilt_desktop -configuration Release -sdk macosx          ONLY_ACTIVE_ARCH=NO
xcodebuild -workspace cocos2d_prebuilt.xcworkspace -scheme Pods-common-libcocos2d_prebuilt_mobile  -configuration Debug   -sdk iphoneos        ONLY_ACTIVE_ARCH=NO -arch armv7
xcodebuild -workspace cocos2d_prebuilt.xcworkspace -scheme Pods-common-libcocos2d_prebuilt_mobile  -configuration Release -sdk iphoneos        ONLY_ACTIVE_ARCH=NO
xcodebuild -workspace cocos2d_prebuilt.xcworkspace -scheme Pods-common-libcocos2d_prebuilt_mobile  -configuration Debug   -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO -arch x86_64
xcodebuild -workspace cocos2d_prebuilt.xcworkspace -scheme Pods-common-libcocos2d_prebuilt_mobile  -configuration Release -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO

# Compress using 7z:
# 7z -mmt -bb3 -mx=9 -mfb=273 a libcocos2d-x-debug.7z libcocos2d-x-debug.a