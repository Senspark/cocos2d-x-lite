LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos3d_static
LOCAL_ARM_MODE := arm

LOCAL_MODULE_FILENAME := libcocos3d

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libcocos3d.a
else
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libcocos3d.a
endif

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../..

LOCAL_STATIC_LIBRARIES := cocos2dx_internal_static

include $(PREBUILT_STATIC_LIBRARY)