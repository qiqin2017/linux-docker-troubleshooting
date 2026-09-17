#!/usr/bin/env bash

set -u

PORT="${1:-}"

echo "=========================================="
echo " Linux Port Check"
echo "=========================================="
echo

if [ -z "$PORT" ]; then
    echo "Usage:"
    echo "  $0 <port>"
    echo
    echo "Examples:"
    echo "  $0 80"
    echo "  $0 443"
    echo "  $0 3000"
    echo "  $0 8080"
    exit 1
fi

if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
    echo "[ERROR] Port must be a number."
    exit 1
fi

if [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
    echo "[ERROR] Port must be between 1 and 65535."
    exit 1
fi

echo "[INFO] Checking TCP port: $PORT"
echo

if command -v ss >/dev/null 2>&1; then

    echo "------------------------------------------"
    echo " Listening Services"
    echo "------------------------------------------"

    ss -lntp 2>/dev/null | awk -v port=":$PORT" '$4 ~ port"$" || $4 ~ port" "'

    echo

    echo "------------------------------------------"
    echo " All Matching TCP Entries"
    echo "------------------------------------------"

    ss -antp 2>/dev/null | awk -v port=":$PORT" '$4 ~ port"$" || $5 ~ port"$"'

else

    echo "[WARNING] 'ss' command not found."

    if command -v netstat >/dev/null 2>&1; then
        echo "[INFO] Falling back to netstat."
        echo

        netstat -lntp 2>/dev/null | grep ":$PORT "
    else
        echo "[ERROR] Neither ss nor netstat is available."
        exit 1
    fi

fi

echo

if command -v docker >/dev/null 2>&1; then

    if docker info >/dev/null 2>&1; then

        echo "------------------------------------------"
        echo " Docker Port Mappings"
        echo "------------------------------------------"

        docker ps --format "{{.Names}}\t{{.Ports}}" | grep -E "[:.]${PORT}->|:${PORT}->" || \
            echo "No Docker container mapping found for port $PORT."

    fi

fi

echo

echo "=========================================="
echo " Check completed."
echo "=========================================="
