#!/bin/bash
set -e

# Device and partition configurations from disko.nix
DEVICE="/dev/sdb"
ESP_SIZE="256M"
ESP_TYPE="EF00"
ESP_LABEL="ESP"
SWAP_SIZE="1G"
SWAP_TYPE="8200"
SWAP_LABEL="swap"
ROOT_TYPE="8300"
ROOT_LABEL="root"
MOUNT_ROOT="/mnt"
MOUNT_BOOT="/mnt/boot"

# Clear existing partition table
echo "Wiping partition table on $DEVICE..."
sgdisk -Z "$DEVICE"

# Create new GPT partition table
echo "Creating new GPT partition table..."
sgdisk -o "$DEVICE"

# Create EFI System Partition
echo "Creating EFI System Partition..."
sgdisk -n 1:0:+$ESP_SIZE -t 1:$ESP_TYPE -c 1:$ESP_LABEL "$DEVICE"

# Create swap partition
echo "Creating swap partition..."
sgdisk -n 2:0:+$SWAP_SIZE -t 2:$SWAP_TYPE -c 2:$SWAP_LABEL "$DEVICE"

# Create root partition (remaining space)
echo "Creating root partition..."
sgdisk -n 3:0:0 -t 3:$ROOT_TYPE -c 3:$ROOT_LABEL "$DEVICE"

# Format partitions
echo "Formatting EFI System Partition..."
mkfs.vfat -F32 "${DEVICE}1"

echo "Setting up swap..."
mkswap "${DEVICE}2"
swapon "${DEVICE}2"

echo "Formatting root partition with btrfs..."
mkfs.btrfs "${DEVICE}3"

# Create mount points
mkdir -p $MOUNT_ROOT $MOUNT_BOOT

# Mount partitions
echo "Mounting root partition..."
mount "${DEVICE}3" $MOUNT_ROOT

echo "Mounting boot partition..."
mount "${DEVICE}1" $MOUNT_BOOT

echo "Partitioning complete!"