#!/bin/bash

# run this script in where you you want to create rom source dir
#mkdir -p rom_dubai && cd rom_dubai
set +x
if [ ! -f "tg" ]; then
	cp -r .repo/.new/* ./
fi
bash tg "Crave build(repo sync part) started at $(TZ='Asia/Kolkata' date +'%r %d %B')"
set -x
echo "current dir: $(pwd)"

# rom you  want to build
repo init -u https://github.com/gstjee/android_crd.git -b 14.0 --git-lfs

# initial setup only(comment previous one)
#repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs

# devices trees
rm -rf .repo/local_manifests && mkdir -p .repo/local_manifests
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/crave/local_manifests/extras.xml > .repo/local_manifests/extras.xml
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/crave/local_manifests/motorola-common.xml > .repo/local_manifests/motorola-common.xml
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/crave/local_manifests/motorola-sm7325.xml > .repo/local_manifests/motorola-sm7325.xml

#repo sync -c --no-clone-bundle --prune --force-sync -j$(nproc --all)
# Sync the repositories
/opt/crave/resync.sh &&
#repo sync -j4 --fail-fast


# initial setup only(comment either this or next)
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/crave/own-repos.sh | bash &&

# initial setup only(comment either this previous)
#git clone https://github.com/LineageOS/android_device_motorola_sm7325-common.git -b lineage-21 device/motorola/sm7325-common
#git clone https://github.com/LineageOS/android_device_motorola_dubai.git -b lineage-21 device/motorola/dubai
#git clone --depth=1 https://github.com/TheMuppets/proprietary_vendor_motorola_dubai.git -b lineage-21 vendor/motorola/dubai


sleep 20
# workaround for git lfs issue(also if stuck somewhere then move on to next command)
timeout 1200 bash -c "repo forall -c 'GIT_TRACE=1 GIT_CURL_VERBOSE=1 git lfs install && GIT_TRACE=1 GIT_CURL_VERBOSE=1 git lfs pull && GIT_TRACE=1 GIT_CURL_VERBOSE=1 git lfs checkout'"

set +x
bash tg "repo init, rom sources and devices trees sync completed!!"
sleep 60
if [ -f "sl" ]; then bash sl; fi
set -x

repo init -u https://github.com/gstjee/android_crd.git -b 14.0 --git-lfs
