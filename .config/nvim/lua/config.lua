-- Telescope (fzf, viewer and other powerful stuff)
require("telescope").setup{
    defaults = {
        prompt_prefix = "> ",
    },
--  extensions = {
--    file_browser = {
--      theme = "ivy",
--      -- disables netrw and use telescope-file-browser in its place
--      hijack_netrw = true,
--      mappings = {
--        ["i"] = {
--          -- your custom insert mode mappings
--        },
--        ["n"] = {
--          -- your custom normal mode mappings
--        },
--    },
--  },
}
require("telescope").load_extension("fzf")
--require("telescope").load_extension("file_browser")


-- Treesitter (highlighting, folding, indentation, selection)
require('nvim-treesitter.configs').setup{
--    ensure_installed = {
--        'go',
--        'lua',
--        'python',
--        'rust'
--    },
--    auto_install = true,

    highlight = {
        enable = true,
    },

    indent = {
        enable = true
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}

--local lsp = require('lspconfig')
--
--local on_attach = function(client)
--  map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
--  map('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')
--  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
--  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
--  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
--  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
--end

-- =============================================================================
-- Native LSP
-- =============================================================================

-- connect to LSP through lspconfig plugin (set defaults)
local lsp = require("lspconfig")

local servers = { 
  "gopls", 
  "rust_analyzer", 
  "pyright", 
  "sumneko_lua", 
  "taplo" 
}

for _, server in ipairs(servers) do 
  lsp[server].setup{
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client)
        -- n=normal mode , K= key to press, shows suggestions, buffer=0 only in current buffer
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})    
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})    
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {buffer=0})    
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, {buffer=0})    
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})    
        vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, {buffer=0})    
        vim.keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, {buffer=0})    
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})    
        vim.keymap.set("n", "<leader>=", vim.lsp.buf.formatting, {buffer=0})
    end,
  }
end 


-- LSP Autocomplete (nvim-cmp)
-- It collects suggestions from source (lsp servers) and lists them
vim.opt.completeopt={"menu", "menuone", "noselect"}
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        -- Tab completion seems to be frowned upon; no idea why
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
    },
    -- sources are where suggestions are pulled from 
    sources = cmp.config.sources({
    { name = 'nvim_lsp' },
        -- snippets are pieces of reusable code; inserts suggestion?
        --{ name = 'luasnip' },
    }, {
            -- buffer looks at text in current buffers and suggests based on that
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

