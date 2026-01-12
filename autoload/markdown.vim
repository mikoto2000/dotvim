vim9script

# リストアイテム
class ListItem
  var level: number
  var content: string

  def new(level: number, content: string)
    this.level = level
    this.content = content
  enddef
endclass

# テーブルリスト
class TableList
  var items: list<ListItem>

  def new()
    this.items = []
  enddef

  def AddItem(item: ListItem)
    if item.level > 2
      throw 'Only two levels of nesting are supported'
    endif
    this.items += [item]
  enddef

  def GetHeaders(): list<string>
    var headers: list<string> = []
    var started = false
    for item in this.items
      if item.level == 1
        if started
          break
        else
        started = true
        endif
      endif
      if item.level == 1
        headers += [item.content]
      endif
    endfor
    return headers
  enddef
endclass

# リストアイテムパーサー
export def ParseListItem(line: string): ListItem
  var trimedLine = trim(line)
  var content = matchlist(trimedLine, '\v^(\*+)\s*(.*)$')
  echomsg content
  if len(content) == 0
    throw 'Invalid list item format'
  endif
  var level = len(content[1])
  return ListItem.new(level, content[2])
enddef

# テーブルリストパーサー
export def ParseTableList(lines: list<string>): TableList

  var tableList = TableList.new()

  for line in lines
    var item = ParseListItem(line)
    tableList.AddItem(item)
  endfor
  return tableList
enddef
