func! myconfig#basics() abort

  " Enable per-filetype specialisations
  filetype on 

  set encoding=utf-8 " Necessary to show Unicode glyphs

  " Tabs
  set tabstop=4       " number of visual spaces per TAB
  set softtabstop=4   " number of spaces in tab when editing
  set noexpandtab     " Don't expand tabs with spaces by default

endf


func! myconfig#behaviour() abort

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
  nnoremap <S-Up> <C-W>+
  nnoremap <S-Down> <C-W>-
  nnoremap <S-Left> <C-W><
  nnoremap <S-Right> <C-W>>

  " Tabs
  nnoremap <silent> <C-Left> :tabn<CR>
  nnoremap <silent> <C-Right> :tabp<CR>
" Move tab left/right
"  nnoremap <silent> <C-S-Right> :tabm<CR>
"  nnoremap <silent> <C-S-Left> :tabm<CR>


endf


func! myconfig#look() abort

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

  let g:lightline = {
        \ 'colorscheme': 'solarized_dark',
        \ 'mode_map': { 'c': 'NORMAL' },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
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
        \ },
        \ 'tab_component_function': {
        \   'filename': 'myconfig#statusbar#MyTabFilename',
        \ },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \ }

  set noshowmode

endf

