{ pkgs ? import <nixpkgs> {} }:

let
  editions = {
    "15.0" = {
      src = pkgs.fetchFromGitHub {
        owner = "odoo";
        repo = "odoo";
        rev = "15.0";
        sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # replace
      };
    };
    "16.0" = {
      src = pkgs.fetchFromGitHub {
        owner = "odoo";
        repo = "odoo";
        rev = "16.0";
        sha256 = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
      };
    };
    "17.0" = {
      src = pkgs.fetchFromGitHub {
        owner = "odoo";
        repo = "odoo";
        rev = "17.0";
        sha256 = "sha256-CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC=";
      };
    };
    "18.0" = {
      src = pkgs.fetchFromGitHub {
        owner = "odoo";
        repo = "odoo";
        rev = "18.0";
        sha256 = "sha256-DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD=";
      };
    };
  };
in
editions
