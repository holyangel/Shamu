#!/bin/bash

##############################

# Defconfig
	dc=sd_defconfig

# Path to kernel source
	k=/home/holyangel/android/Shamu

# Path to clean out
	co=~/android/Shamu/out

# Compile Path to out
	o="O=/home/holyangel/android/Shamu/out"

# Path to image.gz-dtb
	i=~/android/Shamu/out/arch/arm/boot/zImage-dtb

# Kernel zip module path
	zm=~/Downloads/SkyDragon_Shamu_V3/Build/modules

# Completed kernel zimage path
	zi=~/Downloads/SkyDragon_Shamu_V3/Build/zImage
	
# Path to whole kernel zip folders
	zp=~/Downloads/SkyDragon_Shamu_V3/Build/
	
# Path to whole kernel zip folders
	zu=~/Downloads/SkyDragon_Shamu_V3/Upload/

# Kernel zip Name
	kn=SDK_Shamu_V3.zip

##############################

# Cleanup
	echo "	Cleaning up out directory"
	rm -rf "$co"
	echo "	Out directory removed!"

##############################

# Make out
	echo "	Making new out directory"
	mkdir -p "$co"
	echo "	Created new out directory"

##############################

# Establish defconfig
	echo "	Establishing build environment.."
	make "$o" "$dc"

# Start Compile
	echo "	First pass started.."
	make "$o" -j64
	echo "	First pass completed!"
	echo "	"
	echo "	Starting Second Pass.."
	make "$o" -j64
	echo "	Second pass completed!"

##############################

# Copy completed kernel to zip
	echo "	Copying kernel to zip directory"
	cp "$i" "$zi"
	find . -name "*.ko" -exec cp {} "$zm" \;
	echo "	Copying kernel completed!"
	
##############################

# Zip files for upload

	echo "	Making zip file.."
	cd "$zp"
	zip -r "$kn" *
	echo "	Moving zip to upload directory"
	mv "$kn" "$zu" 
	echo "	Completed build script!"
	echo "	Returning to start.."
	cd "$k"
