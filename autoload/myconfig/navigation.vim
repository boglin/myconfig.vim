

function! myconfig#navigation#MoveTabLeft()
  let l:tabNo = (tabpagenr() - 1) - 1
  exec 'tabm '.l:tabNo
endfunction

function! myconfig#navigation#MoveTabRight()
  let l:tabNo = (tabpagenr() - 1) + 1
  exec 'tabm '.l:tabNo
endfunction
