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

for i in ${dyLibFiles[@]}; do
	target=$iPhoneSimDownloadUrl$i
	wget -N $target
done

for i in ${tbdFiles[@]}; do
	target=$iPhoneOsDownloadUrl$i
	wget -N $target
done

echo 'Changing permission'
chmod 775 *

echo 'Changing group to wheel'
chgrp wheel *

echo 'Copying files to sdk lib folders'
cp libstdc*.tbd $iPhoneOsDir
cp * $iPhoneSimulatorDir

echo 'done'