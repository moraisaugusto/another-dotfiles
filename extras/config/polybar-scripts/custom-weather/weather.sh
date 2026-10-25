#!/bin/bash
trap "exit 0" PIPE

# SETTINGS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

APIKEY=$(grep '^OPENWEATHER_KEY=' ~/.secrets 2>/dev/null | cut -d '"' -f 2)

CITY_NAME='Berlin'
COUNTRY_CODE='DE'
LANG="en"
UNITS="metric"

# Color Settings
COLOR_CLOUD="#606060"
COLOR_THUNDER="#d3b987"
COLOR_LIGHT_RAIN="#73cef4"
COLOR_HEAVY_RAIN="#b3deef"
COLOR_SNOW="#FFFFFF"
COLOR_FOG="#606060"
COLOR_TORNADO="#d3b987"
COLOR_SUN="#ffc24b"
COLOR_MOON="#FFFFFF"
COLOR_ERR="#f43753"
COLOR_WIND="#73cef4"
COLOR_COLD="#b3deef"
COLOR_HOT="#f43753"
COLOR_NORMAL_TEMP="#FFFFFF"
COLOR_TEXT=""

DISPLAY_WIND="yes"
BEAUFORTICON="yes"
KNOTS="yes"
DECIMALS=0
MIN_WIND=11
DISPLAY_FORCE="yes"
DISPLAY_WIND_UNIT="yes"
HOT_TEMP=25
COLD_TEMP=0
DISPLAY_LABEL="yes"

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

if [ -n "$COLOR_TEXT" ]; then
    COLOR_TEXT_BEGIN="<span foreground='$COLOR_TEXT'>"
    COLOR_TEXT_END="</span>"
else
    COLOR_TEXT_BEGIN=""
    COLOR_TEXT_END=""
fi

if [ -z "$CITY_NAME" ]; then
    IP=$(curl -s ifconfig.me)
    IPCURL=$(curl -s "https://ipinfo.io/$IP")
    CITY_NAME=$(echo "$IPCURL" | jq -r ".city")
    COUNTRY_CODE=$(echo "$IPCURL" | jq -r ".country")
fi

RESPONSE=""
ERROR=0
ERR_MSG=""

if [ "$UNITS" = "kelvin" ]; then
    UNIT_URL=""
else
    UNIT_URL="&units=$UNITS"
fi
URL="https://api.openweathermap.org/data/2.5/weather?appid=$APIKEY$UNIT_URL&lang=$LANG&q=$(echo "$CITY_NAME" | sed 's/ /%20/g'),${COUNTRY_CODE}"

function getData {
    ERROR=0
    RESPONSE=$(curl -s "$URL")
    CODE="$?"
    if [ "$1" = "-d" ]; then
        echo "$RESPONSE"
        echo ""
    fi
    RESPONSECODE=0
    if [ "$CODE" -eq 0 ]; then
        RESPONSECODE=$(echo "$RESPONSE" | jq -r '.cod // 0')
    fi
    if [ "$CODE" -ne 0 ] || [ "$RESPONSECODE" -ne 200 ]; then
        if [ "$CODE" -ne 0 ]; then
            ERR_MSG="curl Error $CODE"
        else
            ERR_MSG="Conn. Err. $RESPONSECODE"
        fi
        ERROR=1
    fi
}

