"-------------------------
" PLUGINS
"-------------------------
" Automatic Installation of vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
    " appearance
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'freeo/vim-kalisi'
    " Plug 'w0ng/vim-hybrid'
    " Plug 'tomasr/molokai'
    " Plug 'lifepillar/vim-solarized8'
    Plug 'cocopon/lightline-hybrid.vim'
    Plug 'itchyny/lightline.vim'

    " utilities
    Plug 'https://github.com/vim-scripts/fcitx.vim'
    " Plug 'scrooloose/nerdtree'
    " Plug 'jistr/vim-nerdtree-tabs'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'cohama/lexima.vim'
    Plug 'tyru/caw.vim'
    Plug 'thinca/vim-quickrun'
    Plug 'Shougo/vimproc'
    Plug 'osyo-manga/shabadou.vim'
    Plug 'osyo-manga/vim-watchdogs'

    " c++
    Plug 'Valloric/YouCompleteMe', {'for': 'cpp'}
    autocmd! User YouCompleteMe
    \ if !has('vim_starting') |
        \ call youcompleteme#Enable() |
    \ endif
    Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}

call plug#end()


"-------------------------
" GENERAL SETTINGS
"-------------------------
set history=10000
set mouse=
set clipboard^=unnamed,unnamedplus
"set noswapfile

" vim-trailing-whitespace
augroup space
    autocmd!
    autocmd BufWritePre * :FixWhitespace
augroup END

" lexima.vim
let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/dotfiles/neovim/plugins/YouCompleteMe/ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-p>'

" code check
 if !exists("g:quickrun_config")
    let g:quickrun_config = {}
 endif
 let g:quickrun_config["watchdogs_checker/_"] = {
    \ "outputter/quickfix/open_cmd" : "",
    \ }


"-------------------------
" KEY MAPPINGS
"-------------------------
let mapleader = ','
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> <ESC>
nnoremap ; :
nnoremap j gj
nnoremap k gk
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)


"-------------------------
" SEARCH
"-------------------------
set incsearch
set hlsearch
set smartcase
set ignorecase
set showmatch
" set wildmode=longest,full
" set wildchar=<C-Z>


"-------------------------
" APPEARANCE
"-------------------------
syntax on
set number ruler
" set cursorline

set background=dark
colorscheme kalisi
" colorscheme hybrid
" colorscheme molokai
" colorscheme solarized8_dark_low

set tabstop=8 shiftwidth=4 expandtab smartindent
set colorcolumn=80
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
if g:colors_name == 'kalisi'
    hi IndentGuidesOdd ctermbg=239
    hi IndentGuidesEven ctermbg=240
    hi ColorColumn ctermbg=235
    " make background transprant
    if !has('gui_running')
        augroup seiya
            autocmd!
            autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none
            autocmd VimEnter,ColorScheme * highlight LineNr ctermbg=none
            autocmd VimEnter,ColorScheme * highlight SignColumn ctermbg=none
            autocmd VimEnter,ColorScheme * highlight VertSplit ctermbg=none
            autocmd VimEnter,ColorScheme * highlight NonText ctermbg=none
        augroup END
    endif
" elseif g:colors_name == 'hybrid'
"    hi IndentGuidesOdd ctermbg=236
"    hi IndentGuidesEven ctermbg=237
endif

"cursor position does not shift even if there are "□" or "○" characters
if exists('&ambiwidth')
    set ambiwidth=double
endif

set laststatus=2
set noshowmode
let g:lightline = {
    \'colorscheme': 'solarized',
    \'component': {
        \'readonly': '%{&readonly?"⭤":""}',
        \}
    \}
