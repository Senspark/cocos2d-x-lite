#include <memory>

#include <android/log.h>
#include <jni.h>

#include "AppDelegate.hpp"

namespace {
std::unique_ptr<NS_GAME::AppDelegate> appDelegate;
} // namespace

void cocos_android_app_init(JNIEnv* env) {
    __android_log_print(ANDROID_LOG_DEBUG, "%s", __PRETTY_FUNCTION__);
    appDelegate.reset(new NS_GAME::AppDelegate());

    JavaVM* vm;
    env->GetJavaVM(&vm);
}
