#
# Copyright (C) 2020 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/realme/RMX1941
ALLOW_MISSING_DEPENDENCIES := true

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Call proprietary blob setup
$(call inherit-product, vendor/realme/RMX1941/RMX1941-vendor.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# RealmeDirac
$(call inherit-product-if-exists, packages/apps/RealmeDirac/dirac.mk)

# Parts
$(call inherit-product-if-exists, packages/apps/RealmeParts/parts.mk)

PRODUCT_SHIPPING_API_LEVEL := 28

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 29

# Boot animation
TARGET_SCREEN_HEIGHT := 1560
TARGET_SCREEN_WIDTH := 720

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
	libvisualizer \
	libaudioprepocessing

PRODUCT_COPY_FILES += \
  $(DEVICE_PATH)/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_policy_configuration.xml \
  $(DEVICE_PATH)/audio/audio_effects.conf:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_effects.conf \
  $(DEVICE_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_effects.xml \
  $(DEVICE_PATH)/audio/diracmobile.config:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/diracmobile.config \
  $(DEVICE_PATH)/audio/libdirac.so:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/lib/soundfx/libdirac.so \
  $(DEVICE_PATH)/audio/libDiracAPI_SHARED.so:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/lib/libDiracAPI_SHARED.so 
  
# Bluetooth
PRODUCT_PACKAGES += \
	bt_mtk_iot_list \
	bt_stack \
	mtk_bt_fw
	
PRODUCT_COPY_FILES += \
  $(DEVICE_PATH)/bluetooth/bt_mtk_iot_list.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/bt_mtk_iot_list.conf \
  $(DEVICE_PATH)/bluetooth/mtk_bt_fw.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/mtk_bt_fw.conf \
  $(DEVICE_PATH)/bluetooth/mtk_bt_stack.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/mtk_bt_stack.conf
  
# PrebuiltPackages
PRODUCT_PACKAGES += \
    GoogleCameraGo
	
# Apns
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/apns-conf.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/apns-conf.xml \
	
# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6765:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6765

# Permissions
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/permissions/com.mediatek.op.ims.common.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.mediatek.op.ims.common.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-whitelist-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-whitelist-system.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-whitelist-system_ext.xml:$(TARGET_COPY_OUT_SYSTEM)/system_ext/etc/permissions/privapp-permissions-whitelist-system_ext.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-whitelist-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-whitelist-product.xml \
    $(DEVICE_PATH)/permissions/platform.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/platform.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml
	
# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0_system \
    android.hidl.manager@1.0_system \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder \
    libhwbinder.vendor

# IMS
PRODUCT_PACKAGES += \
    mtk-ims \
    mtk-ims-telephony

# ImsInit hack
PRODUCT_PACKAGES += \
    ImsInit

# Init
PRODUCT_PACKAGES += \
    init.mt6765.rc \
    init.safailnet.rc \
    fstab.mt6765 \
    perf_profile.sh \
    set_zram.sh

# Input/DT2W
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/keylayout/touchpanel.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/touchpanel.kl \
    $(DEVICE_PATH)/keylayout/ACCDET.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/ACCDET.kl \
    $(DEVICE_PATH)/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl \
    $(DEVICE_PATH)/keylayout/mtk-tpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-tpd.kl
	
# KPOC
PRODUCT_PACKAGES += \
    libsuspend \
    android.hardware.health@2.0

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.RMX1941

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

PRODUCT_PACKAGES += \
    NotchBarKiller

# Power
PRODUCT_PACKAGES += \
    power.mt6765

# Properties
-include $(DEVICE_PATH)/system.prop
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# RcsService
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    PresencePolling \
    RcsService

# Screen density
PRODUCT_AAPT_CONFIG := xxxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Symbols
PRODUCT_PACKAGES += \
    libshim_showlogo \
    libshim_vtservice

# Telephony
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common    

PRODUCT_PACKAGES += \
    ImsServiceBase

# Wi-Fi
PRODUCT_PACKAGES += \
    TetheringConfigOverlay \
    wpa_supplicant.conf \
    WifiOverlay
