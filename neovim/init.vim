"-------------------------
" GENERAL SETTINGS
"-------------------------
set nocompatible
set history=10000
set mouse=
" set clipboard^=unnamed,unnamedplus
" set noswapfile


"-------------------------
" PLUGINS
"-------------------------
" automatic installation of vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" post-install function for YouCommpleteMe
" function! BuildYCM(info)
"   " info is a dictionary with 3 fields
"   " - name:   name of the plugin
"   " - status: 'installed', 'updated', or 'unchanged'
"   " - force:  set on PlugInstall! or PlugUpdate!
"   if a:info.status == 'installed' || a:info.force
"     !./install.py --all
"   endif
" endfunction

call plug#begin('~/.config/nvim/plugged')
    " :PlugInstall -> install plugins
    " :PlugUpdate -> update plugins
    " :PlugUpgrade -> update vim-plug itself

    " appearance
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'freeo/vim-kalisi'
    Plug 'cocopon/lightline-hybrid.vim'
    Plug 'itchyny/lightline.vim'
    " Plug 'w0ng/vim-hybrid'
    " Plug 'tomasr/molokai'
    " Plug 'lifepillar/vim-solarized8'

    " utilities
    Plug 'https://github.com/vim-scripts/fcitx.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'cohama/lexima.vim'
    Plug 'tyru/caw.vim'
    Plug 'thinca/vim-quickrun'
    Plug 'Shougo/vimproc'
    Plug 'Shougo/unite.vim'
    Plug 'osyo-manga/shabadou.vim'
    Plug 'osyo-manga/vim-watchdogs'
    " Plug 'scrooloose/nerdtree'
    " Plug 'jistr/vim-nerdtree-tabs'

    " c++
    " Plug 'Valloric/YouCompleteMe', {'for': 'cpp', 'do': function('BuildYCM')}
    Plug 'Valloric/YouCompleteMe', {'for': 'cpp'}
    autocmd! User YouCompleteMe
    \ if !has('vim_starting') |
        \ call youcompleteme#Enable() |
    \ endif
    Plug 'rdnetto/YCM-Generator', {'branch': 'stable', 'for': 'cpp'}
    Plug 'osyo-manga/unite-boost-online-doc' , {'for': 'cpp'}

call plug#end()


"-------------------------
" PLUGIN SETTINGS
"-------------------------
""""" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

""""" vim-trailing-whitespace
augroup space
    autocmd!
    autocmd BufWritePre * :FixWhitespace
augroup END

""""" lexima.vim
let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1

""""" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/dotfiles/neovim/plugins/YouCompleteMe/ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion=1

""""" cppman
augroup cppmanref
    autocmd VimEnter * call system("cppman -s cppreference.com")
    autocmd VimLeave * call system("cppman -s cplusplus.com")
augroup END

autocmd FileType cpp set keywordprg=cppman
command! -nargs=+ Cppman silent! call system("tmux split-window -bh cppman " . expand(<q-args>))
autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
autocmd FileType cpp vnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>

""""" code check
if !exists("g:quickrun_config")
   let g:quickrun_config = {}
endif
let g:quickrun_config["watchdogs_checker/_"] = {
   \ "outputter/quickfix/open_cmd" : "",
   \ }


"-------------------------
" KEY MAPPINGS
"-------------------------
let mapleader = "\<Space>"
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> <ESC>
nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" copy / cut to system clipboard
nnoremap <Space>y "+y
vnoremap <Space>y "+y
nnoremap <Space>d "+d
vnoremap <Space>d "+d
vnoremap <Space>x "+x
nnoremap <Space>p "+p
vnoremap <Space>p "+p
" comment / uncomment
nmap ,c <Plug>(caw:hatpos:toggle)
vmap ,c <Plug>(caw:hatpos:toggle)
" clear search highlight
nnoremap <Esc><Esc> :noh<CR>
" do not use ex mode
nnoremap Q <Nop>


"-------------------------
" SEARCH
"-------------------------
set incsearch
set hlsearch
set smartcase
set ignorecase
set showmatch


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
    hi IndentGuidesOdd ctermbg=236
    hi IndentGuidesEven ctermbg=237
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

"cursor position does not shift even if there are characters such as "□" or "○"
" if exists('&ambiwidth')
"     set ambiwidth=double
" endif

set guifont=Ricty\ 10
set laststatus=2
set noshowmode
let g:lightline = {
    \'colorscheme': 'solarized',
    \'component': {
        \'readonly': '%{&readonly?"":""}',
        \},
	\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \}
