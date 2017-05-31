LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libpvmp3dec.a
else
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libpvmp3dec.a
endif

LOCAL_EXPORT_C_INCLUDES := \
$(LOCAL_PATH)/../src \
$(LOCAL_PATH)/../include

LOCAL_CFLAGS := -D"OSCL_UNUSED_ARG(x)=(void)(x)"

LOCAL_CFLAGS += -Werror
LOCAL_CLANG := true
LOCAL_SANITIZE := signed-integer-overflow

LOCAL_MODULE := libpvmp3dec

LOCAL_ARM_MODE := arm

include $(PREBUILT_STATIC_LIBRARY)
