"-------------------------
" GENERAL SETTINGS
"-------------------------
set history=10000
" disable motion by mouse
set mouse=
" set clipboard^=unnamed,unnamedplus
set noswapfile


"-------------------------
" PLUGINS
"-------------------------
" automatic installation of vim-plug itself
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
    Plug 'tpope/vim-surround'

    " dependency for language plugins
    Plug 'thinca/vim-quickrun'
    Plug 'Shougo/vimproc'
    Plug 'Shougo/unite.vim'
    Plug 'osyo-manga/shabadou.vim'
    Plug 'osyo-manga/vim-watchdogs'
    " Plug 'scrooloose/nerdtree'
    " Plug 'jistr/vim-nerdtree-tabs'

    " C++
    " Plug 'Valloric/YouCompleteMe', {'for': 'cpp', 'do': function('BuildYCM')}
    Plug 'Valloric/YouCompleteMe', {'for': 'cpp'}
    autocmd! User YouCompleteMe
    \ if !has('vim_starting') |
        \ call youcompleteme#Enable() |
    \ endif
    Plug 'rdnetto/YCM-Generator', {'branch': 'stable', 'for': 'cpp'}
    Plug 'osyo-manga/unite-boost-online-doc' , {'for': 'cpp'}

    " Python

    " R

    " Documentation
    " Plug 'rhysd/devdocs.vim'
    Plug 'KabbAmine/zeavim.vim', {'on': [
            \   'Zeavim', 'Docset',
            \   '<Plug>Zeavim',
            \   '<Plug>ZVVisSelection',
            \   '<Plug>ZVKeyDocset',
            \   '<Plug>ZVMotion'
            \ ]}


call plug#end()


"-------------------------
" PLUGIN SETTINGS
"-------------------------
""""" vim-trailing-whitespace
" erase white space at the end of the line
augroup space
    autocmd!
    autocmd BufWritePre * :FixWhitespace
augroup END

""""" lexima.vim
" parentheses
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

""""" watchdogs
" needed by YouCompleteMe
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
inoremap <silent> kk <ESC>
inoremap <silent> hh <ESC>
nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" copy / cut to system clipboard
nnoremap <Space>y "+y
nnoremap <Space>d "+d
nnoremap <Space>p "+p
nnoremap <Space>P "+P
vnoremap <Space>y "+y
vnoremap <Space>d "+d
vnoremap <Space>p "+p
vnoremap <Space>P "+P
vnoremap <Space>x "+x
" comment / uncomment
nmap ,c <Plug>(caw:hatpos:toggle)
vmap ,c <Plug>(caw:hatpos:toggle)
" reset search highlight
nnoremap <Esc><Esc> :noh<CR>
" do not use ex mode
nnoremap Q <Nop>

""""" vim-tmux-navigator
" seamless pane moving between vim and tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

""""" caw.vim
" comment out line by typing ,c

""""" vim-surround
" surround selected text by typing S", S', S{, S<b>, etc.
" unsurround text by typing ds', etc.
" change surrounding by typing cs', etc.

""""" YouCompleteMe
" completion by C-p, selection by C-n, C-p, choosing by C-y, Enter

""""" cppman
" search by typing shift-k
" http://ja.stackoverflow.com/questions/33212
command! -nargs=+ Cppman silent! call system("/home/tak0kada/dotfiles/neovim/plugins/cppman/tmux-cppman " . expand(<q-args>))
autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
autocmd FileType cpp vnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>

""""" zeavim.vim
" search for document out side of vim, in the stand alone application zeal
nmap gz <Plug>Zeavim           " <leader>z (NORMAL mode)
vmap gz <Plug>ZVVisSelection   " <leader>z (VISUAL mode)
" nmap gzz <Plug>ZVMotion          " gz{motion} (NORMAL mode)
" nmap gZ <Plug>ZVKeyDocset       " <leader><leader>z

""""" devdocs.vim
" search for document onside of vim, in the webbrowser
" autocmd Filetype nmap K <Plug>(devdocs-under-cursor)


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
set number
" show cursor position(automatically enabled by lightline)
set ruler
" set cursorline

set background=dark
colorscheme kalisi
" colorscheme hybrid
" colorscheme molokai
" colorscheme solarized8_dark_low

set tabstop=8 shiftwidth=4 expandtab smartindent
" print line at 80th caracter from left
set colorcolumn=80

" config used by vim-indent-guides
" draw line to visualize indent
let g:indent_guides_enable_on_vim_startup = 1
" draw guide at 1st character
let g:indent_guides_start_level = 1
" guide width
let g:indent_guides_guide_size = 1
" turn off default color setting
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

" lightline print information at the bottom low
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
