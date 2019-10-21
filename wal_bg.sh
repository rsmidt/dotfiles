#!/bin/bash

source $HOME/.cache/wal/colors.sh

if [ ! "$wallpaper" = "None" ];then
    swaymsg 'output * bg '"$wallpaper"' fill '"$background"
else
    swaymsg 'output * bg '"$background"' solid_color'
fi

