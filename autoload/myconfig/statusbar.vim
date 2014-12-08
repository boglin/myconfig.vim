"
" Helper functions for the lightline status bar
"
function! myconfig#statusbar#MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! myconfig#statusbar#MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! myconfig#statusbar#MyFilename()
  return ('' != myconfig#statusbar#MyReadonly() ? myconfig#statusbar#MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != myconfig#statusbar#MyModified() ? ' ' . myconfig#statusbar#MyModified() : '')
endfunction

function! myconfig#statusbar#MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ''._ : ''
  endif
  return ''
endfunction

function! myconfig#statusbar#MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! myconfig#statusbar#MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! myconfig#statusbar#MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! myconfig#statusbar#MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
endfunction
