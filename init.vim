" ------------- initialize vim-plug -------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'tpope/vim-surround'

"Plug 'hoob3rt/lualine.nvim'
"" For icons in statusline.
"Plug 'kyazdani42/nvim-web-devicons'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'pantharshit00/vim-prisma'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'cespare/vim-toml', { 'branch': 'main' }

Plug 'dhruvasagar/vim-zoom'
" set statusline+=%{zoom#statusline()}

" Initialize plugin system
call plug#end()
" ------------- initialize vim-plug end -------------

" So that vim-zoom doesn't complain
set hidden

lua << EOF
vim.g.coq_settings = {
    auto_start = 'shut-up',
    display = {
      pum = { fast_close = false },
    },
    keymap = {
        recommended = true,
        jump_to_mark = '<C-q>'
    }
}

-- require'lualine'.setup{
--   options = { theme  = 'nord' },
--   section_separators = '',
--   component_separators = '',
--   sections = {
--     lualine_a = {'branch'},
--     lualine_b = {'filename'},
--     lualine_b = {},
--     lualine_x = {},
--     lualine_y = {},
--     lualine_z = {'location'}
--   }
-- }

local nvim_lsp = require('lspconfig')
local coq = require('coq')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    autostart = true,
    flags = {
      debounce_text_changes = 150,
    }
  }))
end

-- Override mapping from COQ
local map = vim.api.nvim_set_keymap
map('n', '<C-h>', '', {noremap = true, silent = true})
EOF

" ------------- custom configuration -------------
" vim history is added to your system clipboard and your system clipboard is accessible from vim
set clipboard=unnamed

set mouse=a

syntax enable
" Show line numbers
set number
" Show relative line numbers
set relativenumber
" Disable the annoying bell sound
set belloff=all

colorscheme delek

filetype plugin indent on
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

" set style when cursor is on parentheses
hi MatchParen cterm=bold ctermbg=none ctermfg=red

"set ttimeout
"set ttimeoutlen=100
"set timeoutlen=3000

" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

" Disable backups and swap files
set nobackup
set nowritebackup
set noswapfile

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

" Open terminal on Ctrl+p+Enter
map <C-p><C-M> :sp <bar> :term<C-M>
" Enter Terminal-mode (insert) automatically
autocmd TermOpen * startinsert
" Disables number lines on terminal buffers
autocmd TermOpen * :set nonumber norelativenumber
" Allows to use Ctrl-c on terminal window
autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>

" Enable the reading of a .vimrc file from the current directory
set exrc

" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread

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
" ------------- custom configuration END -------------
