#!/bin/bash
echo "start fixing missing libraries issue in xcode 10"

if [ $(whoami) != 'root' ]; then
        echo "Must be root to run $0! Try to use sudo."
        exit 1;
fi

readonly dyLibFiles=('libstdc++.6.0.9.dylib' 'libstdc++.6.dylib' 'libstdc++.dylib')
readonly tbdFiles=('libstdc++.6.0.9.tbd' 'libstdc++.6.tbd' 'libstdc++.tbd')

# donwload libsetdc dylib and tbd
iPhoneSimDownloadUrl=https://github.com/violettomsk/xcodesdks/tree/master/iPhoneSimulator/lib/
iPhoneOsDownloadUrl=https://github.com/violettomsk/xcodesdks/tree/master/iPhoneOs/lib/

iPhoneSimulatorDir=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib/
iPhoneOsDir=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib
# mkdir test
echo 'Downloading libs to /Downloads/libs'
DownloadFolder=~/Downloads/
cd $DownloadFolder
mkdir libs
cd libs
mkdir iPhoneSimulator
mkdir iPhoneOs

cd iPhoneOs
for i in ${tbdFiles[@]}; do
	target=$iPhoneOsDownloadUrl$i
	wget -N $target
done
chmod 775 *
chgrp wheel *
cp * $iPhoneOsDir

cd ../iPhoneSimulator
for i in ${tbdFiles[@]}; do
	target=$iPhoneSimDownloadUrl$i
	wget -N $target
done
chmod 775 *
chgrp wheel *
cp * $iPhoneSimulatorDir

echo 'done'