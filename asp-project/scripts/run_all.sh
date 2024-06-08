#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <number_of_teams> <configuration>"
    echo "Configurations: auto, tweety, crafty, frumpy, jumpy, handy"
    exit 1
fi

# Get the number of teams and configuration from the arguments
num_teams=$1
configuration=$2
file_name="campionato-${num_teams}squadre.cl"

# Validate configuration
valid_configurations=("auto" "tweety" "crafty" "frumpy" "jumpy" "handy")
if [[ ! " ${valid_configurations[@]} " =~ " ${configuration} " ]]; then
    echo "Invalid configuration. Choose from: ${valid_configurations[*]}"
    exit 1
fi

BOT_TOKEN="your_bot_token_here"
CHAT_ID="your_chat_id_here"

# Commands to execute
commands=(
    "echo 'Begin-of-execution - ${num_teams} teams execution with configuration ${configuration}:\n'"
    "clingo-dl --opt-mode=optN --parallel-mode=12 --propagate=full --propagate-root=20 --minimize-variable=cost,200 --time-limit=3600 --configuration=${configuration} ${file_name}"
    "echo 'End-of-execution\n\n'"
)

results=""

for cmd in "${commands[@]}"
do
    echo "Executing: $cmd"
    start=$(date +%s.%N)
    output=$(eval $cmd 2>&1) # Capture both stdout and stderr
    end=$(date +%s.%N)
    
    # Check if the command contains 'clingo'
    if [[ $cmd == *"clingo"* ]]; then
        duration=$(echo "$end - $start" | bc)
        results+="Command: $cmd\nExecution time: $duration seconds\nOutput:\n$output\n\n"
    else
        results+="$cmd\n\n"
    fi
done

# Function to send a message to Telegram
send_telegram_message() {
    local message=$1
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="$message"
}

# Split the results into smaller messages if necessary
max_length=4096
current_message=""

while IFS= read -r line; do
    if (( ${#current_message} + ${#line} + 1 > max_length )); then
        send_telegram_message "$current_message"
        current_message=""
    fi
    current_message+="$line"$'\n'
done <<< "$results"

# Send the remaining part
if [[ -n "$current_message" ]]; then
    send_telegram_message "$current_message"
fi
