#!/bin/bash


keyboardid=$(ioreg -n IOHIDKeyboard -r | grep -e 'class IOHIDKeyboard' -e VendorID\" -e Product | sed 's/.*= //' | tail -2 | tr '\n' '-' | sed 's/$/0/')

key="com.apple.keyboard.modifiermapping.${keyboardid}"
value="<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>"

defaults -currentHost write -g "${key}" -array-add "${value}"

