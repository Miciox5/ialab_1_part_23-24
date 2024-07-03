#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_teams>"
    exit 1
fi

# Get the number of teams from the first argument
num_teams=$1
file_name="campionato-${num_teams}squadre_v2.cl"

# Commands to execute
commands=(
    "echo 'Begin-of-execution - ${num_teams} teams execution:'"
    "clingo-dl --parallel-mode=8 --opt-mode=optN --time-limit=7200 --propagate=full --models=1 --configuration=auto ${file_name}"
    "echo 'End-of-execution'"
)

results=""

for cmd in "${commands[@]}"
do
    # echo "Executing: $cmd"
    start=$(date +%s.%N)
    output=$(eval $cmd 2>&1) # Capture both stdout and stderr
    end=$(date +%s.%N)
    # Check if the command contains 'clingo'
    if [[ $cmd == *"clingo"* ]]; then
        duration=$(echo "$end - $start" | bc)
        results+="Command: $cmd\nExecution time: $duration seconds\nOutput:\n$output"
    # else
    #     results+="$cmd"
    fi
done

# Save the results to a file
echo -e "$results" > risultato_${file_name}.txt

# Function to send a message to Telegram. Define your own BOT_TOKEN and your CHAT_IDS
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
