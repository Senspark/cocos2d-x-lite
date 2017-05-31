LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libvorbisidec.a
else
  LOCAL_SRC_FILES := ../../../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libvorbisidec.a
endif

# Disable arm optimization which will cause the issue https://github.com/cocos2d/cocos2d-x/issues/17148
# ifeq ($(TARGET_ARCH),arm)
# LOCAL_SRC_FILES += \
# 	Tremolo/bitwiseARM.s \
# 	Tremolo/dpen.s \
# 	Tremolo/floor1ARM.s \
# 	Tremolo/mdctARM.s
# LOCAL_CFLAGS += \
#     -D_ARM_ASSEM_
# # Assembly code in asm_arm.h does not compile with Clang.
# LOCAL_CLANG_ASFLAGS_arm += \
#     -no-integrated-as
# else
LOCAL_CFLAGS += -DONLY_C
# endif
LOCAL_CFLAGS += -O2

LOCAL_C_INCLUDES:= $(LOCAL_PATH)/Tremolo

LOCAL_ARM_MODE := arm

LOCAL_MODULE := libvorbisidec

include $(PREBUILT_STATIC_LIBRARY)
