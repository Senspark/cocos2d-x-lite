//
//  ScreenSizeConfig.cpp
//  HelloCpp
//
//  Created by Zinge on 5/30/17.
//
//

#include "ResourcesConfig.hpp"

#include <cocos2d.h>

NS_GAME_BEGIN
ResourcesPackage getResourcesPackage(float designedWidth,
                                     float designedHeight) {
#if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    auto fileUtils = cocos2d::FileUtils::getInstance();
    if (fileUtils->isDirectoryExist("resources-ipadhd")) {
        return ResourcesPackage::Large;
    }
    if (fileUtils->isDirectoryExist("resources-iphonehd")) {
        return ResourcesPackage::Medium;
    }
    return ResourcesPackage::Small;
#else  // CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    // All resources are packed together.
    auto&& frameSize =
        cocos2d::Director::getInstance()->getOpenGLView()->getFrameSize();
    auto scale = std::min(frameSize.width / designedWidth,
                          frameSize.height / designedHeight);
    // Scale:      0 ..... 1.5 ...... 3 .....
    // Resolution:    x1         x2      x4
    // Package:      Small     Medium   Large
    if (scale >= 3) {
        return ResourcesPackage::Large;
    }
    if (scale >= 1.5f) {
        return ResourcesPackage::Medium;
    }
    return ResourcesPackage::Small;
#endif // CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
}
NS_GAME_END
