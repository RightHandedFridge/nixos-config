{ pkgs, ... }:

{

  # Neovim Configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true; # Sets nvim as the default $EDITOR

    # --- Plugins ---
    # Home Manager will manage installing these plugins
    plugins = with pkgs.vimPlugins; [
      # Core
      nvim-lspconfig # LSP configuration
      plenary-nvim # A dependency for telescope

      # UI & UX
      tokyonight-nvim
      lualine-nvim
      nvim-web-devicons # For file icons

      # Completion (like VSCode's IntelliSense)
      nvim-cmp
      cmp-nvim-lsp # LSP source for nvim-cmp
      cmp-buffer   # Buffer source for nvim-cmp
      cmp-path     # Path source for nvim-cmp
      luasnip      # Snippet engine
      cmp_luasnip  # Snippet source for nvim-cmp

      # File Explorer (like VSCode's sidebar)
      neo-tree-nvim
      nui-nvim # Dependency for neo-tree

      # Fuzzy Finder (like VSCode's Ctrl+P)
      telescope-nvim

      # Git (like VSCode's source control)
      gitsigns-nvim
    ];

    # --- External Packages ---
    # These are the actual LSP servers and tools
    extraPackages = with pkgs; [
      # --- LSPs for "big languages" ---
      # Web
      nodePackages.typescript-language-server # For JavaScript/TypeScript
      nodePackages.vscode-langservers-extracted # For HTML, CSS, JSON
      nodePackages.yaml-language-server       # For YAML

      # Backend
      pyright # Python
      gopls   # Go
      rust-analyzer # Rust

      # Systems
      clang-tools # C/C++

      # DevOps / Shell
      bash-language-server
      nil # Nix Language Server
      # --- End LSPs ---

      # --- Tools ---
      ripgrep # Required for telescope's live_grep (find in files)
      fd      # Required for telescope's find_files
      lazygit # The full Git TUI
    ];

    # --- Lua Configuration ---
    # This is where all the plugins are set up
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = 'a'
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = true
      vim.opt.incsearch = true
      vim.opt.wrap = false
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map('n', '<C-s>', '<cmd>w<CR>', opts)
      map('i', '<C-s>', '<Esc><cmd>w<CR>a', opts)

      map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = "Toggle File Explorer" })

      map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = "Find Files" })
      map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = "Find in Files (Grep)" })
      map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = "Find Buffers" })

      map('n', '<leader>gg', '<cmd>lua vim.fn.system("lazygit")<CR>', { desc = "Open Lazygit" })

      require('tokyonight').setup({ style = 'storm' })
      vim.cmd.colorscheme 'tokyonight'

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          section_separators = "",
          component_separators = "",
        },
      }

      require('neo-tree').setup({
        window = {
          position = "left",
          width = 30
        },
        filesystem = {
          follow_current_file = true,
          hijack_netrw_behavior = "open_current",
        },
      })

      require('telescope').setup({})

      require('gitsigns').setup()

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(client, bufnr)
        local buf_map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
        end

        buf_map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
        buf_map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
        buf_map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
        buf_map('n', 'gr', vim.lsp.buf.references, 'Find References')
        buf_map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
        buf_map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        buf_map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, 'Format Code')
      end

      local servers = {
        'ts_ls',
        'html',
        'cssls',
        'jsonls',
        'yamlls',
        'pyright',
        'gopls',
        'rust_analyzer',
        'clangd',
        'bashls',
        'nil_ls',
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    '';
  };
}
