#!/bin/bash

xprop > /tmp/xprop_output.txt
zenity --text-info --width=600 --height=800 --title="Xprop Output" --filename=/tmp/xprop_output.txt
