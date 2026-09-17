#!/usr/bin/env bash

set -u

echo "=========================================="
echo " Linux Disk Check"
echo "=========================================="
echo

echo "[1] Filesystem Usage"
echo "------------------------------------------"

df -h

echo

echo "[2] Inode Usage"
echo "------------------------------------------"

df -ih

echo

echo "[3] Root Filesystem"
echo "------------------------------------------"

ROOT_USAGE=$(df -P / | awk 'NR==2 {print $5}' | tr -d '%')

if [ -n "$ROOT_USAGE" ] && [ "$ROOT_USAGE" -ge 90 ]; then
    echo "[WARNING] Root filesystem usage is ${ROOT_USAGE}%."
    echo "         Disk usage is critically high."
elif [ -n "$ROOT_USAGE" ] && [ "$ROOT_USAGE" -ge 80 ]; then
    echo "[WARNING] Root filesystem usage is ${ROOT_USAGE}%."
    echo "         Consider cleaning unnecessary files."
else
    echo "[OK] Root filesystem usage is ${ROOT_USAGE}%."
fi

echo

if command -v docker >/dev/null 2>&1; then

    if docker info >/dev/null 2>&1; then

        echo "[4] Docker Disk Usage"
        echo "------------------------------------------"

        docker system df

    else
        echo "[4] Docker Disk Usage"
        echo "------------------------------------------"
        echo "[SKIP] Docker daemon is not accessible."
    fi

else

    echo "[4] Docker Disk Usage"
    echo "------------------------------------------"
    echo "[SKIP] Docker is not installed."

fi

echo

echo "[5] Large Directories Under /var"
echo "------------------------------------------"

if [ -d /var ]; then
    du -xhd1 /var 2>/dev/null | sort -h | tail -n 10
else
    echo "/var directory not found."
fi

echo

echo "=========================================="
echo " Check completed."
echo "=========================================="
