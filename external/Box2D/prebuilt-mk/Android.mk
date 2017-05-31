LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := box2d_static

LOCAL_MODULE_FILENAME := libbox2d

LOCAL_ARM_MODE := arm

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libbox2d.a
else
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libbox2d.a
endif

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../..
                                 
include $(PREBUILT_STATIC_LIBRARY)
