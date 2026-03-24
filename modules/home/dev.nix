{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      echo "hello :3"
      hyfetch
    '';
  };

  programs.nixvim = {
    enable = true;
    
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };

    colorschemes.catppuccin.enable = true;

    plugins = {
      neo-tree = {
        enable = true;
        autoLoad = true;
	settings = {
          sources = [
            "filesystem"
	    "git_status"
	    "netman.ui.neo-tree"
	  ];
          filesystem.filtered_items.visible = true;
	  close_if_last_window = true;
	};
      };
      netman.enable = true;
      hex.enable = true;
      nix.enable = true;

      lsp = {
        enable = true;

        servers = {
          # in order of usefulness
          rust_analyzer = {
	    enable = true;
	    installCargo = false;
	    installRustc = false;
	  };
          nixd.enable = true;
          clangd.enable = true;
          ty.enable = true; # python
          eslint.enable = true;
          cssls.enable = true;
          html.enable = true;
        };
      };
    };
  };
}
