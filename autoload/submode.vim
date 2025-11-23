vim9script

# サブモードごとのマッピング定義
# key: サブモード名
# value: マッピング定義の辞書
#        key: マッピングキー(lhs)
#        value: マッピング後の定義(rhs)
if !exists('g:submode_mappings')
  g:submode_mappings = {}
endif

var submode = ''

# サブモードに切り替える関数
export def EnterSubmode(modeName: string)
  if has_key(g:submode_mappings, modeName)
    submode = modeName
  else
    throw 'Submode not defined: ' .. modeName
  endif
  call SubmodeLoop()
enddef

# サブモードのメインループ関数
# マッピング定義以外のキーが押されたらサブモードを終了する
def SubmodeLoop()
  if submode == ''
    return
  endif
  var currentSubmode = g:submode_mappings[submode]
  while true
    var input = getchar()
    if type(input) != 0 # 数値でない場合
      submode = ''
      break
    endif
    var inputStr = nr2char(input)
    if has_key(currentSubmode, inputStr)
      execute currentSubmode[inputStr]
    else
      submode = ''
      break
    endif
    redraw
  endwhile
enddef

# サブモードを終了する関数
def ExitSubmode()
  submode = ''
enddef

# 現在のサブモードを取得する関数
def GetCurrentSubmode(): string
  return submode
enddef

