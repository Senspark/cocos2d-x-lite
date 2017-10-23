#include "AppDelegate.hpp"
#include "HelloWorldScene.hpp"
#include "ResourcesConfig.hpp"

#include <cocos2d.h>

// #define USE_AUDIO_ENGINE 1
// #define USE_SIMPLE_AUDIO_ENGINE 1

#if USE_AUDIO_ENGINE && USE_SIMPLE_AUDIO_ENGINE
#error                                                                         \
    "Don't use AudioEngine and SimpleAudioEngine at the same time. Please just select one in your game!"
#endif

#if USE_AUDIO_ENGINE
#include <audio/include/AudioEngine.h>
#elif USE_SIMPLE_AUDIO_ENGINE
#include <audio/include/SimpleAudioEngine.h>
#endif

NS_GAME_BEGIN
namespace {
const auto DesignResolution = cocos2d::Size(480, 320);
} // namespace

AppDelegate::AppDelegate() {}

AppDelegate::~AppDelegate() {
#if USE_AUDIO_ENGINE
    cocos2d::experimental::AudioEngine::end();
#elif USE_SIMPLE_AUDIO_ENGINE
    CocosDenshion::SimpleAudioEngine::end();
#endif
}

// if you want a different context, modify the value of glContextAttrs
// it will affect all platforms
void AppDelegate::initGLContextAttrs() {
// set OpenGL context attributes: red,green,blue,alpha,depth,stencil
#if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    GLContextAttrs glContextAttrs = {8, 8, 8, 8, 16, 8};
#else  // CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    GLContextAttrs glContextAttrs = {8, 8, 8, 8, 24, 8};
#endif // CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    cocos2d::GLView::setGLContextAttrs(glContextAttrs);
}

// if you want to use the package manager to install more packages,
// don't modify or remove this function
static int register_all_packages() {
    return 0; // flag for packages manager
}

bool AppDelegate::applicationDidFinishLaunching() {
    cocos2d::log(__PRETTY_FUNCTION__);

    // initialize director
    auto director = cocos2d::Director::getInstance();
    auto glview = director->getOpenGLView();
    if (glview == nullptr) {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) ||                               \
    (CC_TARGET_PLATFORM == CC_PLATFORM_MAC) ||                                 \
    (CC_TARGET_PLATFORM == CC_PLATFORM_LINUX)
        glview = cocos2d::GLViewImpl::createWithRect(
            "HelloCpp", cocos2d::Rect(0, 0, DesignResolution.width,
                                      DesignResolution.height));
#else
        glview = cocos2d::GLViewImpl::create("HelloCpp");
#endif
        director->setOpenGLView(glview);
    }

#ifndef NDEBUG
    // Turn on display FPS on debug build.
    director->setDisplayStats(true);
#endif // NDEBUG

    // set FPS. the default value is 1.0/60 if you don't call this.
    director->setAnimationInterval(1.0f / 60);

    // Set the design resolution.
    // Use FIXED_WIDTH for portrait mode.
    // Use FIXED_HEIGHT for landscape mode.
    auto resolutionPolicy = (DesignResolution.height > DesignResolution.width
                                 ? ResolutionPolicy::FIXED_WIDTH
                                 : ResolutionPolicy::FIXED_HEIGHT);
    glview->setDesignResolutionSize(DesignResolution.width,
                                    DesignResolution.height, resolutionPolicy);

    auto&& frameSize = glview->getFrameSize();
    cocos2d::log("frameSize = %f %f", frameSize.width, frameSize.height);

    auto resourcesPackage =
        getResourcesPackage(DesignResolution.width, DesignResolution.height);

    auto fileUtils = cocos2d::FileUtils::getInstance();
    if (resourcesPackage == ResourcesPackage::Small) {
        director->setContentScaleFactor(1.0f);
        fileUtils->addSearchPath("resources-iphone");
    } else if (resourcesPackage == ResourcesPackage::Medium) {
        director->setContentScaleFactor(2.0f);
        fileUtils->addSearchPath("resources-iphonehd");
    } else {
        director->setContentScaleFactor(4.0f);
        fileUtils->addSearchPath("resources-ipadhd");
    }

    register_all_packages();

    // create a scene. it's an autorelease object
    auto scene = HelloWorld::createScene();

    // run
    director->runWithScene(scene);

    return true;
}

// This function will be called when the app is inactive. Note, when receiving a
// phone call it is invoked.
void AppDelegate::applicationDidEnterBackground() {
    cocos2d::log(__PRETTY_FUNCTION__);
    cocos2d::Director::getInstance()->stopAnimation();

#if USE_AUDIO_ENGINE
    cocos2d::experimental::AudioEngine::pauseAll();
#elif USE_SIMPLE_AUDIO_ENGINE
    CocosDenshion::SimpleAudioEngine::getInstance()->pauseBackgroundMusic();
    CocosDenshion::SimpleAudioEngine::getInstance()->pauseAllEffects();
#endif
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground() {
    cocos2d::log(__PRETTY_FUNCTION__);
    cocos2d::Director::getInstance()->startAnimation();

#if USE_AUDIO_ENGINE
    cocos2d::experimental::AudioEngine::resumeAll();
#elif USE_SIMPLE_AUDIO_ENGINE
    CocosDenshion::SimpleAudioEngine::getInstance()->resumeBackgroundMusic();
    CocosDenshion::SimpleAudioEngine::getInstance()->resumeAllEffects();
#endif
}
NS_GAME_END
