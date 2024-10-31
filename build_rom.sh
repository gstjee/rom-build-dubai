#!/bin/bash

# run this script in rom source dir(ie 'rom')
set +x
if [ -f "sl" ]; then bash sl; fi
sleep 180

# apply some uncommited changes/patch from .new dir and from quick_adjustments.sh
cp -r .repo/.new/* ./
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/crave/quick_adjustments.sh | bash &&


bash tg "ROM build started at $(TZ='Asia/Kolkata' date +'%r %d %B')"
rm -rf status1
set -x

source build/envsetup.sh
breakfast dubai
croot

if [ "$1" == "clean" ];then
	make -j9 ARCH=arm clean
fi

make installclean
brunch dubai 2>&1 | tee dubai_rom_make.log


# uncomment only when first intialsing
#rm -rf frameworks/base packages/apps/Settings
#git clone https://github.com/crdroidandroid/android_frameworks_base.git -b 14.0 frameworks/base
#git clone https://github.com/crdroidandroid/android_packages_apps_Settings.git -b 14.0 packages/apps/Settings

set +x
bash tg "Brunch completed at $(TZ='Asia/Kolkata' date +'%r %d %B')"
#sudo apt update
echo "1" > status1
du -sh out/
sleep 100
if [ -f "log" ]; then bash log; fi

bash tg "dubai_rom_make.log"
bash up "$(cat dubai_rom_make.log | grep 'Package Complete' | awk -F': ' '{print $2}')"
# curl bashupload.com -T out/target/product/dubai/crDroidAndroid-14.0-20240515-dubai-v10.5.zip
