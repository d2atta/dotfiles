#!/bin/sh

# ^c$var^ = fg color
# ^b$var^ = bg color

# INIT
echo "$$" > ~/.cache/pidofbar
sec=0

# load colors!
update_col(){
  black=$(xrdb -get color0)
  green=$(xrdb -get color5)
  white=$(xrdb -get color7)
  grey=$(xrdb -get color8)
  blue=$(xrdb -get color1)
  red=$(xrdb -get color2)
  darkblue=$(xrdb -get color3)
}
update_col

update_music() {
	metadata=$(playerctl metadata --format 'title=[{{ title }}]  status=[{{ status }}]')
	title=$(echo "${metadata}" | awk -F'[][]' -v RS="" '/title/ {print $2}' | awk 'length > 15{$0=substr($0,0,16)"..."}1')
	status=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/status/ {print $2}')

	if [ "$status" = "Paused" ]; then
		icon="󰏥"
	else
		icon="󰐊"
	fi

	music="^c$darkblue^$icon^c$grey^ ${title:="N/A"}"
}

update_cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)
  cpu="^c$black^ ^b$green^ 󰍛 ""^c$white^ ^b$grey^ $cpu_val"
}

pkg_updates() {
  updates=$(pacman -Qu | wc -l)   # arch , needs pacman contrib
  # updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)

  pkgs="^c$green^󰕒 ^c$grey^$updates"
}

update_bat() {
  get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
  case "$(cat /sys/class/power_supply/BAT0/status)" in
    "Full") status="󰁹" ;;
    "Discharging") status="󰁹" ;;
    "Charging") status="󰚥 " ;;
    "Not charging") status="󰁹" ;;
    "Unknown") status="󰁺" ;;
  esac
  battery="^c$blue^$status^c$grey^$get_capacity%"
}

update_brightness() {
  # you might need to change the path depending on your device
  # act_brightness="$(cat /sys/class/backlight/*/actual_brightness)"  
  brightness="^c$red^ 󰃟 ""^c$red^%.0f\n""$(cat /sys/class/backlight/*/brightness)"
}

update_vol(){
  vol="$(pamixer --get-volume)"

  if [ "$(pamixer --get-volume-human)" = "muted" ] ; then
    icon="󰸈 "
  elif [ "$vol" -gt "70" ]; then
    icon="󰕾"
  elif [ "$vol" -lt "30" ]; then
    icon="󰕿"
  else
    icon="󰖀"
  fi
  volume="^c$red^$icon""^c$grey^$vol%"
}

update_ram() {
  ram="^c$black^^b$green^ 󰍛 ""^c$white^^b$grey^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)B ^d^"
}

update_mem() {
  free_space=$(df -h | awk '/sda2/ { print $5 }')
  mem="^c$blue^^b$black^ 󰋊 ""^c$blue^ $free_space"
}

traf_update() {

    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

update_speed(){
  # rx=$(traf_update /sys/class/net/[ew]*/statistics/rx_bytes)
  tx=$(traf_update /sys/class/net/[ew]*/statistics/tx_bytes)
  traf="^c$white^^b$grey^ $(numfmt --to=iec "$tx")B ^d^"
}

update_wlan() {
	case "$(cat /sys/class/net/e*/operstate 2>/dev/null)" in
	up) icon="󰖩";;
	down) wifi="󰖪";;
	esac
	wifi="^c$black^^b$blue^ $icon"
}

update_clock() {
  clock=$(date '+%I')

  case "$clock" in
      "00") icon="󱑊" ;;
      "01") icon="󱐿" ;;
      "02") icon="󱑀" ;;
      "03") icon="󱑁" ;;
      "04") icon="󱑂" ;;
      "05") icon="󱑃" ;;
      "06") icon="󱑄" ;;
      "07") icon="󱑅" ;;
      "08") icon="󱑆" ;;
      "09") icon="󱑇" ;;
      "10") icon="󱑈" ;;
      "11") icon="󱑉" ;;
      "12") icon="󱑊" ;;
  esac
  clock="^c$black^^b$darkblue^ $icon ""^c$black^^b$blue^ $(date '+%I:%M %p') ^d^"
}

update_date() {
	date="^c$black^^b$red^ 󰃶 ""^c$white^^b$grey^ $(date '+%+2e %b (%a)') ^d^"
}

# modules that don't update on their own need to be run at the start for getting their initial value
pkg_updates
update_date
update_wlan
update_vol

display () { 
  xsetroot -name "$music $pkgs $battery $volume $ram $wifi $traf $clock"
  # echo "$music $pkgs $battery $volume $ram $wifi $traf $clock $date"
}

# SIGNALLING
# trap	"<function>;display"		"RTMIN+n"
trap	"update_vol;display"		"RTMIN"
trap	"pkg_updates;display" 		"RTMIN+1"
trap	"update_music;display" 		"RTMIN+2"
trap	"update_music;update_col;\
	pkg_updates;update_bat;\
	 update_vol;update_mem;\
	 update_wlan;\
	 update_speed;update_ram;\
	 update_date;update_clock"      "USR1"
# to update it from external commands
## kill -m "$(cat ~/.cache/pidofbar)"
# where m = 34 + n

while true
do
	sleep 1 & wait && { 
		# to update item ever n seconds with a offset of m
		## [ $((sec % n)) -eq m ] && udpate_item
		[ $((sec % 5)) -eq 0 ] && update_music
		[ $((sec % 30  )) -eq 0 ] && update_bat         # update battery every 30 seconds
		# [ $((sec % 300 )) -eq 0 ] && update_mem         # update memory every 5 minutes
		[ $((sec % 300 )) -eq 0 ] && update_wlan        # update connectivity every 5 minutes
		[ $((sec % 5   )) -eq 0 ] && update_speed	# update speed every 5 seconds
		[ $((sec % 5   )) -eq 0 ] && update_ram 	# update ram every 5 seconds
		[ $((sec % 10  )) -eq 0 ] && update_clock 	# update time every 10 seconds

		# how often the display updates ( 5 seconds )
		[ $((sec % 5 )) -eq 0 ] && display
		sec=$((sec + 1))
	}
done 
