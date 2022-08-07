" ------------- initialize vim-plug -------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Initialize plugin system
call plug#end()
" ------------- initialize vim-plug end -------------

syntax enable

" vim history is added to your system clipboard and your system clipboard is accessible from vim
set clipboard=unnamed
" Show line numbers
set number
" Show relative line numbers
set relativenumber
" Disable bell sound
set belloff=all


" Disable backups and swap files
set nobackup
set nowritebackup
set noswapfile

" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab
" auto indenting
set ai
" highligh search terms
set hlsearch
" show search matches as you type
set incsearch
" show the cursor position
set ruler
" Show search results count. It won't show more than 99.
set shortmess-=S

" Easier navigation between splits
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
" Enable the same navigation when for the :terminal window
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e
"
" set style when cursor is on parentheses
hi MatchParen cterm=bold ctermbg=none ctermfg=red

" Open terminal on Ctrl+p+Enter
map <C-p><C-M> :sp <bar> :term<C-M>
" Enter Terminal-mode (insert) automatically
autocmd TermOpen * startinsert
" Disables number lines on terminal buffers
autocmd TermOpen * :set nonumber norelativenumber
" Allows to use Ctrl-c on terminal window
autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>

" Enable backspace
set backspace=indent,eol,start

" Search files with CTRL+f
nnoremap <silent> <C-f> :Files<CR>

" Search in files using \f
nnoremap <silent> <Leader>f :Rg<CR>
" Show file preview and ignore file names when searching in files using \f
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Disable CTRL+z (quits vim)
nnoremap <C-z> <nop>

