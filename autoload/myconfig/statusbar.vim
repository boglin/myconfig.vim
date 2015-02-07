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

function! myconfig#statusbar#MyTabFilename(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnum = buflist[winnr - 1]
  let bufname = expand('#'.bufnum.':t')
  let buffullname = expand('#'.bufnum.':p')
  let buffullnames = []
  let bufnames = []
  for i in range(1, tabpagenr('$'))
    if i != a:n
      let num = tabpagebuflist(i)[tabpagewinnr(i) - 1]
      call add(buffullnames, expand('#' . num . ':p'))
      call add(bufnames, expand('#' . num . ':t'))
    endif
  endfor
  let i = index(bufnames, bufname)
  if strlen(bufname) && i >= 0 && buffullnames[i] != buffullname
    return substitute(buffullname, '.*/\([^/]\+/\)', '\1', '')
  else
    return strlen(bufname) ? bufname : '[No Name]'
  endif
endfunction


let s:counter = 0
function! myconfig#statusbar#MyTabTitle()
  let s:counter = s:counter + 1
  return strftime("%a %H:%M")
endfunction

