LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := recast_static

LOCAL_MODULE_FILENAME := librecast

LOCAL_ARM_MODE := arm

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/librecast.a
else
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/librecast.a
endif

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../..

include $(PREBUILT_STATIC_LIBRARY)
