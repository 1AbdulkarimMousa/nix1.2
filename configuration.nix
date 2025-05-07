{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./config/base.nix
    ./services.nix
  ];
  
  # System settings
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "valutoria";

  # Bootloader configuration
  boot.loader.grub = {
    enable = true;
    devices = [ "/dev/vda" ];
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Base packages
  environment.systemPackages = with pkgs; [
    vim git curl wget htop zstd jq nano
  ];
  
  system.stateVersion = "24.11";
}