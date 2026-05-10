{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      echo "hello :3"
      hyfetch
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nixvim = {
    enable = true;
    
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };

    globals.mapleader = " ";
    clipboard.register = "unnamed";
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
      telescope.enable = true;
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

    keymaps = [
      {
        key = "<leader>z";
        action = "<C-o>";
      }
      {
        key = "<leader>x";
        action = "<C-i>";
      }
      {
        key = "<leader>sf";
        action = ":Telescope find_files<CR>";
      }
      {
        key = "<leader>sw";
        action = ":Telescope grep_string<CR>";
      }
      {
        key = "<leader>sl";
        action = ":Telescope live_grep<CR>";
      }
      {
        key = "<leader>lr";
        action = ":Telescope lsp_references<CR>";
      }
      {
        key = "<leader>ld";
        action = ":Telescope lsp_definitions<CR>";
      }
      {
        key = "<leader>li";
        action = ":Telescope lsp_implementations<CR>";
      }
      {
        key = "<leader>bm";
        action = "<cmd>make<CR>";
      }
      {
        key = "<leader>bc";
        action = "<cmd>cargo build<CR>";
      }
      {
        key = "<leader>bC";
        action = "<cmd>cargo build --release<CR>";
      }
    ];
  };
}
