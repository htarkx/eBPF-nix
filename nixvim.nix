{ pkgs, ... }:
{
  globals.mapleader = " ";

  opts = {
    number = true;
    relativenumber = true;
    termguicolors = true;
    signcolumn = "yes";
    updatetime = 200;
    splitright = true;
    splitbelow = true;
  };

  plugins = {
    nvim-tree.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    lualine.enable = true;
    gitsigns.enable = true;
    which-key.enable = true;
    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        gopls.enable = true;
      };
    };

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
        snippet.expand = ''
          function(args)
            require("luasnip").lsp_expand(args.body)
          end
        '';
      };
    };

    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-cmdline.enable = true;

    luasnip.enable = true;
  };

  keymaps = [
    { mode = "n"; key = "<leader>e"; action = "<cmd>NvimTreeToggle<cr>"; }
    { mode = "n"; key = "<leader>E"; action = "<cmd>NvimTreeFindFile<cr>"; }
    { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; }
    { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; }
    { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; }
    { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<cr>"; }
    { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; }
    { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; }
    { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; }
    { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; }
    { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; }
    { mode = "n"; key = "<leader>ds"; action = "<cmd>lua vim.diagnostic.open_float()<cr>"; }
    { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<cr>"; }
    { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<cr>"; }
  ];
}