function setIcons {
    WID=${WID:-900}
    DATE=${DATE:-0}
    SUNRISE=${SUNRISE:-0}
    SUNSET=${SUNSET:-0}

    if [[ "$WID" -le 232 ]]; then
        ICON_COLOR=$COLOR_THUNDER
        if [[ "$DATE" -ge "$SUNRISE" && "$DATE" -le "$SUNSET" ]]; then
            ICON=""
        else
            ICON=""
        fi
    elif [[ "$WID" -le 311 ]]; then
        ICON_COLOR=$COLOR_LIGHT_RAIN
        if [[ "$DATE" -ge "$SUNRISE" && "$DATE" -le "$SUNSET" ]]; then
            ICON=""
        else
            ICON=""
        fi
    elif [[ "$WID" -le 321 ]]; then
        ICON_COLOR=$COLOR_HEAVY_RAIN
        if [[ "$DATE" -ge "$SUNRISE" && "$DATE" -le "$SUNSET" ]]; then
            ICON=""
        else
            ICON=""
        fi
    elif [[ "$WID" -le 531 ]]; then
        ICON_COLOR=$COLOR_HEAVY_RAIN
        if [[ "$DATE" -ge "$SUNRISE" && "$DATE" -le "$SUNSET" ]]; then
            ICON=""
        else
            ICON=""
        fi
    elif [[ "$WID" -le 622 ]]; then
        ICON_COLOR=$COLOR_SNOW
        ICON=""
    elif [[ "$WID" -le 771 ]]; then
        ICON_COLOR=$COLOR_FOG
        ICON=""
    elif [[ "$WID" -eq 781 ]]; then
        ICON_COLOR=$COLOR_TORNADO
        ICON=""
    elif [[ "$WID" -eq 800 ]]; then
        if [[ "$DATE" -ge "$SUNRISE" && "$DATE" -le "$SUNSET" ]]; then
            ICON_COLOR=$COLOR_SUN
            ICON=""
        else
            ICON_COLOR=$COLOR_MOON
            ICON=""
        fi
    elif [[ "$WID" -eq 801 ]]; then
        if [[ "$DATE" -ge "$SUNRISE" && "$DATE" -le "$SUNSET" ]]; then
            ICON_COLOR=$COLOR_SUN
            ICON=""
        else
            ICON_COLOR=$COLOR_MOON
            ICON=""
        fi
    elif [[ "$WID" -le 804 ]]; then
        ICON_COLOR=$COLOR_CLOUD
        ICON=""
    else
        ICON_COLOR=$COLOR_ERR
        ICON=""
    fi

    WIND=""
    WINDFORCE=$(echo "$RESPONSE" | jq -r '.wind.speed // 0')
    WINDICON=""

    if [ "$BEAUFORTICON" = "yes" ]; then
        WINDFORCE2=$(echo "scale=$DECIMALS;$WINDFORCE * 3.6 / 1" | bc 2>/dev/null || echo 0)
        WINDFORCE2=${WINDFORCE2%.*}
        WINDFORCE2=${WINDFORCE2:-0}

        if [[ "$WINDFORCE2" -le 1 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 5 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 11 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 19 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 28 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 38 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 49 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 61 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 74 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 88 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 102 ]]; then
            WINDICON=""
        elif [[ "$WINDFORCE2" -le 117 ]]; then
            WINDICON=""
        else
            WINDICON=""
        fi
    fi

    if [ "$KNOTS" = "yes" ]; then
        case "$UNITS" in
            "imperial")
                WINDFORCE=$(echo "scale=$DECIMALS;$WINDFORCE * 0.8689762419 / 1" | bc 2>/dev/null || echo 0)
                ;;
            *)
                WINDFORCE=$(echo "scale=$DECIMALS;$WINDFORCE * 1.943844 / 1" | bc 2>/dev/null || echo 0)
                ;;
        esac
    else
        if [ "$UNITS" != "imperial" ]; then
            WINDFORCE=$(echo "scale=$DECIMALS;$WINDFORCE * 3.6 / 1" | bc 2>/dev/null || echo 0)
        else
            WINDFORCE=$(echo "scale=$DECIMALS;$WINDFORCE / 1" | bc 2>/dev/null || echo 0)
        fi
    fi

    WINDFORCE_NUM=${WINDFORCE%.*}
    WINDFORCE_NUM=${WINDFORCE_NUM:-0}

    if [ "$DISPLAY_WIND" = "yes" ] && [ "$WINDFORCE_NUM" -ge "$MIN_WIND" ]; then
        WIND="<span foreground='$COLOR_WIND'>$WINDICON</span>"
        if [ "$DISPLAY_FORCE" = "yes" ]; then
            WIND="$WIND $COLOR_TEXT_BEGIN$WINDFORCE$COLOR_TEXT_END"
            if [ "$DISPLAY_WIND_UNIT" = "yes" ]; then
                if [ "$KNOTS" = "yes" ]; then
                    WIND="$WIND ${COLOR_TEXT_BEGIN}kn$COLOR_TEXT_END"
                elif [ "$UNITS" = "imperial" ]; then
                    WIND="$WIND ${COLOR_TEXT_BEGIN}mph$COLOR_TEXT_END"
                else
                    WIND="$WIND ${COLOR_TEXT_BEGIN}km/h$COLOR_TEXT_END"
                fi
            fi
        fi
    fi

    if [ "$UNITS" = "metric" ]; then
        TEMP_ICON="󰔄"
    elif [ "$UNITS" = "imperial" ]; then
        TEMP_ICON="󰔅"
    else
        TEMP_ICON="󰔆"
    fi

    TEMP_CLEAN=${TEMP%.*}
    TEMP_CLEAN=${TEMP_CLEAN:-0}

    if [[ "$TEMP_CLEAN" -le "$COLD_TEMP" ]]; then
        TEMP_STR="<span foreground='$COLOR_COLD'></span> $COLOR_TEXT_BEGIN$TEMP_CLEAN$TEMP_ICON$COLOR_TEXT_END"
    elif [[ "$TEMP_CLEAN" -ge "$HOT_TEMP" ]]; then
        TEMP_STR="<span foreground='$COLOR_HOT'></span> $COLOR_TEXT_BEGIN$TEMP_CLEAN$TEMP_ICON$COLOR_TEXT_END"
    else
        TEMP_STR="<span foreground='$COLOR_NORMAL_TEMP'></span> $COLOR_TEXT_BEGIN$TEMP_CLEAN$TEMP_ICON$COLOR_TEXT_END"
    fi
}

function outputCompact {
    OUTPUT="$WIND <span foreground='$ICON_COLOR'>$ICON</span> $ERR_MSG $TEMP_STR"
    echo "$OUTPUT" || true
}

getData "$1"

if [ "$ERROR" -eq 0 ]; then
    MAIN=$(echo "$RESPONSE" | jq -r '.weather[0].main // ""')
    WID=$(echo "$RESPONSE" | jq -r '.weather[0].id // 900')
    DESC=$(echo "$RESPONSE" | jq -r '.weather[0].description // ""')
    SUNRISE=$(echo "$RESPONSE" | jq -r '.sys.sunrise // 0')
    SUNSET=$(echo "$RESPONSE" | jq -r '.sys.sunset // 0')
    DATE=$(date +%s)
    TEMP=$(echo "$RESPONSE" | jq -r '.main.temp // 0')
    
    setIcons
    outputCompact
else
    echo "<span foreground='$COLOR_ERR'></span> $ERR_MSG" || true
fi
