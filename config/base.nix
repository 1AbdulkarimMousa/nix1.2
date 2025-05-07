{ config, lib, pkgs, ... }:

{
  # Create the odoo group
  users.groups.odoo = {};
  
  # Set up SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  
  # Basic firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
  };
}