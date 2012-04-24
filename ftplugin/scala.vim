setlocal textwidth=140
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal expandtab
setlocal formatoptions=cqrol
setlocal nomodeline

" These maps help navigate SBT output running in ConqueTerm
"
" go to error/warning/test failure
command! G :execute ':normal G5k?^\d\+\. <cr>/^\(\[\(error\|warn\)\] \zs\/[^:]\+:\d\+:\|\[info\] -.*[*][*][*] FAILED [*][*][*]\)<cr>'


"let @e='G5k?^\d\+\. /^\(\[\(error\|warn\)\] \zs\/[^:]\+:\d\+:\|\[info\] -.*[*][*][*] FAILED [*][*][*]\)'
" open error/warning
"let @o='me:silent! :onFw:res 10`ezzW'
command! O :execute ':normal me:silent! :on<cr>:wincmd F<cr>:wincmd w<cr>:res 10<cr>`ezz:wincmd W<cr>'

" I wish I had a better way
command! GG :execute ':normal G5k?^\d\+\. <cr>/^\(\[\(error\|warn\)\] \zs\/[^:]\+:\d\+:\|\[info\] -.*[*][*][*] FAILED [*][*][*]\)<cr>me:silent! :on<cr>:wincmd F<cr>:wincmd w<cr>:res 10<cr>`ezz:wincmd W<cr>'

function! scala#go_to_error()
  execute ':normal G5k'
  execute ':normal ?^\d\+\. '
  execute ':normal /^\(\[\(error\|warn\)\] \zs\/[^:]\+:\d\+:\|\[info\] -.*[*][*][*] FAILED [*][*][*]\)<cr>'
  execute ':normal me'
  silent! :on "Close all other windows so when we open a window below, we don't get a duplicate
  wincmd F " Open the window with the error
  wincmd b " Back to sbt
  res 10
  execute ":normal `ezz"
  wincmd W " Back to the otehr window
endfunction 

function! scala#update_and_go()
  wincmd b " Go to sbt, assuming sbt is running in the bottom window.
  call conque_term#get_instance().read()
  call scala#go_to_error()
endfunction 

"Assuming sbt is in the bottom window, goes to sbt and enters insert mode so that it will update
nnoremap <leader>b b:res 10<cr>i

" Why don't you work?
"command! GGG :call scala#update_and_go()
"command! GG :call scala#go_to_error()

"open test failure
command! F :execute ':normal mejf(l"fyt:f:l"lyt):silent! :on<cr>:sb <ctrl-r>f<cr>:<ctrl-r>l<cr>:wincmd w<cr>:res 10<cr>`ezz:wincmd W<cr>'
"let @f='mejf(l"fyt:f:l"lyt):silent! :on:sb f:l:wincmd w:res 10`ezz:wincmd W'
