setlocal textwidth=140
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal expandtab
setlocal formatoptions=cqrol

" The original version of this function was lifted from https://github.com/derekwyatt/vim-config/blob/master/ftplugin/scala.vim
if !exists("*s:CodeOrTestFile")
  function! s:CodeOrTestFile(precmd)
          let current = expand('%:p')
          let other = current
          if current =~ "/src/main/"
                  let other = substitute(current, "/main/", "/test/", "")
                  let other = substitute(other, ".scala$", "Test.scala", "")
          elseif current =~ "/src/test/"
                  let other = substitute(current, "/test/", "/main/", "")
                  let other = substitute(other, "Test.scala$", ".scala", "")
          elseif current =~ "/src/it/"
                  let other = substitute(current, "/it/", "/main/", "")
                  let other = substitute(other, "Test.scala$", ".scala", "")
    elseif current =~ "/app/model/"
                  let other = substitute(current, "/app/model/", "/test/", "")
                  let other = substitute(other, ".scala$", "Test.scala", "")
    elseif current =~ "/app/controllers/"
                  let other = substitute(current, "/app/", "/test/scala/", "")
                  let other = substitute(other, ".scala$", "Test.scala", "")
          elseif current =~ "/test/scala/controllers/"
                  let other = substitute(current, "/test/scala/", "/app/", "")
                  let other = substitute(other, "Test.scala$", ".scala", "")
          elseif current =~ "/test/"
                  let other = substitute(current, "/test/", "/app/model/", "")
                  let other = substitute(other, "Test.scala$", ".scala", "")
          endif
    if &switchbuf =~ "^use"
      let i = 1
      let bufnum = winbufnr(i)
      while bufnum != -1
        let filename = fnamemodify(bufname(bufnum), ':p')
        if filename == other
          execute ":sbuffer " . filename
          return
        endif
        let i += 1
        let bufnum = winbufnr(i)
      endwhile
    endif
    if other != ''
      if strlen(a:precmd) != 0
        execute a:precmd
      endif
      execute 'edit ' . fnameescape(other)
    else
      echoerr "Alternate has evaluated to nothing."
    endif
  endfunction
endif

" https://github.com/derekwyatt/vim-config/blob/master/ftplugin/scala.vim has
" a bunch more mappings
command! -buffer ScalaSwitchHere       :call s:CodeOrTestFile('')
command! -buffer ScalaSwitchSplitAbove :call s:CodeOrTestFile('let b:cursb=&sb | set nosb | split | wincmd k | if b:cursb | set sb | endif | unlet b:cursb')

if has('gui_running')
  nnoremap <buffer> <silent> <A-t> :ScalaSwitchHere<cr>
  nnoremap <buffer> <silent> <A-r> :ScalaSwitchSplitAbove<cr>
else 
  nnoremap <buffer> <silent> ^[t :ScalaSwitchHere<cr>
  nnoremap <buffer> <silent> ^[r :ScalaSwitchSplitAbove<cr>
endif
