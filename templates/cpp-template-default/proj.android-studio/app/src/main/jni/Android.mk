LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

PROJECT_DIR := $(LOCAL_PATH)/../../../../..

$(call import-add-path, $(PROJECT_DIR)/cocos2d)

LOCAL_MODULE := cocos2dcpp

LOCAL_SRC_FILES := cpp/main.cpp
LOCAL_SRC_FILES += ${shell find $(PROJECT_DIR)/Classes -name "*.cpp" -print}

LOCAL_C_INCLUDES := ${shell find $(PROJECT_DIR)/Classes -type d -print}

LOCAL_STATIC_LIBRARIES := cocos2dx_static

include $(BUILD_SHARED_LIBRARY)

# $(call import-module, cocos)
$(call import-module, cocos/prebuilt-mk)