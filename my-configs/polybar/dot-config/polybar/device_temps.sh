#!/usr/bin/env bash

# --- Configuration ---
# Thresholds: "low:high" (triggers color ramp at these boundaries)
declare -A THRESHOLDS=( [cpu]="55:85" [gpu]="65:80" [aio]="40:60" )
declare -A ICONS=( [cpu]="" [gpu]="󰢮" [aio]="󱪀" )
COLORS=("#777" "#fabd2f" "#fb4934") # 0=low, 1=mid, 2=high

# --- Safe Data Fetchers ---
get_cpu() {
    local hwmon_dir=""
    
    # Find the hwmon directory matching common CPU sensor names
    for name_file in /sys/class/hwmon/hwmon*/name; do
        if grep -qiE 'coretemp|k10temp|pkg-temp|intel_pstate' "$name_file" 2>/dev/null; then
            hwmon_dir=$(dirname "$name_file")
            break
        fi
    done

    if [[ -f "$hwmon_dir/temp1_input" ]]; then
        awk '{printf "%.0f", $1/1000}' "$hwmon_dir/temp1_input" 2>/dev/null || echo "-1"
    else
        echo "-1"
    fi
}
get_gpu() { timeout 2 nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1 || echo "-1"; }
get_aio() { timeout 2 liquidctl status 2>/dev/null | grep -m1 "Liquid temperature" | awk '{print $4}' || echo "-1"; }

# --- Unified Renderer ---
render_sensor() {
    local name="$1"
    local raw="$2"

    # Fallback & validation
    raw="${raw:-0}"
    if [[ "$raw" == "-1" ]]; then
        echo "%{F#777}N/A%{F-}"
        return
    fi

    local temp
    temp=$(printf "%.0f" "$raw" 2>/dev/null) || temp="0"
    
    IFS=':' read -r t_low t_high <<< "${THRESHOLDS[$name]}"
    local icon="${ICONS[$name]}"
    local idx=0

    if (( temp >= t_high )); then
        idx=2
    elif (( temp >= t_low )); then
        idx=1
    fi

    echo "%{F${COLORS[$idx]}}${icon}%{F-} ${temp}°"
}

# --- Main ---
main() {
    local render_list="cpu,gpu,aio" # Default
 
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --render)
                [[ -n "$2" ]] || { echo "Error: --render requires an argument" >&2; exit 1; }
                render_list="$2"
                shift 2
                ;;
            --help|-h)
                echo "Usage: $0 [--render cpu,gpu,aio]"
                exit 0
                ;;
            *)
                echo "Unknown option: $1" >&2
                exit 1
                ;;
        esac
    done
 
    IFS=',' read -ra sensors <<< "$render_list"
    local outputs=()
 
    for sensor in "${sensors[@]}"; do
        # Trim whitespace
        sensor="${sensor// /}"
        [[ -z "$sensor" ]] && continue
 
        local raw=""
        case "$sensor" in
            cpu) raw="$(get_cpu)" ;;
            gpu) raw="$(get_gpu)" ;;
            aio) raw="$(get_aio)" ;;
            *)
                echo "Warning: Unknown sensor '$sensor' (valid: cpu, gpu, aio)" >&2
                continue
                ;;
        esac
 
        outputs+=("$(render_sensor "$sensor" "$raw")")
    done
 
    # Join with " · " using a loop (IFS only uses first byte, breaks on multi-byte chars)
    local result=""
    for i in "${!outputs[@]}"; do
        if [[ $i -eq 0 ]]; then
            result="${outputs[$i]}"
        else
            result="$result · ${outputs[$i]}"
        fi
    done
 
    echo "$result"
}

# Execute only when run directly (not sourced)
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
