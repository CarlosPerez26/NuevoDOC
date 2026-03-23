vim.g.mapleader = " "
vim.opt.number = true          -- Mostrar número de línea
vim.opt.relativenumber = true -- Números relativos
vim.opt.mouse = "a"            -- Soporte de ratón
vim.opt.clipboard = "unnamedplus" -- Portapapeles compartido
vim.opt.termguicolors = true   -- Colores reales

-- Indentación (Estándar 2 espacios para Web/LSP)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Habilitar texto virtual de diagnósticos (Neovim 0.11 lo desactiva por defecto)
vim.diagnostic.config({ virtual_text = true })

-- Navegación de errores (Nuevo en 0.11: vim.diagnostic.jump)
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Error anterior" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Error siguiente" })

-- =============================================================================
-- BOOTSTRAP LAZY.NVIM
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- PLUGINS
-- =============================================================================
require("lazy").setup({
  -- Tema (Colorscheme)
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme oxocarbon]])

      local highlights = {
        "Normal", "NormalNC", "SignColumn", "FoldColumn",
        "EndOfBuffer", "MsgArea", "StatusLine", "StatusLineNC"
      }
      for _, group in ipairs(highlights) do
        vim.api.nvim_set_hl(0,group, {bg="none", ctermbg="none"})
      end
    end,
  },
  -- Explorador de archivos
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        is_hidden_file = function(name, _)
          if name == ".git" then return true end
          return false
        end,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Abrir directorio padre" },
    },
  },

  -- Buscador Difuso (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Buscar Archivos" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Buscar Texto (Ripgrep)" })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Buscar Buffers" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Buscar Ayuda" })
    end,
  },

  -- Comentarios rápidos (gc o gb)
  { "numToStr/Comment.nvim", opts = {} },

  -- Autopairs
  { "windwp/nvim-autopairs", opts = {} },

  -- Git Signs
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Ayuda de teclas (Which-key) v3
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },

  -- Mejor interfaz de UI (Noice)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.set_formatting_item_col"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- Treesitter (Resaltado)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "typescript",
          "svelte",
          "python",
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "html",
          "css",
          "markdown",
          "markdown_inline",
        },
        sync_install = false, -- Instalar asíncronamente (mejor para el inicio)
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- Autotag (Cerrado automático de tags HTML/Svelte)
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "javascript", "typescript", "jsx", "tsx", "svelte", "vue", "xml" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Contexto de Treesitter
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      max_lines = 3,
      trim_scope = "outer",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- Rainbow Delimiters
  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- Render Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },

  -- Mason (LSP/DAP package manager)
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- Mason LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "ts_ls", "svelte", "pyright" },
      automatic_installation = false,
    },
  },

  -- LSPConfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
    },
    config = function()
      -- Keymaps en LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local nmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
          end
          nmap("gd", vim.lsp.buf.definition, "Ir a Definición")
          nmap("gr", vim.lsp.buf.references, "Ir a Referencias")
          nmap("K", vim.lsp.buf.hover, "Documentación flotante")
          nmap("<leader>rn", vim.lsp.buf.rename, "Renombrar")
          nmap("<leader>ca", vim.lsp.buf.code_action, "Acción de código")
        end,
      })
    end,
  },

  -- Fidget para progreso
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
})
