#!/usr/bin/env bash

PATH_TO_CHECK="/"

# Extract df values in KB
read -r filesystem size used avail usep mount <<< "$(df -k "$PATH_TO_CHECK" | awk 'NR==2')"

# Convert KB → decimal GB
used_gb=$(awk "BEGIN {printf \"%.2f\", $used/1024/1024}")
size_gb=$(awk "BEGIN {printf \"%.2f\", $size/1024/1024}")

# Strip percent sign
percent="${usep%\%}"

# Output valid JSON manually (NO jq needed)
printf '{"text":"%s%% 🖴","tooltip":"%s GB used out of %s GB","percentage":%s}\n' \
    "$percent" "$used_gb" "$size_gb" "$percent"
