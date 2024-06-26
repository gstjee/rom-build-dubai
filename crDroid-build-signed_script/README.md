# crDroid-build-signed-script
Script for creating a signing build environment

## Disclaimer
This script only works for password-less keys

## How to run
Place the script in your root build directory

chmod +x create-signed-env.sh

./create-signed-env.sh

Enter info for certificate subject line and confirm

### Prep device tree
In your device tree (likely common) add:

-include vendor/lineage-priv/keys/keys.mk

Build as usual!
