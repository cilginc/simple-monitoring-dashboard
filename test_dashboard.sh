#!/usr/bin/env bash

# Default 60 secs
DURATION="${1:-60}"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if ! command -v stress-ng &> /dev/null; then
    echo -e "${RED}Installing stress-ng.${NC}"

    # Paket yöneticisini tespit et ve yükle
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y stress-ng
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm stress-ng
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y stress-ng
    elif command -v zypper &> /dev/null; then
        sudo zypper install -y stress-ng
    else
        echo -e "${RED}❌ Install stress-ng yourself.${NC}"
        exit 1
    fi

    # Yükleme sonrası tekrar kontrol et
    if ! command -v stress-ng &> /dev/null; then
        echo -e "${RED}Installation Failed.${NC}"
        exit 1
    else
        echo -e "${GREEN}stress-ng Installed.${NC}"
    fi
else
    echo -e "${GREEN}stress-ng already Installed.${NC}"
fi

echo "Starting Stress tests (süre: $DURATION secs)..."

# CPU testi (4 thread)
stress-ng --cpu 4 --timeout "$DURATION" &

# RAM testi (2 thread, her biri 512 MB)
stress-ng --vm 2 --vm-bytes 512M --timeout "$DURATION" &

# I/O testi (2 thread)
stress-ng --io 2 --timeout "$DURATION" &

# Disk testi (geçici dosya ile, 1 thread)
stress-ng --hdd 1 --hdd-bytes 1G --timeout "$DURATION" &

# Cache testi (L1/L2/L3 cache yükleme)
stress-ng --cache 2 --timeout "$DURATION" &

# Hepsinin bitmesini bekle
wait

echo -e "${GREEN}Stress tests are finished.${NC}"

