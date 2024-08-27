#!/bin/bash

BASE_DIR=$(pwd)

#repo directories
F_B_DIR="frameworks/base"
P_A_S_DIR="packages/apps/Settings"
P_A_crDS_DIR="packages/apps/crDroidSettings"
V_M_D_DIR="vendor/motorola/dubai"
D_M_SM_DIR="device/motorola/sm7325-common"
D_M_D_DIR="device/motorola/dubai"
crd_branch="14.0"
los_branch="lineage-21"

# rom sources check: if missing then atleast initialise them with basic repos
[ -f ./repo-clone-done ] && exit 0
rm -rf $F_B_DIR $P_A_S_DIR $P_A_crDS_DIR $V_M_D_DIR $D_M_D_DIR $D_M_SM_DIR

# crDroid check:
# frameworks/base
if [[ ! -d "$F_B_DIR" ]]; then
git clone https://github.com/crdroidandroid/android_frameworks_base.git -b "$crd_branch" "$F_B_DIR"
cd "$F_B_DIR" && git remote add mid https://github.com/gstjee/frameworks_base_crd-mid.git && git remote add gstjee https://github.com/gstjee/frameworks_base_crd.git
cd "$BASE_DIR"
fi

# packages/apps/Settings
if [[ ! -d "$P_A_S_DIR" ]]; then
git clone https://github.com/crdroidandroid/android_packages_apps_Settings.git -b "$crd_branch" "$P_A_S_DIR"
cd "$P_A_S_DIR" && git remote add mid https://github.com/gstjee/packages_apps_Settings_crd-mid.git && git remote add gstjee https://github.com/gstjee/packages_apps_Settings_crd.git
cd "$BASE_DIR"
fi

# packages/apps/crDroidSettings
if [[ ! -d "$P_A_crDS_DIR" ]]; then
git clone https://github.com/crdroidandroid/android_packages_apps_crDroidSettings.git -b "$crd_branch" "$P_A_crDS_DIR"
cd "$P_A_crDS_DIR" && git remote add mid https://github.com/gstjee/packages_apps_crDroidSettings_crd-mid.git && git remote add gstjee https://github.com/gstjee/packages_apps_crDroidSettings_crd.git
cd "$BASE_DIR"
fi


# device tree check:
# vendor/motorola/dubai
if [[ ! -d "$V_M_D_DIR" ]]; then
git clone --depth=1 https://github.com/gstjee/vendor_motorola_dubai-mid.git -b "$los_branch" "$V_M_D_DIR"
cd "$V_M_D_DIR" && git remote add gstjee https://gitlab.com/gstjee/vendor_motorola_dubai.git && git fetch --depth=5 origin -b "$los_branch"
cd "$BASE_DIR"
fi

# device/motorola/sm7325-common
if [[ ! -d "$D_M_SM_DIR" ]]; then
git clone https://github.com/gstjee/device_motorola_sm7325-common-mid.git -b "$los_branch" "$D_M_SM_DIR"
cd "$D_M_SM_DIR" && git remote add gstjee https://github.com/gstjee/device_motorola_sm7325-common.git
cd "$BASE_DIR"
fi

# device/motorola/dubai
if [[ ! -d "$D_M_D_DIR" ]]; then
git clone https://github.com/gstjee/device_motorola_dubai-mid.git -b "$los_branch" "$D_M_D_DIR"
cd "$D_M_D_DIR" && git remote add gstjee https://github.com/gstjee/device_motorola_dubai.git
cd "$BASE_DIR"
echo "1" > ./repo-clone-done
fi
