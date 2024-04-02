#!/bin/bash

xwininfo > /tmp/output.txt
yad --text-info --width=600 --height=800 --title="Xwininfo Output" --filename=/tmp/output.txt
