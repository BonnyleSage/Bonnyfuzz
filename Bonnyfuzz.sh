#!/bin/bash

# Bonnyfuzz: Simple and user-friendly directory brute-forcing tool with Intelligent Request Timing

# Color definitions for better UI
GREEN="\033[0;32m"
RED="\033[0;31m"
CYAN="\033[0;36m"
RESET="\033[0m"

# Banner function
banner() {
    echo -e "${CYAN}"
    echo "===================================="
    echo "       Bonnyfuzz - Directory Fuzzer"
    echo "       Author: Bonny leSage"
    echo "       Feature: Intelligent Request Timing"
    echo "       Contact: telegram-@france205|mail:thecybercoach971@gmail.com"
    echo "===================================="
    echo -e "${RESET}"
}

# Help menu
usage() {
    echo -e "${GREEN}Usage:${RESET} $0 -u <url> -w <wordlist> [-t <threads>] [-d <delay>] [-m <max-response>]"
    echo -e "${CYAN}"
    echo "Options:"
    echo "  -u  Target URL (e.g., https://example.com)"
    echo "  -w  Path to wordlist file (e.g., /path/to/wordlist.txt)"
    echo "  -t  Number of threads (default: 1)"
    echo "  -d  Minimum delay between requests in seconds (default: 0.5)"
    echo "  -m  Max allowed response time in seconds before increasing delay (default: 2.0)"
    echo "  -h  Show this help message"
    echo -e "${RESET}"
}

# Directory brute-forcing function with Intelligent Request Timing
fuzz_directories() {
    local url=$1
    local wordlist=$2
    local threads=$3
    local min_delay=$4
    local max_response=$5

    if [ ! -f "$wordlist" ]; then
        echo -e "${RED}Error:${RESET} Wordlist file not found: $wordlist"
        exit 1
    fi

    echo -e "${CYAN}Starting fuzzing on${RESET} $url with $threads threads..."
    echo -e "${GREEN}Results:${RESET}"

    delay=$min_delay
    if command -v parallel &> /dev/null && [ "$threads" -gt 1 ]; then
        # Parallel execution for multi-threading
        cat "$wordlist" | parallel -j "$threads" "curl -o /dev/null -s -w \"%{time_total} %{http_code} %{url_effective}\" $url/{} | grep -E \"200|301|302\""
    else
        # Sequential execution with intelligent timing
        while read -r dir; do
            start_time=$(date +%s.%N)
            response=$(curl -o /dev/null -s -w "%{time_total} %{http_code} %{url_effective}" -X GET "$url/$dir")
            end_time=$(date +%s.%N)
            
            # Extract response time and HTTP status
            response_time=$(echo $response | awk '{print $1}')
            http_code=$(echo $response | awk '{print $2}')
            result_url=$(echo $response | awk '{print $3}')

            # Check for valid HTTP codes
            if [[ $http_code == 200 || $http_code == 301 || $http_code == 302 ]]; then
                echo -e "${GREEN}[$http_code] $result_url (Response Time: ${response_time}s)${RESET}"
            fi

            # Adjust delay dynamically
            if (( $(echo "$response_time > $max_response" | bc -l) )); then
                delay=$(echo "$delay + 0.5" | bc)
                echo -e "${RED}Server is slowing down; increasing delay to ${delay}s${RESET}"
            else
                delay=$min_delay
            fi

            # Wait before the next request
            sleep "$delay"
        done < "$wordlist"
    fi

    echo -e "${CYAN}Fuzzing complete!${RESET}"
}

# Main script logic
main() {
    banner

    # Parse command-line arguments
    local url=""
    local wordlist=""
    local threads=1
    local min_delay=0.5
    local max_response=2.0

    while getopts "u:w:t:d:m:h" opt; do
        case $opt in
            u) url=$OPTARG ;;
            w) wordlist=$OPTARG ;;
            t) threads=$OPTARG ;;
            d) min_delay=$OPTARG ;;
            m) max_response=$OPTARG ;;
            h) usage; exit 0 ;;
            *) usage; exit 1 ;;
        esac
    done

    # Validate inputs
    if [[ -z "$url" || -z "$wordlist" ]]; then
        usage
        exit 1
    fi

    # Start fuzzing
    fuzz_directories "$url" "$wordlist" "$threads" "$min_delay" "$max_response"
}

# Execute the main function
main "$@"
