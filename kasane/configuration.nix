# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.kernelParams = [ "intel_idel.max_cstate=1" ];

  boot.loader.systemd-boot.enable = false;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  boot.loader.efi.efiSysMountPoint = "/boot";

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "C.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  users.users.pc = {
    isNormalUser = true;
    home = "/home/pc";
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
  };

  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    openssl
  ];

  environment.systemPackages = with pkgs; [
    neovim
    vim

    curl
    wget
    git
    unzip

    fastfetch
    brillo
    acpi
    htop

    dbus
    polkit
    xdg-utils
    tree-sitter

    firefox
    foot

    grim
    slurp
    wl-clipboard
    waybar
    rofi-wayland

    bat
    fd
    fzf
    jq
    ripgrep
    lazygit
    lazydocker
    lsd
    vivid
    yazi
    zoxide
    imagemagick

    clojure
    go
    rustc
    elixir
    jdk23
    lua54Packages.lua
    lua54Packages.luarocks
    nodejs_23
    php84
    python313
    ruby_3_4
    zig_0_13

    cargo
    python313Packages.pip
    php84Packages.composer
    yarn
    uv
    gnumake
    cmake
    ninja
    gcc
    pkg-config
  ];

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };


  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;
  services.dbus.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "25.05";
}
