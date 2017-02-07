#!/bin/bash

VERSION=3.1.20170207

case ${1} in
	push)
		# this script pushes updates from NanoMod to
		# NanoROM for Galaxy S6. Users won't need it.

		NM=/storage/projects/NanoMod
		NR=/android/NanoROM/ROM/nano

		# microG
		cp -r ${NM}/microG ${NR}/
		rm -rf ${NR}/microG/priv-app/GmsCore/lib/arm

		# PlaySstore
		cp -r ${NM}/PlayStore ${NR}/system/

		# Apps
		for app in AdAway Amaze FaceSlim FDroid K9Mail Lightning \
			NewPipe QKSMS Twidere; do
			cp -r ${NM}/apps/${app} \
				${NR}/apps/
		done

		cp -r ${NM}/apps/OpenCamera ${NR}/alt/Camera/fdroid/
		cp -r ${NM}/apps/LeafPic ${NR}/alt/Gallery/LeafPic/app/
		cp -r ${NM}/apps/HackerKeyboard/HackerKeyboard.apk \
			${NR}/alt/Keyboard/HackersKeyboard/app/HackersKeyboard/HackersKeyboard.apk
		cp -r ${NM}/apps/KernelAdiutor \
			${NR}/system/kernel/adiutor/app/
		cp -r ${NM}/apps/SuperUser/ \
			${NR}/system/supersu/app/

		# UserApps
		cp -r ${NM}/userapps/{com.termux,com.xda.labs} \
			${NR}/apps/
		rm -rf ${NR}/apps/{com.termux,com.xda.labs}/lib/arm
		cp -r ${NM}/userapps/org.videolan.vlc-arm64/* \
			${NR}/apps/org.videolan.vlc/

		# Magisk
		cp -r ${NM}/Magisk.zip ${NR}/system/magisk/magisk.zip
		cp -r ${NM}/apps/MagiskManager \
			${NR}/system/magisk/app/
	;;
	
	zip)
		for part in apps bash META-INF microG nano PlayStore \
			substratum userapps zelda-ringtones Magisk.zip \
			nano-*.zip nano.sh README; do
			zip -r NanoMod-"${VERSION}".zip ${part} || exit 1
		done

		echo "Zipfile NanoMod-${VERSION} created"
	;;

	ver)
		sed -e "s/^VERSION=.*/VERSION=${2}/" -i ${PWD}/mod.sh
		sed -e "s/< NanoMod.*/< NanoMod ${2} >\");/" -i \
			${PWD}/META-INF/com/google/android/updater-script
	;;
esac