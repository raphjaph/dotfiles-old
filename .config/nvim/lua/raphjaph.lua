-- Native LSP for Golang
-- connect to LSP through lspconfig plugin (set defaults)
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.gopls.setup{
    capabilities = capabilities,
    on_attach = function()
        -- n=normal mode , K= key to press, shows suggestions, buffer=0 only in current buffer
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})    
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})    
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {buffer=0})    
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, {buffer=0})    
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})    
        vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, {buffer=0})    
        vim.keymap.set("n", "<leader>db", vim.diagnostic.goto_prev, {buffer=0})    
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})    
    end,
}

-- Telescope (fzf, viewer and other powerful stuff)
require('telescope').setup{
    -- lua tables
    defaults = {
        prompt_prefix = "$ ",
    }
}
require('telescope').load_extension('fzf')


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
            ["<Tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ["<S-Tab>"] = function(fallback)
                if cmp.visible() then 
                    cmp.select_prev_item()
                else
                    fallback()
                end 
            end,
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

