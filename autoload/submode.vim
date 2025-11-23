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
  # サブモード中でない場合は終了
  if submode == ''
    return
  endif

  # 現在のサブモードのマッピング定義を取得
  var currentSubmode = g:submode_mappings[submode]

  # サブモードのメインループ
  while true
    # キー入力を待機
    var input = getchar()
    if type(input) != 0 # 数値でない場合
      submode = ''
      break
    endif

    # 入力キーがマッピング定義に存在するか確認
    var inputStr = nr2char(input)
    if has_key(currentSubmode, inputStr)
      # マッピング定義に従ってコマンドを実行
      execute currentSubmode[inputStr]
    else
      # 定義にないキーが押された場合はサブモードを終了
      submode = ''
      break
    endif

    # 再描画
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

