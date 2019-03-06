`xcode 10.1 IOS 12.0 fix missing libs`

Libstdc++.tbd could not be found
Apple removed the libstdc++ library from XCode10 and iOS12 and replaced it with the libc++ library.

This help to compile successfully

``chmod +x xcode10_fixer.sh``

``./xcode10_fixer.sh``
