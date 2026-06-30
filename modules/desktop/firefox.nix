{config, lib, ...}: let
  inherit (builtins) mapAttrs;
  inherit (lib) mapAttrsToList mkIf;
in {
  home-manager.users.carter = {...}: mkIf config.meow.desktop.enable {
    programs.firefox = {
      enable = true;
      policies = {
        ExtensionSettings = mapAttrs (_: value: {
          installation_mode = "normal_installed";
          install_url = value;
          private_browsing = true;
        }) {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" =
            "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          "uBlock0@raymondhill.net" =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          "FirefoxColor@mozilla.com" =
            "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
          "addon@darkreader.org" =
            "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };

        AIControls = {
          Default.Value = "blocked";
          Translations.Value = "available";
        };

        Bookmarks = [
          {
            Title = "nix builtins";
            URL = "https://nix.dev/manual/nix/latest/language/builtins";
          }
        ];

        FirefoxHome = {
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          Stores = false;
          SponsoredPocket = false;
          SponsoredStories = false;
          Snippets = false;
        };

        SearchEngines = {
          Default = "DuckDuckGo";
          Remove = ["Perplexity"];
          Add = mapAttrsToList (name: value: {
            Name = name;
            URLTemplate = value;
          }) {
            "Wiktionary" =
              "https://en.wiktionary.org/wiki/Special:Search?search={searchTerms}";
            "Nixpkgs" =
              "https://search.nixos.org/packages?search={searchTerms}";
            "Nix Options" =
              "https://search.nixos.org/options?search={searchTerms}";
          };
        };

        DisplayBookmarksToolbar = "newtab";
        GenerativeAI.Enabled = false;
        SkipTermsOfUse = true;
      };
    };
  };
}
