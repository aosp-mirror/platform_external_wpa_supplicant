#
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Include this makefile to generate your hardware specific wpa_supplicant.conf
# Requires: WIFI_DRIVER_SOCKET_IFACE

WPA_SUPPLICANT_STORED_LOCAL_PATH := $(LOCAL_PATH)
LOCAL_PATH := $(call my-dir)

########################

WPA_SUPPLICANT_CONF_GENERATED := $(call intermediates-dir-for,ETC,wpa_supplicant.conf)/wpa_supplicant.conf
WPA_SUPPLICANT_CONF_TEMPLATE := $(LOCAL_PATH)/wpa_supplicant.conf
WPA_SUPPLICANT_CONF_SCRIPT := $(LOCAL_PATH)/wpa_supplicant_conf.sh
$(WPA_SUPPLICANT_CONF_GENERATED): $(WPA_SUPPLICANT_CONF_TEMPLATE) $(WPA_SUPPLICANT_CONF_SCRIPT)
	@echo Target wpa_supplicant.conf: $@
	@mkdir -p $(dir $@)
	$(hide) WIFI_DRIVER_SOCKET_IFACE="$(WIFI_DRIVER_SOCKET_IFACE)" \
		bash $(WPA_SUPPLICANT_CONF_SCRIPT) $(WPA_SUPPLICANT_CONF_TEMPLATE) > $@

PRODUCT_COPY_FILES += $(WPA_SUPPLICANT_CONF_GENERATED):system/etc/wifi/wpa_supplicant.conf

########################

LOCAL_PATH := $(WPA_SUPPLICANT_STORED_LOCAL_PATH)
