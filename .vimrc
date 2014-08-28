".vimrc

filetype plugin indent on

set autoindent          " Copy indent from current line when starting a new line
set copyindent          " Copy the previous indentation on autoindenting
set linebreak           " Break wrapped lines on words
set cindent             " Indenting for C-like languages
set shiftwidth=4        " An indent is n spaces
set nojoinspaces        " Don't convert spaces to tabs
set shiftround          " Round spaces to nearest shiftwidth multiple
set smarttab            " Indent instead of tab at start of line
set expandtab           " Always uses spaces instead of tabs
set tabstop=4           " A tab is rendered as n spaces
set ruler               " Show the line and column number of the cursor position
set number              " Print the line number in front of each line
set scrolloff=10        " Minimal number of screen lines to keep above and below the cursor
set cursorline          " Highlight the cursor line
set nostartofline       " Don't jump to start of line when paging up/down
set timeoutlen=500      " Set multi-character command time-out
set gdefault            " Makes search/replace global by default
set mouse=a             " Enables the mouse in all modes
set title               " Show file in title bar
set rnu                 " Use relative line numbers
set hlsearch            " Highlight search results
set viminfo='20,\"500   " Remember copy registers after quitting in the .viminfo file
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup            " No backup~ files
set hidden              " Don't ask to save when changing buffers
set noswapfile          " Stop creating bothersome swap files
set lazyredraw          " Don't render every detail when running macros
set nowrap              " No line wrap by default
set ignorecase          " This needs to be enabled to use smartcase
set smartcase           " Use smartcase in searches (and replaces unfortunately)
set noerrorbells        " Disable annoying beeping
set vb t_vb=            " ... continued

" Get rid of GUI noise (toolbar, menus, scrollbars)
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=M



let mapleader=' '

" Clear vimrc augroup so we don't pile up autocmds when reloading the config.
augroup vimrc
    autocmd!
augroup END

" Toggles vim's paste mode; when we want to paste something into vim from a
" different application, turning on paste mode prevents extra whitespace.
set pastetoggle=<F7>

" Clear search result highlighting on press enter
nnoremap <cr> :nohlsearch<cr>

" Get the standard c-backspace behaviour in insert mode
inoremap <c-backspace> <c-w>

" Automatically reload vimrc after saving changes to it
augroup vimrc
    autocmd BufWritePost vimrc source $MYVIMRC
    autocmd BufNewFile,BufRead *.as set filetype=javascript
augroup END

" Ctrl-z in insert mode cancels the insert
inoremap <c-z> <esc>u

" Ctrl+j/k to move around quicker
nnoremap <c-j> 15j
nnoremap <C-k> 15k
vnoremap <c-j> 15j
vnoremap <c-k> 15k

" Map Ctrl+v to paste in insert mode, using the appropriate clipboard
if has('macunix')
    inoremap <c-v> <c-r>"
    cnoremap <c-v> <c-r>"
elseif has('unnamedplus')
    inoremap <c-v> <c-r>+
    cnoremap <c-v> <c-r>+
else
    inoremap <c-v> <c-r>*
    cnoremap <c-v> <c-r>*
endif

" Switch syntax highlighting on when the terminal has colors
if &t_Co > 2 || has('gui_running')
    syntax on
endif

" Automatically delete trailing DOS-returns and whitespace on file open and write
augroup vimrc
    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

" Ignore some subfolders and files which we won't want to edit in vim
let NERDTreeIgnore = ['\.meta$']
set wildignore+=*\\bin\\*,*/bin/*,*\\obj\\*,*/obj/*,*.dll,*.exe,*.pidb,*.meta,node_modules

" Toggle relative and absolute line numbering, Ctrl-n
  function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

:au FocusLost * :set number
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
