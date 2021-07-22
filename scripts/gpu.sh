#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

scripts="$HOME/.tmux/plugins/tmux-cpu/scripts"
tmux set-option -g @gpu_percentage_format "%5.1f%%"
tmux set-option -g @gram_percentage_format "%5.1f%%"

gpu_temp=$(echo "$($scripts/gpu_temp.sh)" | sed -r 's/[C]+//g')

if [[ $gpu_temp -ge 0 ]] && [[ $gpu_temp -le 24 ]]; then
  gpu_thermometer=""
elif [[ $gpu_temp -ge 25 ]] && [[ $gpu_temp -le 49 ]]; then
  gpu_thermometer=""
elif [[ $gpu_temp -ge 50 ]] && [[ $gpu_temp -le 74 ]]; then
  gpu_thermometer=""
elif [[ $gpu_temp -ge 75 ]] && [[ $gpu_temp -le 99 ]]; then
  gpu_thermometer=""
else
  gpu_thermometer=""
fi

nerdfonts=$(get_option "@nova-nerdfonts" false)

if [ "$nerdfonts" = true ]; then
  echo "$($scripts/gpu_percentage.sh) ﴿ $($scripts/gram_percentage.sh)     $gpu_temp糖$gpu_thermometer"
else
  echo "$($scripts/gpu_percentage.sh) GPU $($scripts/gram_percentage.sh) GRAM    $gpu_temp C"
fi

