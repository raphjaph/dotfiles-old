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

" Treesitter (AST)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Native LSP; collection of commmon configs
Plug 'neovim/nvim-lspconfig'

"LSP autocomplete; completion sources:
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

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

" just 
Plug 'NoahTheDuke/vim-just'

Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.1.0'}

" pipe errors to nvim 
Plug 'alopatindev/cargo-limit', { 'do': 'cargo install cargo-limit nvim-send' }
Plug 'romainl/vim-qf'                     " quickfix improvements

" Formatting
" Plug 'sbdchd/neoformat'
" Plug 'dense-analysis/ale'

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
set wildmode=longest,list,full


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

"nvim/lua/init.lua
lua require('init')



" Functions
function! g:CargoLimitOpen(result)
  let l:winnr = winnr()

  let l:quickfix_is_open = QuickfixIsOpen()

  cgetexpr []
  for file in a:result['files']
    caddexpr file['path'].':'.file['line'].':'.file['column'].':'.file['message']
  endfor

  if !l:quickfix_is_open
    cclose
  endif

  if l:winnr !=# winnr()
    wincmd p
  endif
endfunction

function! QuickfixIsOpen()
  for n in range(1, winnr('$'))
    if getwinvar(n, '&syntax') == 'qf'
      return 1
    endif
  endfor

  return 0
endfunction

function! QuickfixNext(previous)
  if len(getqflist()) == 0
    echo "Quickfix list empty."
    return
  endif

  if QuickfixIsOpen()
    if a:previous
      execute "normal \<plug>(qf_qf_previous)"
    else
      execute "normal \<plug>(qf_qf_next)"
    endif
  else
    execute "normal \<plug>(qf_qf_toggle_stay)"
    execute 'cc 1'
  endif
endfunction

nnoremap + :call QuickfixNext(0)<cr>|                  " go to next error
map  -  <plug>(qf_qf_toggle_stay)|                     " toggle quickfix window
nnoremap _ :call QuickfixNext(1)<cr>|                  " go to previous error
nnoremap <leader>qc :call setqflist([])<cr>|           " clear quickfix list

set errorformat   =%f:%l:%c:%m           " set errorformat
