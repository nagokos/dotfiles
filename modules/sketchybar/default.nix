{ pkgs, ... }:
let
  colors = {
    background = "0xff282a36";
    backgroundTransparent = "0xcc282a36";
    currentLine = "0xff44475a";
    foreground = "0xfff8f8f2";
    comment = "0xff6272a4";
    cyan = "0xff81a1c1";
    green = "0xff50fa7b";
    orange = "0xffffb86c";
    pink = "0xffff79c6";
    purple = "0xffbd93f9";
    red = "0xffff5555";
    yellow = "0xfff1fa8c";
    transparent = "0x00000000";
    black = "0xff21222c";
  };

  cpuPlugin = pkgs.writeShellScript "cpu.sh" ''
    CPU=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print $3}' | tr -d '%')
    sketchybar --set "$NAME" label="$CPU%"
  '';

  memoryPlugin = pkgs.writeShellScript "memory.sh" ''
    MEMORY=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100-$5}' | tr -d '%')
    sketchybar --set "$NAME" label="$MEMORY%"
  '';

  volumePlugin = pkgs.writeShellScript "volume.sh" ''
    VOLUME=$(osascript -e 'output volume of (get volume settings)')
    MUTED=$(osascript -e 'output muted of (get volume settings)')

    if [ "$MUTED" = "true" ]; then
      ICON="󰖁"
      sketchybar --set "$NAME" icon="$ICON" label="mute"
    else
      if [ "$VOLUME" -ge 70 ]; then
        ICON="󰕾"
      elif [ "$VOLUME" -ge 30 ]; then
        ICON="󰖀"
      else
        ICON="󰕿"
      fi
      sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
    fi
  '';

  wifiPlugin = pkgs.writeShellScript "wifi.sh" ''
    SSID=$(ipconfig getsummary en0 2>/dev/null | grep "^  SSID" | awk -F ' : ' '{print $2}')

    if [ -z "$SSID" ]; then
      sketchybar --set "$NAME" icon.color=${colors.red} label="Off"
    else
      sketchybar --set "$NAME" icon.color=${colors.cyan} label="$SSID"
    fi
  '';

  datePlugin = pkgs.writeShellScript "date.sh" ''
    sketchybar --set "$NAME" label="$(date '+%m/%d %a')"
  '';

  timePlugin = pkgs.writeShellScript "time.sh" ''
    sketchybar --set "$NAME" label="$(date '+%H:%M')"
  '';

  batteryPlugin = pkgs.writeShellScript "power.sh" ''
    PERCENTAGE=$(pmset -g batt | grep -Eo "[0-9]+%" | cut -d% -f1)
    CHARGING=$(pmset -g batt | grep 'AC Power')

    if [ -z "$PERCENTAGE" ]; then
      exit 0
    fi

    case ''${PERCENTAGE} in
      100)        ICON="󰁹" ;;
      9[0-9])     ICON="󰂂" ;;
      8[0-9])     ICON="󰂁" ;;
      7[0-9])     ICON="󰂀" ;;
      6[0-9])     ICON="󰁿" ;;
      5[0-9])     ICON="󰁾" ;;
      4[0-9])     ICON="󰁽" ;;
      3[0-9])     ICON="󰁼" ;;
      2[0-9])     ICON="󰁻" ;;
      1[0-9])     ICON="󰁺" ;;
      *)          ICON="󰂎" ;;
    esac

    if [ -n "$CHARGING" ]; then
      ICON="󰂄"
      COLOR="${colors.green}"
    elif [ "$PERCENTAGE" -le 20 ]; then
      COLOR="${colors.red}"
    else
      COLOR="${colors.green}"
    fi

    sketchybar --set power_icon icon="$ICON" icon.color="$COLOR" \
                --set "$NAME" label="$PERCENTAGE%"
  '';

  frontAppPlugin = pkgs.writeShellScript "front_app.sh" ''
    if [ "$SENDER" = "front_app_switched" ]; then
      sketchybar --set "$NAME" label="$INFO"
    fi
  '';

  sketchybarConfig = ''
        #!/bin/bash

        BACKGROUND="${colors.background}"
        BACKGROUND_TRANSPARENT="${colors.backgroundTransparent}"
        CURRENT_LINE="${colors.currentLine}"
        FOREGROUND="${colors.foreground}"
        COMMENT="${colors.comment}"
        CYAN="${colors.cyan}"
        GREEN="${colors.green}"
        ORANGE="${colors.orange}"
        PINK="${colors.pink}"
        PURPLE="${colors.purple}"
        RED="${colors.red}"
        YELLOW="${colors.yellow}"
        BLACK="${colors.black}"
        TRANSPARENT="${colors.transparent}"

        ############## BAR ##############

        bar=(
          height=40
          color="$BACKGROUND_TRANSPARENT"
          position=top
          topmost=on
          sticky=on
          padding_left=8
          padding_right=8
          notch_width=200
        )
        sketchybar --bar "''${bar[@]}"

        ############## GLOBAL DEFAULTS ##############

        default=(
          icon.font="Hack Nerd Font:Bold:14.0"
          icon.color="$FOREGROUND"
          icon.padding_left=6
          icon.padding_right=4
          label.font="Hack Nerd Font:Bold:12.0"
          label.color="$FOREGROUND"
          label.padding_left=5
          label.padding_right=6
          background.color="$TRANSPARENT"
          background.corner_radius=8
          background.height=28
          background.padding_left=2
          background.padding_right=2
        )
        sketchybar --default "''${default[@]}"

        # Front App
        sketchybar --add item front_app left \
                    --set front_app \
                          icon.drawing=off \
                          label.font="Hack Nerd Font:Bold:12.0" \
                          label.color="$FOREGROUND" \
                          label.padding_left=12 \
                          label.padding_right=6 \
                          script="${frontAppPlugin}" \
                    --subscribe front_app front_app_switched

        ############## RIGHT ITEMS ##############

        # Time
        sketchybar --add item time right \
                    --set time \
                          icon="󰥔" \
                          icon.color="$PURPLE" \
                          update_freq=1 \
                          script="${timePlugin}"

        # Date
        sketchybar --add item date right \
                    --set date \
                          icon="󰃭" \
                          icon.color="$PINK" \
                          update_freq=1 \
                          script="${datePlugin}"

        # Separator
        sketchybar --add item separator_datetime right \
                    --set separator_datetime \
                          icon=│ \
                          icon.color="$COMMENT" \
                          icon.padding_left=4 \
                          icon.padding_right=4 \
                          label.drawing=off \
                          background.drawing=off

        # Battery
    		sketchybar --add item battery right \
    								--set battery \
    											icon.drawing=off \
    											update_freq=1 \
    											script="${batteryPlugin}"

        sketchybar --add item power_icon right \
                    --set power_icon \
                          icon=󰁹 \
                          icon.font="Hack Nerd Font:Bold:16.0" \
                          icon.color="$GREEN" \
                          label.drawing=off


        # Separator
        sketchybar --add item separator_power right \
                    --set separator_power \
                          icon=│ \
                          icon.color="$COMMENT" \
                          icon.padding_left=4 \
                          icon.padding_right=4 \
                          label.drawing=off \
                          background.drawing=off

        # Volume
        sketchybar --add item volume right \
                    --set volume \
                          icon=󰕾 \
                          icon.color="$GREEN" \
                          update_freq=1 \
                          script="${volumePlugin}" \
                    --subscribe volume volume_change

        # Wi-Fi
        sketchybar --add item wifi right \
                    --set wifi \
                          icon=󰖩 \
                          icon.color="$CYAN" \
                          update_freq=1 \
                          script="${wifiPlugin}"

        # Separator
        sketchybar --add item separator_network right \
                    --set separator_network \
                          icon=│ \
                          icon.color="$COMMENT" \
                          icon.padding_left=4 \
                          icon.padding_right=4 \
                          label.drawing=off \
                          background.drawing=off

        # Memory
        sketchybar --add item memory right \
                    --set memory \
                          icon=󰍛 \
                          icon.color="$YELLOW" \
                          update_freq=1 \
                          script="${memoryPlugin}"

        # CPU
        sketchybar --add item cpu right \
                    --set cpu \
                          icon=󰻠 \
                          icon.color="$ORANGE" \
                          update_freq=1 \
                          script="${cpuPlugin}"

        ############## BRACKETS ##############

        sketchybar --add bracket spaces_bracket '/space\..*/' \
                    --set spaces_bracket \
                          background.color="$CURRENT_LINE" \
                          background.corner_radius=10 \
                          background.height=32

        sketchybar --add bracket system_bracket cpu memory \
                    --set system_bracket \
                          background.color="$CURRENT_LINE" \
                          background.corner_radius=10 \
                          background.height=32

        sketchybar --add bracket network_bracket wifi volume \
                    --set network_bracket \
                          background.color="$CURRENT_LINE" \
                          background.corner_radius=10 \
                          background.height=32

        sketchybar --add bracket power_bracket power_icon battery \
                    --set power_bracket \
                          background.color="$CURRENT_LINE" \
                          background.corner_radius=10 \
                          background.height=32

        sketchybar --add bracket datetime_bracket date time \
                    --set datetime_bracket \
                          background.color="$CURRENT_LINE" \
                          background.corner_radius=10 \
                          background.height=32

        ############## FINALIZE ##############

        AEROSPACE="/run/current-system/sw/bin/aerospace"
        FOCUSED=$("$AEROSPACE" list-workspaces --focused 2>/dev/null || echo "1")
        sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE="$FOCUSED"

        sketchybar --update
  '';
in
{
  programs.sketchybar = {
    enable = pkgs.stdenv.isDarwin;
    package = pkgs.sketchybar;
    config = {
      text = sketchybarConfig;
    };
  };
}
