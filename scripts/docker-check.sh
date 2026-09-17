#!/usr/bin/env bash

set -u

echo "=========================================="
echo " Docker Environment Check"
echo "=========================================="
echo

# Check Docker command
if command -v docker >/dev/null 2>&1; then
    echo "[OK] Docker command found:"
    docker --version
else
    echo "[ERROR] Docker command not found."
    echo "Please install Docker first."
    exit 1
fi

echo

# Check Docker daemon
if docker info >/dev/null 2>&1; then
    echo "[OK] Docker daemon is accessible."
else
    echo "[WARNING] Docker daemon is not accessible."
    echo
    echo "Possible causes:"
    echo "  1. Docker service is not running."
    echo "  2. Current user does not have permission to access Docker."
    echo "  3. Docker socket is unavailable."
    echo
fi

# Check Docker service when systemctl exists
if command -v systemctl >/dev/null 2>&1; then
    echo "[INFO] Docker service status:"
    systemctl is-active docker 2>/dev/null || true
    echo
fi

# Check Docker socket
if [ -S /var/run/docker.sock ]; then
    echo "[OK] Docker socket exists:"
    ls -l /var/run/docker.sock
else
    echo "[WARNING] Docker socket not found:"
    echo "/var/run/docker.sock"
fi

echo

# Check current user
echo "[INFO] Current user:"
whoami

echo

# Check docker group
if id -nG 2>/dev/null | tr ' ' '\n' | grep -qx docker; then
    echo "[OK] Current user belongs to the docker group."
else
    echo "[INFO] Current user is not in the docker group."
    echo "      This may be normal if Docker is being accessed another way."
fi

echo

# Container summary
if docker info >/dev/null 2>&1; then
    echo "=========================================="
    echo " Container Summary"
    echo "=========================================="
    docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
else
    echo "[SKIP] Container list unavailable because Docker is not accessible."
fi

echo
echo "=========================================="
echo " Check completed."
echo "=========================================="
