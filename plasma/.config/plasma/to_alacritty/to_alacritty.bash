#!/bin/bash

if pgrep -x "alacritty" > /dev/null
then
    echo "Running - focusing"

    SCRIPT_PATH=${HOME}/scripts/to_alacritty/focus_alacritty2.js
    SCRIPT_NAME="scriptFocusAlacritty"

    # install the script
    RET=$(dbus-send --session --dest=org.kde.KWin --print-reply=literal /Scripting org.kde.kwin.Scripting.loadScript "string:$SCRIPT_PATH" "string:$SCRIPT_NAME")
    echo INSTALL: "$RET"
    ID=$(echo "$RET" | awk '{print $2}')

    # run it - some KDEs version use Script.run others Scripting.run
    echo RUN
    dbus-send --session --dest=org.kde.KWin --print-reply=literal "/Scripting/Script$ID" org.kde.kwin.Script.run  2>&1

    # stop it - some KDEs version use Script.run others Scripting.run
    echo STOP
    dbus-send --session --dest=org.kde.KWin --print-reply=literal "/Scripting/Script$ID" org.kde.kwin.Script.stop  2>&1

    # uninstall it
    echo UNINSTALL
    dbus-send --session --dest=org.kde.KWin --print-reply=literal /Scripting org.kde.kwin.Scripting.unloadScript "string:$SCRIPT_NAME" 2>&1

else
    echo "Not running. Open."
    alacritty
fi


