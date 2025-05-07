sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /etc/nixos/disk.nix

nixos-generate-config --root /mnt && nixos-install 