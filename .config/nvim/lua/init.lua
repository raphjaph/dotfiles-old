-- =============================================================================
-- Telescope (fzf, viewer and other powerful stuff)
-- =============================================================================
require("telescope").setup {
  defaults = {
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6667,
      },
    },
  }
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "file_browser"

-- =============================================================================
-- Treesitter (highlighting, folding, indentation, selection)
-- =============================================================================
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "c",
    "lua",
    "rust",
    "python",
    "toml",
    "nix",
    "go",
    "html",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<cr>",
      node_incremental = "<cr>",
      scope_incremental = "<tab>",
      node_decremental = "<bs>",
    },
  },
  additional_vim_regex_highlighting = false,
})


local opts = { noremap = true, silent = true }

-- =============================================================================
-- Diagnostics
-- =============================================================================

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
}
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


-- =============================================================================
-- Misc & Mappings
-- =============================================================================

-- | is the :bar or <BAR> command to execute two commands
vim.keymap.set('n', '<space>sv', "<cmd>source ~/.config/nvim/init.vim<cr> | <cmd>PlugInstall<cr>", opts)
vim.keymap.set('n', '<space>rc', "<cmd>edit ~/.config/nvim/init.vim<cr> | <cmd>vs ~/.config/nvim/lua/init.lua<cr>", opts)
vim.keymap.set('n', '<space>f', "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set('n', '<space>g', "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set('n', '<space>fb', "<cmd>Telescope file_browser<cr>", opts)
vim.keymap.set('n', 'gn', "<cmd>bnext<cr>", opts)
vim.keymap.set('n', 'gp', "<cmd>bprev<cr>", opts)
vim.keymap.set('n', '<esc>', "<cmd>noh<return><esc>", opts)
vim.keymap.set('n', '<esc>^[', "<esc>^[", opts)


-- =============================================================================
-- Comments
-- =============================================================================
require('nvim_comment').setup()
vim.keymap.set('n', '<C-c>', "<cmd>CommentToggle<cr>", opts)


-- =============================================================================
-- LSP & Mappings
-- =============================================================================
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>", bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>=', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set("n", "<space>tc", ":lua require('toggle-completion').toggle_completion()<CR>", bufopt)
end

local servers = {
  "rust_analyzer",
  "gopls",
  ---  "pyright",
  "sumneko_lua",
  ---  "taplo"
  -- "html-languageserver",
}
for _, server in ipairs(servers) do
  -- connect to LSP through lspconfig plugin (set defaults)
  require("lspconfig")[server].setup {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
  }
end
--
--
-- =============================================================================
-- LSP Autocomplete (nvim-cmp)
-- =============================================================================
---- It collects suggestions from source (lsp servers) and lists them
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<C-k>"] = cmp.mapping({
      i = function()
        if cmp.visible() then
          cmp.abort()
          require("toggle-completion").toggle_completion()
        else
          cmp.complete()
          require("toggle-completion").toggle_completion()
        end
      end,
    }),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          require("toggle-completion").toggle_completion()
        else
          fallback()
        end
      end,
    }),

    --        -- Tab completion seems to be frowned upon; no idea why
    --        ["<Tab>"] = function(fallback)
    --            if cmp.visible() then
    --                cmp.select_next_item()
    --            else
    --                fallback()
    --            end
    --        end,
    --        ["<S-Tab>"] = function(fallback)
    --            if cmp.visible() then
    --                cmp.select_prev_item()
    --            else
    --                fallback()
    --            end
    --        end,
  }),
  -- sources are where suggestions are pulled from
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

return false
