cd /mnt/Building/blu_spark-treble-pie
export USE_CCACHE=1
export HASH=`git rev-parse --short=8 HEAD`
export LOCALVERSION=~blu_spark-r150-oos-pie-$(date +%y%m%d)-$HASH
export KBUILD_COMPILER_STRING=$(/mnt/Building/infected-clang-8.x/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')
make O=../out clean
make O=../out mrproper
make O=../out ARCH=arm64 blu_spark_defconfig
ccache make -j$(nproc --all) O=../out ARCH=arm64 CC="/mnt/Building/infected-clang-8.x/bin/clang" CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE="/mnt/Building/gcc-arm-8.2-2018.11-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-"
#cd /mnt/Building/out
#cd drivers/staging/qcacld-3.0/
#/mnt/Building/aarch64-linux-gnu-7.x-original/bin/aarch64-linux-gnu-strip --strip-unneeded wlan.ko
#/mnt/Building/out/scripts/sign-file sha512 /mnt/Building/out/certs/signing_key.pem /mnt/Building/out/certs/signing_key.x509 wlan.ko
## copy assets
#cp -v wlan.ko /mnt/Building/AnyKernel2-reverse/ramdisk/modules
cd /mnt/Building/out/arch/arm64/boot
cp -v Image.gz-dtb /mnt/Building/AnyKernel2-blu_spark/Image.gz-dtb
cd /mnt/Building/AnyKernel2-blu_spark
zip -r9 blu_spark_r150-oos-pie-op5t-$(date +%y%m%d)-$HASH.zip *
mv -v blu_spark_r150-oos-pie-op5t-*.zip /mnt/Building/Out_Zips
echo "Done!!!"
