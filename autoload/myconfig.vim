func! myconfig#basics() abort

  " Enable per-filetype specialisations
  filetype on 

endf

func! myconfig#look() abort

  " Set up the look of the editor
  syntax enable
  set background=dark
  colorscheme solarized

endf

func! myconfig#statusbar() abort

  " Set the status bar
  set laststatus=2
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
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \ }


endf
