vim9script

export def HighlightCrsorWord()
  var word = expand('<cword>')
  if word ==# ''
    if exists('w:cursorword_matchid')
      try
        matchdelete(w:cursorword_matchid)
      catch
      endtry
      unlet w:cursorword_matchid
    endif
    return
  endif

  if exists('w:cursorword_matchid')
    try
      matchdelete(w:cursorword_matchid)
    catch
    endtry
  endif

  # パターンを作成
  var pat = '\V\<'
  pat ..= escape(word, '\')
  pat ..= '\>'

  # 新しい match ID を保存
  w:cursorword_matchid = matchadd('CursorWord', pat)
enddef
