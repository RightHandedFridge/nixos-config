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
      clangd # C/C++

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
    extraConfig = ''
      -- Set <space> as the leader key
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      -- ===================================================================
      --  1. Basic Options
      -- ===================================================================
      vim.opt.number = true         -- Show line numbers
      vim.opt.relativenumber = true -- Show relative line numbers
      vim.opt.mouse = 'a'           -- Enable mouse support
      vim.opt.expandtab = true      -- Use spaces instead of tabs
      vim.opt.shiftwidth = 2        -- Number of spaces for indentation
      vim.opt.tabstop = 2           -- Number of spaces a tab counts for
      vim.opt.ignorecase = true     -- Ignore case in search
      vim.opt.smartcase = true      -- Smart case search
      vim.opt.hlsearch = true       -- Highlight search results
      vim.opt.incsearch = true      -- Show search results as you type
      vim.opt.wrap = false          -- Don't wrap lines
      vim.opt.termguicolors = true  -- Enable true color support
      vim.opt.scrolloff = 8         -- Keep 8 lines above/below cursor

      -- ===================================================================
      --  2. Keymaps
      -- ===================================================================
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Save file
      map('n', '<C-s>', '<cmd>w<CR>', opts)
      map('i', '<C-s>', '<Esc><cmd>w<CR>a', opts)

      -- File Explorer (Neo-tree)
      map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = "Toggle File Explorer" })

      -- Fuzzy Finder (Telescope)
      map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = "Find Files" })
      map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = "Find in Files (Grep)" })
      map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = "Find Buffers" })

      -- Git (Lazygit)
      map('n', '<leader>gg', '<cmd>lua vim.fn.system("lazygit")<CR>', { desc = "Open Lazygit" })

      -- ===================================================================
      --  3. Plugin Setup
      -- ===================================================================

      -- Colorscheme
      require('tokyonight').setup({ style = 'storm' })
      vim.cmd.colorscheme 'tokyonight'

      -- Statusline
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          section_separators = '',
          component_separators = '',
        },
      }

      -- File Explorer
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

      -- Fuzzy Finder
      require('telescope').setup({})

      -- Git Signs
      require('gitsigns').setup()

      -- ===================================================================
      --  4. LSP (Language Server Protocol) Setup
      -- ===================================================================
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- This function runs when an LSP server attaches to a buffer
      local on_attach = function(client, bufnr)
        local buf_map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
        end

        -- LSP Keymaps (like VSCode's F12, Shift+F12, etc.)
        buf_map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
        buf_map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
        buf_map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
        buf_map('n', 'gr', vim.lsp.buf.references, 'Find References')
        buf_map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
        buf_map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        buf_map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, 'Format Code')
      end

      -- List of servers to set up
      -- The names here must match the lspconfig server names
      local servers = {
        'tsserver',
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

      -- Loop through and set up each server
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      -- ===================================================================
      --  5. Autocompletion (nvim-cmp) Setup
      -- ===================================================================
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        -- Sources for completion
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