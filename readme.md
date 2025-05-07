sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /etc/disk-config.nix

nixos-generate-config --root /mnt && nixos-install