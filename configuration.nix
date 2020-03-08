# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
{
#DISGUSTING LIST OF DISGUSTING UNMANAGED BINARIES ON THIS SYSTEM
#flutter-sdk #UGLY MAGIC BULLSHIT# sudo mkdir /lib64;sudo ln -sf $(file -L /usr/bin/env | cut -d"," -f5 | cut -d" " -f3) /lib64/ld-linux-x86-64.so.2
#P3X-onenote #appimage place in binaryland, and aliased to onenote

  #with import <nixpkgs> {};
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
 # oraclejdk.accept_license = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  virtualisation.docker.enable = true;
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.oraclejdk.accept_license = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp58s0.useDHCP = true;
#  networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  users.users.trisimix.extraGroups = [ "adbusers" "docker" "wheel" "networkmanager" "audio" ];  
  services.xserver.enable = true;
#  services.xserver.windowManager.i3.enable = true;
  #android_sdk.accept_license = true;
  programs.adb.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = false;
  hardware.opengl.driSupport32Bit = true;
 hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  users.users.trisimix = 
	{
	isNormalUser = true;
 	home = "/home/trisimix";
	description = "Jbreezy";
#	extraGroups = [ "wheel" ];
	};
  security.sudo.configFile = "%wheel ALL=(ALL) ALL";
#  services.xserver.displayManager.slim.enable = false;
#  services.xserver.videoDrivers = [ "nvidia" ];
  
#  services.xserver.synaptics.enable = true;
# Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget

   environment.systemPackages = with pkgs; [
     runelite
     google-chrome
     wget vim file unzip zip
     firefox 
     vscode 
     steam unity3d mono libva
     discord gnome3.cheese obs-studio
     fcitx gnupg 
     #haskellPackages.android haskellPackages.adb
     android-studio dart
     snappy
     wireshark
     nodejs electron nodePackages.node2nix nodePackages.typescript #nodePackages.express
     elixir
     git docker
     dotnet-sdk
     gcc
     python3
     appimage-run at-spi2-core at-spi2-core
     oraclejdk
     fcitx-configtool fcitx-engines.mozc ibus-engines.mozc
     libreoffice-fresh
     office-code-pro
     gimp krita inkscape vlc mpv
     deluge
   ];
nixpkgs.overlays = [
  ( self: super: {
  appimage-run = super.appimage-run.override {
    extraPkgs = p: with p; [
      at-spi2-core
    ];
  };
})
];
#oraclejdk.accept_license = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
  



 #FONTS

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.consoleKeyMap = "us";
  i18n.consoleFont = "Lat2-Terminus16";  
  fonts.fonts = with pkgs; [
    carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
  ];

  #JAPANESE
  
  # This enables "fcitx" as your IME.  This is an easy-to-use IME.  It supports many different input methods.
  i18n.inputMethod.enabled = "fcitx";

  # This enables "mozc" as an input method in "fcitx".  This has a relatively
  # complete dictionary.  I recommend it for Japanese input.
  i18n.inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
}

