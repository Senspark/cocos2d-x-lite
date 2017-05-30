#include "HelloWorldScene.hpp"

#include <audio/include/SimpleAudioEngine.h>
#include <cocos2d.h>

NS_GAME_BEGIN
cocos2d::Scene* HelloWorld::createScene() {
    return HelloWorld::create();
}

bool HelloWorld::init() {
    // On "init" you need to initialize your instance.

    //////////////////////////////
    // 1. Super init first.
    if (not Scene::init()) {
        return false;
    }

    auto visibleSize = _director->getVisibleSize();
    auto&& origin = _director->getVisibleOrigin();

    /////////////////////////////
    // 2. Add a menu item with "X" image, which is clicked to quit the program
    //    you may modify it.

    // Add a "close" icon to exit the progress. It's an autorelease object.
    auto closeItem = cocos2d::MenuItemImage::create(
        "CloseNormal.png", "CloseSelected.png",
        CC_CALLBACK_1(HelloWorld::menuCloseCallback, this));

    closeItem->setPosition(cocos2d::Point(
        origin.x + visibleSize.width - closeItem->getContentSize().width / 2,
        origin.y + closeItem->getContentSize().height / 2));

    // Create menu, it's an autorelease object.
    auto menu = cocos2d::Menu::create(closeItem, nullptr);
    menu->setPosition(cocos2d::Point::ZERO);
    addChild(menu, 1);

    /////////////////////////////
    // 3. Add your codes below...

    // Add a label shows "Hello World".
    // Create and initialize a label.
    auto label = cocos2d::Label::createWithTTF("Hello World",
                                               "fonts/Marker Felt.ttf", 24);

    // Position the label on the center of the screen
    label->setPosition(cocos2d::Point(origin.x + visibleSize.width / 2,
                                      origin.y + visibleSize.height -
                                          label->getContentSize().height));

    // Add the label as a child to this layer.
    addChild(label, 1);

    // Add "HelloWorld" splash screen".
    auto sprite = cocos2d::Sprite::create("HelloWorld.png");

    // Position the sprite on the center of the screen.
    sprite->setPosition(cocos2d::Point(visibleSize.width / 2 + origin.x,
                                       visibleSize.height / 2 + origin.y));

    // Add the sprite as a child to this layer.
    addChild(sprite, 0);

    return true;
}

void HelloWorld::menuCloseCallback(cocos2d::Ref* pSender) {
    // Close the cocos2d-x game scene and quit the application
    _director->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    std::exit(0);
#endif

    /*To navigate back to native iOS screen(if present) without quitting the
     * application  ,do not use Director::getInstance()->end() and exit(0) as
     * given above,instead trigger a custom event created in
     * RootViewController.mm as below*/

    // EventCustom customEndEvent("game_scene_close_event");
    //_eventDispatcher->dispatchEvent(&customEndEvent);
}
NS_GAME_END
