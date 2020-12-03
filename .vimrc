"
" ~/.vimrc
"

" Plugins
call plug#begin('~/.vim/plugged')

" Plug 'NLKNguyen/papercolor-theme'
" Plug 'Rigellute/shades-of-purple.vim'
" Plug 'dracula/vim'
" Plug 'junegunn/goyo.vim'
" Plug 'lifepillar/vim-solarized8'
" Plug 'morhetz/gruvbox'
" Plug 'nightsense/cosmic_latte'
" Plug 'nightsense/seabird'
" Plug 'nightsense/snow'
" Plug 'sainnhe/forest-night'
" Plug 'tomasr/molokai'
Plug 'bignimbus/pop-punk.vim'
Plug 'itchyny/lightline.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

" Lightline colorscheme. We don't need to show mode anymore too.
" let g:shades_of_purple_lightline = 1
let g:lightline = {
	\ 'colorscheme': 'pop_punk',
	\ 'active': {
	\   'right': [ [ 'lineinfo' ],
	\              [ 'percent' ],
	\              [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ }
set noshowmode


" Colour-scheme specifics
let g:solarized_italics = 0
let g:solarized_termcolors=256
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_termcolors = 256
let g:gruvbox_number_column = "dark0"
let g:gruvbox_vert_split = "dark0"

" Colour setup
set t_Co=256
set termguicolors
set background=dark
colorscheme pop-punk

" Line numbers.
set tabstop=4
set shiftwidth=4
set number relativenumber
set ruler

" Fast tab changing.
nnoremap <C-Left>  :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Delete trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Make sp/vs work a bit nicer.
set splitbelow splitright

" Show last command
set showcmd

" Set status line to always show.
set laststatus=2

" Use fast connection
set ttyfast
set lazyredraw

" Better indentation.
set softtabstop=0 noexpandtab
set smarttab
set smartindent

" Ignore case in searches unless capital is put in.
set ignorecase
set smartcase

" Don't need to wait for visual mode to exit!.
set timeoutlen=1000 ttimeoutlen=0

" Tab completion when typing files, commands, etc.
set wildmenu
set wildmode=longest,full

" Spell-check macro.
nnoremap <F6> :setlocal spell! spelllang=en_au<CR>

" 72 column fold macro
nnoremap <F7> :norm ggVG<CR>:! fold -w 72 -s<CR>

" Copy entire file to clipboard.
nnoremap <F10> ggVG"yy <Bar> :call system('xclip -selection clipboard', @y)<CR>

" Make sure files are read as needed.
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile ~/.config/mutt/* set filetype=neomuttrc

" Markdown macros.
autocmd BufRead,BufNewFile *.md setlocal spell! spelllang=en_au

" Set netrw to always tree, no banner, and open in vertical splits.
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 10

" Enable syntax highlighting.
syn off | syn on

" Title string
auto BufEnter * let &titlestring = "nvim " . expand("%:t")
set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

" Change tabstop to 2 spaces for JavaScript and HTML files.
augroup tabstopmodify
	autocmd!
	autocmd BufRead,BufNewFile *.js,*.html,*.ts set tabstop=2
	autocmd BufRead,BufNewFile *.js,*.html,*.ts set shiftwidth=2
augroup END

" Save folds for *.ms (and .tex) files.
augroup MSFolding
    autocmd BufWrite,VimLeave *.ms mkview
    autocmd BufRead           *.ms silent loadview
    autocmd BufWrite,VimLeave *.tex mkview
    autocmd BufRead           *.tex silent loadview
augroup END

" Stop auto commenting on //.
set comments-=://
set comments+=f://

" Fix tmux CTRL keys.
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

