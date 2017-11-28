LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dx_internal_static

LOCAL_MODULE_FILENAME := libcocos2dxinternal

LOCAL_ARM_MODE := arm

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libcocos2dxinternal.a
else
  LOCAL_SRC_FILES := ../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libcocos2dxinternal.a
endif

LOCAL_EXPORT_C_INCLUDES := \
$(LOCAL_PATH)/.. \
$(LOCAL_PATH)/../. \
$(LOCAL_PATH)/../.. \
$(LOCAL_PATH)/../../external \
$(LOCAL_PATH)/../../external/tinyxml2 \
$(LOCAL_PATH)/../../external/unzip \
$(LOCAL_PATH)/../../external/xxhash \
$(LOCAL_PATH)/../../external/poly2tri \
$(LOCAL_PATH)/../../external/poly2tri/common \
$(LOCAL_PATH)/../../external/poly2tri/sweep \
$(LOCAL_PATH)/../../external/clipper


LOCAL_EXPORT_LDLIBS := \
-lGLESv2 \
-llog \
-landroid

LOCAL_STATIC_LIBRARIES := cocos_freetype2_static
LOCAL_STATIC_LIBRARIES += cocos_png_static
LOCAL_STATIC_LIBRARIES += cocos_jpeg_static
LOCAL_STATIC_LIBRARIES += cocos_tiff_static
LOCAL_STATIC_LIBRARIES += cocos_webp_static
LOCAL_STATIC_LIBRARIES += cocos_zlib_static
LOCAL_STATIC_LIBRARIES += cocos_ssl_static
LOCAL_STATIC_LIBRARIES += bullet_static

LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dxandroid_static
LOCAL_WHOLE_STATIC_LIBRARIES += cpufeatures

# define the macro to compile through support/zip_support/ioapi.c
LOCAL_CFLAGS := -DUSE_FILE32API
LOCAL_CFLAGS += -fexceptions

# Issues #9968
#ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
#    LOCAL_CFLAGS += -DHAVE_NEON=1
#endif

LOCAL_CPPFLAGS := -Wno-deprecated-declarations
LOCAL_EXPORT_CFLAGS := -DUSE_FILE32API
LOCAL_EXPORT_CPPFLAGS := -Wno-deprecated-declarations

include $(PREBUILT_STATIC_LIBRARY)

#==============================================================

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dx_static
LOCAL_MODULE_FILENAME := libcocos2d

ifeq ($(NDK_DEBUG),1)
  LOCAL_SRC_FILES := ../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/debug/libcocos2d.a
else
  LOCAL_SRC_FILES := ../../prebuilt/libs/android/$(TARGET_ARCH_ABI)/release/libcocos2d.a
endif

LOCAL_STATIC_LIBRARIES := cocosbuilder_static
LOCAL_STATIC_LIBRARIES += spine_static
LOCAL_STATIC_LIBRARIES += cocos_network_static
LOCAL_STATIC_LIBRARIES += audioengine_static
LOCAL_STATIC_LIBRARIES += cocosdenshion_static
LOCAL_STATIC_LIBRARIES += cocos_ui_static

# Fix linking errors when use prebuilt libs.
LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_internal_static

include $(PREBUILT_STATIC_LIBRARY)
#==============================================================
$(call import-module, android/cpufeatures)
$(call import-module, cocos/audio/android/prebuilt-mk)
$(call import-module, cocos/editor-support/cocosbuilder/prebuilt-mk)
$(call import-module, cocos/editor-support/spine/prebuilt-mk)
$(call import-module, cocos/network/prebuilt-mk)
$(call import-module, cocos/platform/android/prebuilt-mk)
$(call import-module, cocos/ui/prebuilt-mk)
$(call import-module, extensions/prebuilt-mk)
$(call import-module, external/Box2D/prebuilt-mk)
$(call import-module, external/bullet/prebuilt/android)
# $(call import-module, external/curl/prebuilt/android)
$(call import-module, external/freetype2/prebuilt/android)
$(call import-module, external/jpeg/prebuilt/android)
$(call import-module, external/openssl/prebuilt/android)
$(call import-module, external/png/prebuilt/android)
$(call import-module, external/tiff/prebuilt/android)
$(call import-module, external/webp/prebuilt/android)
$(call import-module, external/websockets/prebuilt/android)
$(call import-module, external/zlib/prebuilt/android)