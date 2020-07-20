" Turn on syntax highlighting
syntax on

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Mouse support
set mouse=a

" Show whitespace
set list listchars=tab:»·,trail:·

" More powerful backspace
set backspace=indent,eol,start


" Indent Python nicely
au BufNewFile,BufRead *.py
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=79  |
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix
