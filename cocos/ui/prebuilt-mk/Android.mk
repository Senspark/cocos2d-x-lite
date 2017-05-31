LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos_ui_static

LOCAL_MODULE_FILENAME := libui

LOCAL_ARM_MODE := arm

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libui.a
else
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libui.a
endif

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../editor-support

LOCAL_STATIC_LIBRARIES := cocos_extension_static

include $(PREBUILT_STATIC_LIBRARY)
