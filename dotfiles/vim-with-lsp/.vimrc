""""""""""""""""""
" Gatlin's vimrc "
""""""""""""""""""

" VARIABLES -------------------------------------------------------------- {{{
let g:tmux_navigator_no_mappings = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'
let g:ale_zig_zls_executable = 'zls'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'zig': ['zigfmt'],
\   'haskell': ['hlint'],
\   'python': ['black'],
\}

let lspServers = [
  \#{
  \  filetype: 'vim',
  \  path: 'vim-language-server',
  \  args: ['--stdio']
  \},
  \#{
  \  filetype: 'python',
  \  path: 'pylsp',
  \  args: []
  \},
  \#{
  \  filetype: 'sh',
  \  path: 'bash-language-server',
  \  args: ['start']
  \},
  \#{
  \  filetype: 'zig',
  \  path: 'zls',
  \  args: []
  \},
\ ]

let lspOpts = { 'autoHighlightDiags': v:true }

" }}}

" BASICS ----------------------------------------------------------------- {{{
" Indentation
set autoindent
set smartindent
set preserveindent
set tabstop=2
set shiftwidth=2
set expandtab ts=2 sw=2 ai
filetype indent on
filetype plugin on

" Code folding
set foldcolumn=0
set foldmethod=indent
set foldlevel=100

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch
set nohlsearch

" Key mappings
set pastetoggle=<F3>
nmap     <silent> <Space>    za:nohlsearch<CR>
nmap w1 :.w >>\\#bookz/in<cr>
nnoremap <C-g> :Rg<Cr>
nnoremap <C-f> :FZF<Cr>
nnoremap <C-n> :NERDTreeTabsToggle<Cr>
noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>
noremap <silent> <C-p> :<C-U>TmuxNavigatePrevious<cr>

" Splitting
set splitright
set splitbelow
set diffopt=filler,vertical

" Backup
set nobackup

" Wild menu (tab completion)
set wildmenu
set wildmode=full
set wildchar=<Tab>
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" File browser
let netrw_browse_split=4
"
" Other
set scrolloff=5
set backspace=indent,eol,start
set mouse=a
" fixes mouse scrolling in st
set ttymouse=sgr
" }}}

" Appearance ------------------------------------------------------------- {{{
" Text display
set t_Co=256
colorscheme torte
syntax on

" Lines & line numbers
set number
set numberwidth=5
set linebreak
set showmatch
set showbreak=>
set display=lastline

" Leading and trailing whitespace
set list
set listchars=tab:>-,trail:.

" Window size
set equalalways
set textwidth=79
set winminwidth=10
set winwidth=80
set nowrap
set nohlsearch

" Cursor line and ruler
set noruler
set cursorline
hi clear cursorline
hi cursorline gui=underline cterm=underline
" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{
" This will enable code folding for vim configs.
" Use the marker method
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

if has("gui_running")
    " GUI is running or is about to start
    set lines=999 columns=100
    set guifont=Fira\ Code\ Retina\ 11
    set guioptions-=m "menu bar
    set guioptions-=T "toolbar
    set guioptions-=r "scrollbar
else
"    " This is console vim
"    if exists("+lines")
"        set lines=50
"    endif
"    if exists("+columns")
"        set columns=100
"    endif
endif

" Window title
if $TERM=='tmux'
  exe 'set title titlestring=vim:%t%(\ %m%)'
  exe 'set title t_ts=]2;%t\\'
endif

" ensure zig is a recognized filetype
autocmd BufNewFile,BufRead *.zig set filetype=zig

" Check if vim-plug is installed and install it if not.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start language servers.
autocmd VimEnter * call LspAddServer(lspServers)
autocmd VimEnter * call LspOptionsSet(lspOpts)


" }}}

" STATUS LINE -- not relevant when airline is activated.------------------ {{{
set laststatus=2
set statusline=[%F]\%([%M%R]%)%=[%c,%l\ of\ %L]
set showcmd
set vb t_vb=
" }}}

" PLUGINS ---------------------------------------------------------------- {{{
call plug#begin(data_dir . '/plugged')

  Plug 'dense-analysis/ale'
  Plug 'preservim/nerdtree'
  Plug 'ziglang/zig.vim'
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'yegappan/lsp'
  Plug 'christoomey/vim-tmux-navigator'

call plug#end()
" }}}

