#!/bin/bash
set -e
# Device and partition configurations
DEVICE="/dev/sdb"
BIOS_BOOT_SIZE="2M"
BIOS_BOOT_TYPE="EF02"
BIOS_BOOT_LABEL="BIOSBOOT"
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

# Create BIOS boot partition
echo "Creating BIOS boot partition..."
sgdisk -n 1:0:+$BIOS_BOOT_SIZE -t 1:$BIOS_BOOT_TYPE -c 1:$BIOS_BOOT_LABEL "$DEVICE"

# Create EFI System Partition
echo "Creating EFI System Partition..."
sgdisk -n 2:0:+$ESP_SIZE -t 2:$ESP_TYPE -c 2:$ESP_LABEL "$DEVICE"

# Create swap partition
echo "Creating swap partition..."
sgdisk -n 3:0:+$SWAP_SIZE -t 3:$SWAP_TYPE -c 3:$SWAP_LABEL "$DEVICE"

# Create root partition (remaining space)
echo "Creating root partition..."
sgdisk -n 4:0:0 -t 4:$ROOT_TYPE -c 4:$ROOT_LABEL "$DEVICE"

# Format partitions
echo "Formatting EFI System Partition..."
mkfs.vfat -F32 "${DEVICE}2"

echo "Setting up swap..."
mkswap "${DEVICE}3"
swapon "${DEVICE}3"

echo "Formatting root partition with ext4 for PostgreSQL..."
mkfs.ext4 "${DEVICE}4"

# Create mount points
echo "Creating mount points..."
mkdir -p $MOUNT_ROOT
mount "${DEVICE}4" $MOUNT_ROOT
mkdir -p $MOUNT_BOOT

# Mount partitions
echo "Mounting partitions..."
mount "${DEVICE}2" $MOUNT_BOOT

echo "Partitioning complete!"