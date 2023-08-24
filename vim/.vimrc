"========================================
"	            VIM Setup
"========================================

" We don't need to be vi-compatible..
set nocompatible 

set nomodeline

filetype plugin indent on

" Backup/Undo
set noswapfile
set nobackup
set nowritebackup
set undofile
if has('nvim')
    let g:undodirpath = $HOME."/.config/nvim/undodir"
else
    let g:undodirpath = $HOME."/.vim/undodir"
endif
execute "set undodir=".g:undodirpath
if !isdirectory(g:undodirpath)
    echohl warningmsg
    echo "Warning! undodir (".g:undodirpath.") not found! Creating directory.."
    call mkdir(g:undodirpath, "p")
    echohl none
endif

" Make sure we have unicode
set encoding=utf-8

" Enable relative and absolute line numbers
set number
set relativenumber

" Enable Syntax highlighting
syntax on

" No error bells
set noerrorbells

" Enable incremental search 
set incsearch
" Enable smartcase search
set ignorecase
set smartcase
" Highlight searches
set hlsearch
set hidden

set cmdheight=1

" Scroll already before cursor bottoms out
set scrolloff=10

" Keep 2 columns next to numbers for plugins:
set signcolumn=yes:2

" Setup tabs default (4, expanded)
set tabstop=4 softtabstop=4 shiftwidth=4 " Indent using 4 spaces
set expandtab " Convert Tab to 4 spaces

" Enable Smart indenting
set autoindent
set smartindent

" Do not wrap lines
set nowrap

" Show in-progress command
set showcmd

" Set spelling language to english by default
" Spell-checking is not enabled by default
set spelllang=en_us,de_de

" Make sure colors work + colorscheme
set t_Co=256
colorscheme slate

" Disable folding
set nofoldenable
" By default, fold using indent
" setlocal foldmethod=indent
" augroup Schilk_folding
"     autocmd!
"     " But use syntax folding when appropriate:
"     autocmd FileType c,cpp,java,rust  setlocal foldmethod=syntax
"     " By default, don't fold:
"     autocmd BufRead * normal zR
" augroup END

" Do not auto-continue comments:
set formatoptions-=cr
augroup Schilk_folding
    autocmd!
    " many ftplugins override this....:
    autocmd BufWinEnter * set formatoptions-=cr
augroup END


"========================================
"                 Remaps                    
"========================================

" Set leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" Escape on jk
imap jk <esc>

" Save on leader-w
nnoremap <leader>w :w<CR>

" Save all on leader-W
nnoremap <leader>W :wa<CR>

" Clear highlighting on leader-/
nnoremap <leader>/ :noh<CR>

" Reload current file on leader-R
nnoremap <leader>R :e!<CR>

" Select whole file on leader-a 
" nnoremap <C-a> ggVG
nnoremap <leader>a ggVG

" Spell-checking:
" Toggle on/off
nnoremap <leader>ss :setlocal invspell<CR>
" Ignore current word (add to spellfile)
nnoremap <leader>si zg
" Suggest fixes
nnoremap <leader>sf z=

" Highlight word under curose on leader-h
nnoremap <leader>h mz*`z

" Allow pane control without escaping terminal mode:
tnoremap <C-W><C-W> <C-\><C-n><C-W><C-W>
tnoremap <C-W><C-q> <C-\><C-n><C-W><C-q>
tnoremap <C-W><C-o> <C-\><C-n><C-W><C-o>
tnoremap <C-W><C-s> <C-\><C-n><C-W><C-s>
tnoremap <C-W><C-T> <C-\><C-n><C-W><C-T>
tnoremap <C-W><C-v> <C-\><C-n><C-W><C-v>
tnoremap <C-W><C-x> <C-\><C-n><C-W><C-x>

tnoremap <C-W><C-h> <C-\><C-n><C-W><C-h>
tnoremap <C-W><C-j> <C-\><C-n><C-W><C-j>
tnoremap <C-W><C-k> <C-\><C-n><C-W><C-k>
tnoremap <C-W><C-l> <C-\><C-n><C-W><C-l>



"========================================
"                 Utils                    
"========================================

fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun
command! EmptyRegisters :call EmptyRegisters()

" Simple checkbox checking
function Checkbox_check()
    let l:l=getline('.')
    let l:c=winsaveview()
    if l:l=~?'\[ \]'
        s/\[ \]/[x]/
    elseif l:l=~?'\[[Xx]\]'
        s/\[x\]/[ ]/
    endif
    call winrestview(l:c)
endfunction
nnoremap <leader>x :call Checkbox_check()<CR>
