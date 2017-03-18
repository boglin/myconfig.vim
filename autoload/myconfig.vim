func! myconfig#basics() abort

  " We don't need to be compatible with vi
  set nocompatible

  " Enable per-filetype specialisations
  filetype plugin on

  set encoding=utf-8 " Necessary to show Unicode glyphs

  " Tabs
  set tabstop=4       " number of visual spaces per TAB
  set shiftwidth=4    " 
  set softtabstop=4   " number of spaces in tab when editing
  set noexpandtab     " Don't expand tabs with spaces by default

endf


func! myconfig#development() abort

  packadd nerdtree
  packadd gundo.vim

  " vim-fugitive (commands only available in a git worktree)
  packadd vim-fugitive

 " Syntax/Lint Validation
 packadd validator.vim

 " Choose which validator to check each filetype:
 let g:validator_python_checkers = ['flake8']
 let g:validator_option = {
       \    'args': {
       \      'python': {'flake8': '--max-line-length=120'}
       \    }
       \ }

 " -- Available options --
 "" To customize error message:
 " let g:validator_error_msg_format = "[ ● %d/%d issues ]"
 "" To auto open quickfix window:
 " let g:validator_auto_open_quickfix = 1
 "" Mapping types
 " let g:validator_filetype_map = {"python.django": "python"}

endf


func! myconfig#behaviour() abort

  set clipboard=exclude:.*

  set hlsearch        " Highlight search results
  set incsearch       " Perform search as the search-term is entered

  set wildmenu        " Show options for command completion
  set lazyredraw      " redraw only when we need to.

  set textwidth=80

endf


func! myconfig#navigation() abort

  " Natural window navigation (ctrl-h/j/k/l moves between splits)
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  " Resize windows
  " TODO: Flip direction if in max(window)
  nnoremap <C-Up> <C-W>+
  nnoremap <C-Down> <C-W>-
  nnoremap <C-Left> <C-W><
  nnoremap <C-Right> <C-W>>

  " Tabs
  nnoremap <silent> <S-Left> :tabp<CR>
  nnoremap <silent> <S-Right> :tabn<CR>

  " Move tab left/right
  nnoremap <C-S-T> :tab new<CR>
  nnoremap <C-S-Left> :exec myconfig#navigation#MoveTabLeft()<CR>
  nnoremap <C-S-Right> :exec myconfig#navigation#MoveTabRight()<CR>

endf


func! myconfig#look() abort

  " Add plugins
  packadd vim-colors-solarized

  " Set up the look of the editor
  syntax enable
  set background=dark
  colorscheme solarized

  " Highlight matching braces etc
  set showmatch

  highlight MyLineTooLongMarker ctermbg=magenta guibg=Magenta
  call matchadd('MyLineTooLongMarker', '\%80v', 100)

  " Leave some context when scrolling
  set scrolloff=2

  " Toggle line numbers
  nnoremap <silent> <F2>  :set number!<CR>

  " Reveal codes
  set listchars=trail:·,precedes:«,extends:»,tab:»\ ,eol:¶
  nnoremap <silent> <F11> :set list!<CR>

endf

func! myconfig#statusbar() abort

  " Always show the status and tab bars
  set laststatus=2
  set showtabline=2

  " Load and configure lightline
  packadd lightline.vim

  let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': { 'c': 'NORMAL' },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'tabline': {
        \   'left': [ [ 'tabs' ] ],
        \   'right': [ [ 'time' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'myconfig#statusbar#MyModified',
        \   'readonly': 'myconfig#statusbar#MyReadonly',
        \   'fugitive': 'myconfig#statusbar#MyFugitive',
        \   'filename': 'myconfig#statusbar#MyFilename',
        \   'fileformat': 'myconfig#statusbar#MyFileformat',
        \   'filetype': 'myconfig#statusbar#MyFiletype',
        \   'fileencoding': 'myconfig#statusbar#MyFileencoding',
        \   'mode': 'myconfig#statusbar#MyMode',
        \   'time': 'myconfig#statusbar#MyTabTitle',
        \ },
        \ 'tab_component_function': {
        \   'filename': 'myconfig#statusbar#MyTabFilename',
        \ },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \ }

  set noshowmode

  " Cause the buffer to be updated on cursor move
  autocmd CursorHold,CursorHoldI * :let &ro = &ro

  " Something similar for lightline?
  " if (exists('g:loaded_airline') && g:loaded_airline && exists('g:loaded_validator_plugin') && g:loaded_validator_plugin)
  "     call airline#parts#define_function('validator', 'validator#get_status_string')
  "     let g:airline_section_error = airline#section#create(['validator'])
  " endif

endf

