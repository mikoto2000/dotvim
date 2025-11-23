vim9script

var submode = ''

class Mapping
  var lhs: string
  var rhs: string
  def new(lhs: string, rhs: string)
    this.lhs = lhs
    this.rhs = rhs
  enddef
endclass

class Sbmode
  var name: string
  var mappings: dict<Mapping>
  def new(name: string, mappings: dict<Mapping>)
    this.name = name
    this.mappings = mappings
  enddef
endclass

# サブモードごとのマッピング定義
# key: サブモード名
# value: マッピング定義の辞書
#        key: マッピングキー
#        value: Mapping オブジェクト
var submode_mappings = {
  'winsize': Sbmode.new('winsize', {
    '+': Mapping.new('+', ':resize +1<CR>'),
    '-': Mapping.new('-', ':resize -1<CR>'),
    '<': Mapping.new('<', ':vertical resize -1<CR>'),
    '>': Mapping.new('>', ':vertical resize +1<CR>'),
  }),
}

# サブモードに切り替える関数
export def EnterSubmode(modeName: string)
  if has_key(submode_mappings, modeName)
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
  var currentSubmode = submode_mappings[submode]
  while true
    var input = getchar()
    if type(input) != 0 # 数値でない場合
      echo 'exit'
      submode = ''
      break
    endif
    var inputStr = nr2char(input)
    echo inputStr
    if has_key(currentSubmode.mappings, inputStr)
      var mapping = currentSubmode.mappings[inputStr]
      execute mapping.rhs
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

