vim9script

# パッケージ宣言の行を取得
export def GetPackage(): string
  var packageLineNumber = search('\v^\s*package\s+.*;$', 'new')

  if packageLineNumber == 0
    throw 'No package declaration found'
  endif

  var packageLine = getline(packageLineNumber)

  var matches = matchlist(packageLine, '\v^\s*package\s+(.*);$')

  return matches[1]
enddef

export def GetPublicClassName(): string
  var packageLineNumber = search('\v^\s*public\s+class\s+.*\s*', 'new')

  if packageLineNumber == 0
    throw 'No public class declaration found'
  endif

  var packageLine = getline(packageLineNumber)

  var matches = matchlist(packageLine, '\v^\s*public\s+class\s+(.*)\s*')

  return matches[1]
enddef

export def GetFqcn(): string
  return GetPackage() .. '.' .. GetPublicClassName()
enddef

