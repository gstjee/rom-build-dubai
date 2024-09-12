#!/bin/bash

# add, set or run commands, variables  after repo sync and before  breakfast.
# this scripts added to avoide clutter in repos for very small changes.

# no face unlock
sed -i '/ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)/,/endif/d' vendor/lineage/config/crdroid.mk

# no UDFPS animation while keeping UDFPS icons
sed -i '/UdfpsIcons/{:a;N;/UdfpsAnimations/!ba;s/.*/    UdfpsIcons/}' vendor/addons/config.mk


echo "quick_adjustments script has been executed sucessfully."

