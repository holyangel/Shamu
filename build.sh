#!/bin/bash
############################################################
### Build script for HolyDragon kernel ###
############################################################

# This is the full build script used to build the official kernel zip.

# Minimum requirements to build:
# Already working build environment :P 
#
# In this script: 
# You will need to change the 'Source path to kernel tree' to match your current path to this source.
# You will need to change the 'Compile Path to out' to match your current path to this source.
# You will also need to edit the '-j32' under 'Start Compile' section and adjust that to match the amount of cores you want to use to build.
# 
# In Makefile: 
# You will need to edit the 'CROSS_COMPILE=' line to match your current path to this source.
# 
# Once those are done, you should be able to execute './build.sh' from terminal and receive a working zip.

############################################################
# Build Script Variables
############################################################ 

# Source defconfig used to build
	dc=sd_defconfig

# Path to kernel source
	k=/home/holyangel/android/Kernels/shamul

# Path to clean out
	co=$k/out

# Compile Path to out
	o="O=/home/holyangel/android/Kernels/shamul/out"

# Path to image.gz-dtb
	i=$k/out/arch/arm/boot/zImage-dtb

# Destination Path for compiled modules
	zm=$k/build/modules

# Destination path for compiled Image.gz-dtb
	zi=$k/build/zImage
	
# Source path for building kernel zip
	zp=$k/build/
	
# Destination Path for uploading kernel zip
	zu=$k/upload/

# Kernel zip Name
	kn=SDK_Shamu_LOS_V1.0.zip

##############################

############################################################
# Cleanup
############################################################

	echo "	Cleaning up out directory"
	rm -Rf out/
	echo "	Out directory removed!"

############################################################
# Make out folder
############################################################

	echo "	Making new out directory"
	mkdir -p "$co"
	echo "	Created new out directory"

############################################################
# Establish defconfig
############################################################

	echo "	Establishing build environment.."
	make "$o" "$dc"

############################################################
# Start Compile
############################################################

	echo "	First pass started.."
	make "$o" -j64
	echo "	First pass completed!"
	echo "	"
	echo "	Starting Second Pass.."
	make "$o" -j64
	echo "	Second pass completed!"

############################################################
# Copy image.gz-dtb to /build
############################################################

	echo "	Copying kernel to zip directory"
	cp "$i" "$zi"
	find . -name "*.ko" -exec cp {} "$zm" \;
	echo "	Copying kernel completed!"

############################################################
# Generating Changelog to /build
############################################################

	./changelog

############################################################
# Make zip and move to /upload
############################################################

	echo "	Making zip file.."
	cd "$zp"
	zip -r "$kn" *
	echo "	Moving zip to upload directory"
	mv "$kn" "$zu" 
	echo "	Completed build script!"
	echo "	Returning to start.."
	cd "$k"
