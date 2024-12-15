#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

# Not my own work. This was added through Github PR. Credit to original author

#----- Optimized bars animation without much CPU usage increase --------
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"

# Calculate the length of the bar outside the loop
bar_length=${#bar}

# Create dictionary to replace char with bar
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

# Create cava config
config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
bars = 10

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[color]

gradient = 1

gradient_color_1 = '#94e2d5'
gradient_color_2 = '#89dceb'
gradient_color_3 = '#74c7ec'
gradient_color_4 = '#89b4fa'
gradient_color_5 = '#cba6f7'
gradient_color_6 = '#f5c2e7'
gradient_color_7 = '#eba0ac'
gradient_color_8 = '#f38ba8'

EOF

# Kill cava if it's already running
pkill -f "cava -p $config_file"

# Read stdout from cava and perform substitution in a single sed command
cava -p "$config_file" | sed -u "$dict"
