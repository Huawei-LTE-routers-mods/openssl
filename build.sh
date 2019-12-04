#!/bin/bash
set -e

export PATH="/home/valdikss/mobile-modem-router/e5372/kernel/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabi/bin:$PATH"

mkdir -p installed/huawei/ || true

# Balong Hi6921 V7R11 (E3372h, E5770, E5577, E5573, E8372, E8378, etc) and Hi6930 V7R2 (E3372s, E5373, E5377, E5786, etc)
# softfp, vfpv3-d16 FPU, Android API 19
make clean
export CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -mthumb -O3 -Wall -s"
export CXXFLAGS="$CFLAGS"

./Configure --cross-compile-prefix=arm-linux-gnueabi- --prefix="${PWD}/installed/huawei/vfp3" --openssldir=/etc/ssl linux-armv4 no-gost no-camellia no-idea no-srp no-blake2 no-aria no-cast no-scrypt no-seed no-capieng no-static-engine no-siphash no-sm2 no-sm3 no-sm4 no-whirlpool no-dtls no-engine no-dynamic-engine no-dso no-rdrand no-hw-padlock no-tests shared "$CFLAGS"
make depend
make "$@"
make INSTALL_PREFIX="${PWD}/installed/huawei/vfp3" install
rsync -a "installed/huawei/vfp3${PWD}/installed/huawei/vfp3/." installed/huawei/vfp3

# Balong Hi6920 V7R1 (E3272, E3276, E5372, etc)
# soft, novfp, Android API 9
make clean
export CFLAGS="-march=armv7-a -mfloat-abi=soft -mthumb -O3 -Wall -s"
export CXXFLAGS="$CFLAGS"

./Configure --cross-compile-prefix=arm-linux-gnueabi- --prefix="${PWD}/installed/huawei/novfp" --openssldir=/etc/ssl linux-armv4 no-gost no-camellia no-idea no-srp no-blake2 no-aria no-cast no-scrypt no-seed no-capieng no-static-engine no-siphash no-sm2 no-sm3 no-sm4 no-whirlpool no-dtls no-engine no-dynamic-engine no-dso no-rdrand no-hw-padlock no-tests shared "$CFLAGS"
make depend
make "$@"
make INSTALL_PREFIX="${PWD}/installed/huawei/novfp" install
rsync -a "installed/huawei/novfp${PWD}/installed/huawei/novfp/." installed/huawei/novfp


echo
echo "Done, check installed/huawei/ folder."
