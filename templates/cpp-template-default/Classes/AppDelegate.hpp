#ifndef GAME_APP_DELEGATE_HPP
#define GAME_APP_DELEGATE_HPP

#include "AppMacro.hpp"

#include <platform/CCApplication.h>

NS_GAME_BEGIN
/// The cocos2d Application.
/// Private inheritance here hides part of interface from Director.
class AppDelegate : private cocos2d::Application {
public:
    AppDelegate();
    virtual ~AppDelegate();

    virtual void initGLContextAttrs();

    /// Implement Director and Scene init code here.
    /// @return true    Initialize success, app continue.
    /// @return false   Initialize failed, app terminate.
    virtual bool applicationDidFinishLaunching();

    /// Called when the application moves to the background.
    virtual void applicationDidEnterBackground();

    /// Called when the application reenters the foreground.
    virtual void applicationWillEnterForeground();
};
NS_GAME_END

#endif // GAME_APP_DELEGATE_HPP
