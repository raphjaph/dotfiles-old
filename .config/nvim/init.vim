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
"Plug 'fatih/vim-go'
"Plug 'LnL7/vim-nix'
"Plug 'simrat39/rust-tools.nvim'
"Plug 'dense-analysis/ale'

" pretty and lightweight status and tab lines
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim Tmux splits
Plug 'christoomey/vim-tmux-navigator'

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Indent stuff
Plug 'tpope/vim-sleuth'

" Wrapping soft/hard
Plug 'andrewferrier/wrapping.nvim'

" Quick commenting
Plug 'terrortylor/nvim-comment'

call plug#end()

"==============================================================================
" VIMRC SETTINGS
"==============================================================================
set termguicolors
colorscheme PaperColor
set background=dark

syntax on                   " syntax highlighting
filetype on
filetype plugin on
filetype indent on

set autoindent              " indent a new line the same amount as the line just typed
set autoread
set breakindent             " show soft-wrapped text with leading indent
set cursorline              " highlight current cursorline
set expandtab               " converts tabs to white space
set hidden                  " if hidden is not set, TextEdit might fail.
set ignorecase              " case insensitive
set incsearch               " incremental search
set linebreak               " break on characters in 'breakat'
set ma
set nofoldenable
set number                  " add line numbers
set ruler                   " show position in file
set shiftround              " round < and > to multiples of shiftwidth
set showmatch               " show matching
set smartcase
set smartindent
set smarttab
set splitright              " split new window to right
set ttyfast                 " make updates smoother but use more characters


set cc=80                   " set an 80 column border for good coding style
set clipboard=unnamedplus   " using system clipboard
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
set foldmethod=expr
set history=10000           " lines of history to remember
set mouse=a                 " enable mouse click
set scrolloff=15            " number of lines of context around cursor
set shortmess+=c            " don't give |ins-completion-menu| messages.
set signcolumn=yes          " always show signcolumns (left of numbers)
set t_Co=256
set undolevels=10000        " remember last 10000 changes
set updatetime=250          " set update time to 250ms

set formatoptions+=2        " use paragraph second line indent
set formatoptions+=j        " merge comments when joining lines
set formatoptions+=q        " allow formatting comments with `gq`
set formatoptions+=r        " insert comment leader after <enter> in insert mode
set formatoptions+=t        " auto-wrap at textwidth
set formatoptions-=a        " disable automatic formatting of paragraphs
set formatoptions-=c        " don't auto-wrap comments at textwidth
set formatoptions-=l        " format long lines when inserting


" Airlines Status Bar and Tabs
let airline_theme = 'base16_default_dark'
let airline_detect_modified = 1 " highlight modified buffers

" instantiate symbols dictionary first
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.colnr = ':'
let g:airline_symbols.branch = ''

" buffer/tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_splits = 0 " don't show tab name on right
let g:airline#extensions#tabline#buffer_idx_mode = 1 " show buffer indices

"let g:airline#extensions#ale#enabled = 1 " enable ale extension
"let g:airline#extensions#tabline#buffer_min_count = 2 " no tabline for less than 2 buffers
"let g:airline#extensions#tabline#buffer_nr_show = 0 " don't show buffer numbers
"let g:airline#extensions#tabline#buffers_label = '' " hide buffers label
"let g:airline#extensions#tabline#left_alt_sep = '' " hide left alt separator
"let g:airline#extensions#tabline#left_sep = '' " hide left separator
"let g:airline#extensions#tabline#right_alt_sep = '' " hide right alt separator
"let g:airline#extensions#tabline#right_sep = '' " hide right separator
"let g:airline#extensions#tabline#show_buffers = 1 " show buffers when no tabs are open
"let g:airline#extensions#tabline#show_tab_nr = 0 " don't show tab number
"let g:airline#extensions#tabline#show_tab_type = 0 " don't show tab type
"let g:airline#extensions#whitespace#enabled = 0 " turn off whitespace checker
"let g:airline_left_sep = '' " turn off left separator
"let g:airline_powerline_fonts = 1 " fixes missing whitespace in tabline
"let g:airline_right_sep = '' " turn off right separator
"let g:airline_skip_empty_sections = 1 " hide empty sections

nmap <space>1 <plug>AirlineSelectTab1
nmap <space>2 <plug>AirlineSelectTab2
nmap <space>3 <plug>AirlineSelectTab3
nmap <space>4 <plug>AirlineSelectTab4
nmap <space>5 <plug>AirlineSelectTab5
nmap <space>6 <plug>AirlineSelectTab6
nmap <space>7 <plug>AirlineSelectTab7
nmap <space>8 <plug>AirlineSelectTab8
nmap <space>9 <plug>AirlineSelectTab9

" netrw stuff
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 20
nnoremap <F3> :Lexplore<cr>

"Rust Stuff
"let g:rust_recommended_style           = 0 " use 2 space instead of 4 space tabs
"let g:rustfmt_autosave                 = 0 " run rustfmt on save
"let g:ale_completion_enabled           = 0 " enable completion
"let g:ale_fix_on_save                  = 1 " fix on save
"let g:ale_lint_on_enter                = 0 " lint when entering a new file
"let g:ale_lint_on_filetype_changed     = 0 " don't lint on filetype changed
"let g:ale_lint_on_insert_leave         = 0 " don't lint when leaving insert mode
"let g:ale_lint_on_save                 = 0 " lint on save
"let g:ale_lint_on_text_changed         = 0 " don't lint when text is changed
"let g:ale_rust_cargo_check_all_targets = 1 " run cargo check with all targets
"let g:ale_set_highlights               = 0 " don't set highlights for lints
"let g:ale_set_loclist                  = 1 " set loclist for lints
"let g:ale_set_signs                    = 1 " set signs for lints
"let g:ale_fixers = {
"\ '*': ['remove_trailing_lines', 'trim_whitespace'],
"\ 'markdown': ['remove_trailing_lines'],
"\ 'mail': ['remove_trailing_lines'],
"\ 'rust': ['rustfmt'],
"\}
"let g:ale_linters = { 'rust': ['rls'], 'fish': [] }


"nvim/lua/config.lua
lua require('init')
