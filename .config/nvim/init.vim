"==============================================================================
" PLUGINS
"==============================================================================

call plug#begin('~/.config/nvim/autoload')

" Color Theme
Plug 'NLKNguyen/papercolor-theme'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" Treesitter (AST)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Native LSP; collection of commmon configs
Plug 'neovim/nvim-lspconfig'

"LSP autocomplete; completion sources:
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" language support and code completion
Plug 'fatih/vim-go'
"Plug 'sheerun/vim-polyglot'
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'LnL7/vim-nix'
Plug 'simrat39/rust-tools.nvim'


" Markdown Viewer: requires nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()




"==============================================================================
" VIMRC SETTINGS
"==============================================================================
syntax on                   " syntax highlighting
filetype on
filetype plugin on
filetype indent on

colorscheme PaperColor
set background=dark

set number                  " add line numbers
set cc=80                   " set an 80 column border for good coding style
set ma
set showmatch               " show matching 
set cursorline              " highlight current cursorline
set scrolloff=20             " number of lines of context around cursor

set ignorecase              " case insensitive 
set incsearch               " incremental search

set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=2            " width for autoindents
set expandtab               " converts tabs to white space
set autoindent              " indent a new line the same amount as the line just typed
set smartindent

set autoread
set mouse=v                 " middle-click paste with 
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set splitright              " split new window to right
set t_Co=256

set hidden                  " if hidden is not set, TextEdit might fail.
set updatetime=300          " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c            " don't give |ins-completion-menu| messages.
set signcolumn=yes          " always show signcolumns (left of numbers)


set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
set nofoldenable
"set foldminlines=
"set foldnestmax=
"set foldclose=all


" nvim/lua/config.lua
lua require('config')


"==============================================================================
" MAPPINGS
"==============================================================================

let mapleader = " " 

" reload and open init.vim
" | is the :bar or <BAR> command to execute two commands
nnoremap <Leader>r :source $MYVIMRC <cr>
nnoremap <silent> <Leader>e :e $MYVIMRC<cr>
nnoremap <Leader>f :Telescope find_files<cr>
nnoremap <Leader>g :Telescope live_grep<cr>
nnoremap <F3> :Lexplore<cr>

nnoremap <Leader>m :MarkdownPreview<CR>
let g:mkdp_auto_close = 0 " do not close the preview tab when switching to other buffers


" netrw stuff
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 20

" -----------------------------------------------------------------------------
" coc.nvim default settings
" CoC (Code Completion)
" define new LSPs (Language Servers in ~/.config/nvim/coc-setting.json)
" -----------------------------------------------------------------------------

" TODO: figure out tab completions for native LSP

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

"" Use `[c` and `]c` to navigate diagnostics
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)
"
"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use U to show documentation in preview window
"nnoremap <silent> U :call <SID>show_documentation()<CR>
"
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
"
"" Remap for format selected region
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>n
"
"" disable vim-go :GoDef short cut (gd)
"" this is handled by LanguageClient [LC]
"let g:go_def_mapping_enabled = 0
