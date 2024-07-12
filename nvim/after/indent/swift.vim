" Vim indent file
" Language:	Swift
" Maintainer:	Andrew Kong <kong4ndrew@gmail.com>
" Last Change: 
" Disclaimer: Likely doesn't cover all indenting situations

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Only define the function once.
if exists("*GetSwiftIndent")
  finish
endif

let b:undo_indent = "setlocal autoindent< indentexpr< indentkeys<"

setlocal indentexpr=GetSwiftIndent()
setlocal indentkeys+=
setlocal autoindent

function! GetSwiftIndent()
    let ignorecase_save = &ignorecase
  try
    let &ignorecase = 0
    return GetSwiftIndentIntern()
  finally
    let &ignorecase = ignorecase_save
  endtry
endfunction

function! GetSwiftIndentIntern()
  " Find a non-blank line above the current line.
  let prevlnum = prevnonblank(v:lnum - 1)

  " At the start of the file, use zero indent.
  if prevlnum == 0
    return 0
  endif

  " In the previous line, if the count of '{', '(', and '[' is more than the
  " count of '}', ')', and ']' AND the current line isn't a comment, add a
  " 'shiftwidth' to the current line. If the counts are the same, leave the
  " indent unchanged.
  let ind = indent(prevlnum)
  let prevline = getline(prevlnum)
  let openScopes = filter(copy(prevline), 'v:val == "{" || v:val == "(" || v:val == "["')
  let closeScopes = filter(copy(prevline), 'v:val == "}" || v:val == ")" || v:val == "]"')
  let didMatchComment = match(getline(v:lnum), '^\s*//') != -1
  let didMatchBlockComment = searchpairpos('/\*', '', '\*/', 'bcn')[0] != 0
  let didMatchOpen = match(prevline, '\%({\|(\|[\)') >= 0

  if didMatchOpen != 0 && didMatchComment == 0 && didMatchBlockComment == 0
    if len(openScopes) > len(closeScopes)
      let ind += shiftwidth()
    endif
  endif

  " If the current line matches any (or no) whitespace and a '}' or ')' or ']'
  " AND isn't a comment, subtract a 'shiftwidth' from the current line.
  " Otherwise, if the count of '}', ')', and ']' is more than the count of '{',
  " '(', and '[', subtract a 'shiftwidth' from the current line.
  let didMatchClose = match(prevline, '^\s*\%(}\|)\|]\)') >= 0
  let didLnumMatchClose = match(getline(v:lnum), '^\s*\%(}\|)\|]\)') >= 0

  if didLnumMatchClose == 1 && didMatchComment == 0 && didMatchBlockComment == 0
    let ind -= shiftwidth()
  elseif didMatchClose == 0 && didMatchComment == 0 && didMatchBlockComment == 0
    if len(openScopes) < len(closeScopes)
      let ind -= shiftwidth()
    endif
  endif

  return ind
endfunction

