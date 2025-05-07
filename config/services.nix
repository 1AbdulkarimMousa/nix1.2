{ config, pkgs, ... }:

{
  services = {
    # PostgreSQL 17
    postgresql = {
      enable = true;
      package = pkgs.postgresql_17;
    };
    
    # Latest nginx
    nginx = {
      enable = true;
      package = pkgs.nginxMainline; # Uses latest mainline nginx version
    };
  };
}