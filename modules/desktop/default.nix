{config, pkgs, lib, ...}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) float;
in {
  imports = [
    ./niri.nix
    ./firefox.nix
    ./discord
  ];

  options = {
    meow.desktop = {
      enable = mkEnableOption "enable gui stuff";

      alacritty.fontSize = mkOption {
        type = float;
        default = 11.25; # alacritty default
        description = "font size of alacritty";
      };
    };
  };

  config = mkIf config.meow.desktop.enable {
    home-manager.users.carter = {...}: {
      programs.fuzzel.enable = true;
      programs.swaylock.enable = true;

      programs.alacritty = {
        enable = true;
        settings = {
          font.size = config.meow.desktop.alacritty.fontSize;
        };
      };

      programs.obs-studio.enable = true;
      programs.anki.enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.pulseaudio.enable = lib.mkForce false;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    fonts = {
      packages = with pkgs; [
        libertinus
        maple-mono.NF-CN # ty thunder :3
        nerd-fonts.symbols-only
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      fontconfig = {
        enable = true;
        useEmbeddedBitmaps = true;
        defaultFonts = {
          serif = ["Maple Mono NF CN"];
          sansSerif = ["Maple Mono NF CN"];
          monospace = ["Maple Mono NF CN" "Symbols Nerd Font"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };

    /*services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };*/

    environment.systemPackages = with pkgs; [
      blender
      fontforge-gtk
      gimp
      libreoffice
      pwvucontrol
      swayosd
      vlc
      xwayland-satellite

      wine64
      wineWow64Packages.waylandFull

      (prismlauncher.override {
        jdks = [
          zulu
          zulu8
          zulu17
        ];
      })
    ];
  };
}
