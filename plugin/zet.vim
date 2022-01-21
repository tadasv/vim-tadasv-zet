" Note taking stuff

" get path to the script's directory
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:zetNameBin = s:path.'/zet-name.sh'
let s:zetSetupBin = s:path.'/zet-setup.sh'
let s:zetdir = $ZET_DIR

if !isdirectory(s:zetdir)
  echoerr 'Zettelkasten note taking plugin requires ZET_DIR environment variable to be set. This is the location where your notes will be stored.'
  finish
endif


au BufNewFile z/* set filetype=markdown
au BufRead z/* set filetype=markdown

command ZSetup call <SID>setup()
command ZMain call <SID>openRootNote()
command ZRefs call <SID>findReferences()
command Zet call <SID>newNote()
command ZInsert call <SID>createNoteAndInsertReference()

function! s:changeDir() abort
  execute 'lcd '.s:zetdir
endfunction

function! s:newNote() abort
  call <SID>changeDir()
  execute ':e '.system(s:zetNameBin)
endfunction

function! s:createNoteAndInsertReference() abort
  call <SID>changeDir()

  let l:noteRef = substitute(system(s:zetNameBin), '\n\+', '', 'g')
  execute 'normal! a'.l:noteRef
  execute ':split '.l:noteRef
endfunction

function! s:findReferences() abort
  call <SID>changeDir()

  let l:filename = bufname("%")
  execute ':copen'
  execute ':set modifiable'
  execute ':vimgrep /'.escape(l:filename, '/').'/j z/*'
endfunction

function! s:openRootNote() abort
  call <SID>changeDir()

  if !filereadable(s:zetdir.'/z-root')
    echoerr s:zetdir.'/z-root does not exist'
    finish
  endif

  let l:rootNote = s:zetdir.'/'.readfile(s:zetdir.'/z-root')[0]
  execute ':e '.l:rootNote
endfunction

function! s:setup() abort
  call <SID>changeDir()
  call system(s:zetSetupBin)
  call <SID>openRootNote()
endfunction
