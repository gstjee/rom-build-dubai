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

# devices trees
rm -rf .repo/local_manifests
mkdir -p .repo/local_manifests
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/crave/local_manifests/extras.xml > .repo/local_manifests/extras.xml
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/crave/local_manifests/motorola-common.xml > .repo/local_manifests/motorola-common.xml
curl https://raw.githubusercontent.com/gstjee/rom_build_dubai/crave/local_manifests/motorola-sm7325.xml > .repo/local_manifests/motorola-sm7325.xml

#repo sync -c --no-clone-bundle --prune --force-sync -j$(nproc --all)
# Sync the repositories
/opt/crave/resync.sh  &&
#repo sync -j4 --fail-fast

set +x
bash tg "repo init, rom sources and devices trees sync completed!!"
set -x
