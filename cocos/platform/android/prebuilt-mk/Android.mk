LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dxandroid_static

LOCAL_MODULE_FILENAME := libcocos2dandroid

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libcocos2dandroid.a
else
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libcocos2dandroid.a
endif

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/..

LOCAL_EXPORT_LDLIBS := \
-lGLESv2 \
-lEGL \
-llog \
-landroid

include $(PREBUILT_STATIC_LIBRARY)
