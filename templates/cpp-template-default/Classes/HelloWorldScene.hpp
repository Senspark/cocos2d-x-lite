#ifndef GAME_HELLO_WORLD_SCENE_HPP
#define GAME_HELLO_WORLD_SCENE_HPP

#include "AppMacro.hpp"

#include <2d/CCScene.h>

NS_GAME_BEGIN
class HelloWorld : public cocos2d::Scene {
public:
    static cocos2d::Scene* createScene();

protected:
    // Implement the "static create()" method manually.
    CREATE_FUNC(HelloWorld);

    virtual bool init() override;

private:
    // A selector callback.
    void menuCloseCallback(cocos2d::Ref* pSender);
};
NS_GAME_END

#endif // GAME_HELLO_WORLD_SCENE_HPP
