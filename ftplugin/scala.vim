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
"open test failure
command! F :execute 'mejf(l"fyt:f:l"lyt):silent! :on<cr>:sb <ctrl-r>f<cr>:<ctrl-r>l<cr>:wincmd w<cr>:res 10<cr>`ezz:wincmd W<cr>'
"let @f='mejf(l"fyt:f:l"lyt):silent! :on:sb f:l:wincmd w:res 10`ezz:wincmd W'
