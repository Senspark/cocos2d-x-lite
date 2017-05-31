LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos_network_static

LOCAL_MODULE_FILENAME := libnetwork

LOCAL_ARM_MODE := arm

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libnetwork.a
else
  LOCAL_SRC_FILES := ../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libnetwork.a
endif

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/..

LOCAL_STATIC_LIBRARIES := cocos2dx_internal_static
LOCAL_STATIC_LIBRARIES += libwebsockets_static

include $(PREBUILT_STATIC_LIBRARY)
