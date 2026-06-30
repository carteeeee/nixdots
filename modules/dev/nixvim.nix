{inputs, ...}: {
  home-manager.users.carter = {...}: {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];

    programs.nixvim = {
      enable = true;
      
      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 4;

        splitright = true;
        splitbelow = true;
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
        hex.enable = true;
        netman.enable = true;
        nix.enable = true;
        telescope.enable = true;
        web-devicons.enable = true;

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

      keymaps = let
        inherit (builtins) attrValues mapAttrs;
      in attrValues (mapAttrs (name: value: {key = "<leader>" + name; action = value;}) {
        q  = ":q<CR>";
        ww = ":w<CR>";
        wq = ":wqa<CR>";
        ph = ":split<CR>";
        pv = ":vs<CR>";
        h  = ":wincmd h<CR>";
        j  = ":wincmd j<CR>";
        k  = ":wincmd k<CR>";
        l  = ":wincmd l<CR>";
        z  = "<C-o>";
        x  = "<C-i>";
        sf = ":Telescope find_files<CR>";
        sw = ":Telescope grep_string<CR>";
        sl = ":Telescope live_grep<CR>";
        lr = ":Telescope lsp_references<CR>";
        ld = ":Telescope lsp_definitions<CR>";
        li = ":Telescope lsp_implementations<CR>";
        bm = "<cmd>make<CR>";
        bM = "<cmd>make clean<CR>";
        bc = "<cmd>cargo build<CR>";
        bC = "<cmd>cargo build --release<CR>";
      });
    };
  };
}
