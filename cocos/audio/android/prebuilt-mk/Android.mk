LOCAL_PATH := $(call my-dir)

# New AudioEngine
include $(CLEAR_VARS)

LOCAL_MODULE := audioengine_static

LOCAL_MODULE_FILENAME := libaudioengine

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libaudioengine.a
else
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libaudioengine.a
endif

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../include

LOCAL_EXPORT_LDLIBS := -lOpenSLES

LOCAL_STATIC_LIBRARIES += libvorbisidec libpvmp3dec

include $(PREBUILT_STATIC_LIBRARY)

# SimpleAudioEngine
include $(CLEAR_VARS)

LOCAL_MODULE := cocosdenshion_static

LOCAL_MODULE_FILENAME := libcocosdenshion

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libcocosdenshion.a
else
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libcocosdenshion.a
endif

LOCAL_STATIC_LIBRARIES := audioengine_static

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../include

include $(PREBUILT_STATIC_LIBRARY)

$(call import-module, external/android-specific/tremolo/prebuilt-mk)
$(call import-module, external/android-specific/pvmp3dec/prebuilt-mk)
