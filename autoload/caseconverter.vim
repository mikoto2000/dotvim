vim9script

# カーソル下の単語をアッパーキャメルケースに変換する関数
# スネークケースの単語を変換できる
def ToUpperCamelCase()
  var word = expand('<cword>')
  var parts = split(word, '_\|-\| ')
  for i in range(len(parts))
    parts[i] = toupper(strpart(parts[i], 0, 1)) .. strpart(parts[i], 1)
  endfor
  var camelCaseWord = join(parts, '')
  execute 'normal! ciw' .. camelCaseWord
enddef

# カーソル下の単語をロウワーキャメルケースに変換する関数
# スネークケースの単語を変換できる
def ToLowerCamelCase()
  var word = expand('<cword>')
  var parts = split(word, '_\|-\| ')
  for i in range(len(parts))
    if i == 0
      parts[i] = tolower(strpart(parts[i], 0, 1)) .. strpart(parts[i], 1)
    else
      parts[i] = toupper(strpart(parts[i], 0, 1)) .. strpart(parts[i], 1)
    endif
  endfor
  var camelCaseWord = join(parts, '')
  execute 'normal! ciw' .. camelCaseWord
enddef


# カーソル下の単語をアッパースネークケースに変換する関数
# キャメルケースの単語も変換できる
export def ToUpperSnakeCase()
    var word = expand('<cword>')
    var result = ''
    for i in range(len(word))
        var char = strpart(word, i, 1)
        if char =~# '\u' && i != 0
            result = result .. '_'
        endif
        result = result .. toupper(char)
    endfor
    execute 'normal! ciw' .. result
enddef

# カーソル下の単語をロウワースネークケースに変換する関数
# キャメルケースの単語も変換できる
export def ToLowerSnakeCase()
    var word = expand('<cword>')
    var result = ''
    for i in range(len(word))
        var char = strpart(word, i, 1)
        if char =~# '\u' && i != 0
            result = result .. '_'
        endif
        result = result .. tolower(char)
    endfor
    execute 'normal! ciw' .. result
enddef
