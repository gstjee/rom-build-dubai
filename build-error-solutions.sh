###### not a script but just here n there there found and tried potential solution for various build errors:

## Clang error(could be due to either source is WIP behind the scene at git)
* tried exporting from build script and board config .mk from device tree but still build choose r510928
export TARGET_KERNEL_CLANG_VERSION=r498229b
export TARGET_KERNEL_CLANG_PATH=/tmp/src/android/prebuilts/clang/host/linux-x86/clang-r498229b
or
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CLANG_VERSION := clang-r498229b
TARGET_KERNEL_CLANG_PATH := $(shell pwd)/prebuilts/clang/host/linux-x86/$(TARGET_KERNEL_CLANG_VERSION)

## some undefined/missing modules ex. platform_app_defaults, SettingsLibDefaults
* this may also related to above clang error due to WIP. mainly  originated when something missing in packages/apps/Settings repo

