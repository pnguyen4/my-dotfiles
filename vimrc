" Sets # lines of history
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" auto read when file in changed from outside buffer
set autoread

" leaders are useful
let mapleader = ","
let g:mapleader = ","

" sudo save file, good when write permission isn't given
command W w !doas tee % > /dev/null

" set scrolloff (# of lines above/below cursor)
set so=10

" turn on wildmenu for filename completion in command mode
set wildmenu
set wildmode=longest,list,full
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

" basic UI fixes
set ruler
set cmdheight=1
"set foldcolumn=1
set laststatus=2 " see theme section for the statusline format

" hide abandoned buffers
set hid

" backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" make search good
set ignorecase
set smartcase
set hlsearch
set incsearch

" don't redraw when executing macros (good performance)
set lazyredraw

" regex magic
set magic

" Show matching brackets on indicator hover
set showmatch
set mat=2

" no bleeping bleeps!
set noerrorbells
set novisualbell

" enable syntax highlighting
syntax enable
autocmd BufEnter * :syntax sync fromstart
autocmd BufEnter * :set number
"highlight LineNr ctermfg=grey

" why isn't this universal yet?
set encoding=utf8
set ffs=unix,dos,mac

" my theme
set background=dark
colorscheme eink

" no backups, no swap file(s) mess
set nobackup
set nowb
set noswapfile

" tab config, commence holy war
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" auto and smart indent
set ai
set si

" linebreak on 100 chars
set lbr
set tw=500

" 80 column marker (gray)
"set colorcolumn=80
"highlight ColorColumn ctermbg=236
highlight ColorColumn ctermbg=grey
call matchadd('ColorColumn', '\%81v', 100)

" wrap lines
set wrap

" Michael Naumann's idea to seach for current selection
" by pressing * or # in visual mode
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" treat long lines as break lines
map j gj
map k gk

" disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" open new tab with current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Specify buffer behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=1
catch
endtry

" return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" |
    \ endif

" remember info about open buffers on close
set viminfo^=%

" mappings for moving between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" make 0 work like it should
map 0 ^

" get rid of trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" wizard mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
    set t_ut=
endif

" ----------------------------------------------------------------------------
" ---- plugins ----
" ----------------------------------------------------------------------------
execute pathogen#infect()

" airline config
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
     let g:airline_symbols = {}
endif
let g:airline_symbols.space = " "
let g:airline_theme='base16_google'
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

" syntastic config
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers=['govet']
let g:syntastic_cpp_compilier = 'clang++'
let g:syntastic_cpp_compilier_options = ' -std=c++14'

" vim-latex-live-preview config
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'gv'
