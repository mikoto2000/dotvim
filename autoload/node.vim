vim9script

export def Install()
  node#DownloadNodeBinary(GetOS(), GetMachineArchitecture(), 'v24.11.1', '~/.vim/tools/node')
enddef

def GetOS(): string
  if has('unix')
    return 'linux'
  elseif has('macunix')
    return 'darwin'
  elseif has('win32')
    return 'windows'
  else
    return 'unknown'
  endif
enddef

def GetMachineArchitecture(): string
  if has('unix')
    var arch = substitute(system('uname -m'), '\n', '', '')
    return arch
  elseif has('win32')
    return $PROCESSOR_ARCHITECTURE
  else
    return "unknown"
  endif
enddef

def DownloadNodeBinary(os: string, arch: string, version: string, dest: string)
  var url: string
  var fileName: string = ''
  if os == 'linux'
    if arch == 'x64'
      fileName = 'node-' .. version .. '-linux-x64.tar.xz'
    elseif arch == 'x86_64'
      fileName = 'node-' .. version .. '-linux-x64.tar.xz'
    elseif arch == 'arm64'
      fileName = 'node-' .. version .. '-linux-arm64.tar.xz'
    endif
  elseif os == 'darwin'
    if arch == 'x64'
      fileName = 'node-' .. version .. '-darwin-x64.tar.xz'
    elseif arch == 'x86_x64'
      fileName = 'node-' .. version .. '-darwin-x64.tar.xz'
    elseif arch == 'arm64'
      fileName = 'node-' .. version .. '-darwin-arm64.tar.xz'
    endif
  elseif os == 'windows'
    if arch == 'x64'
      fileName = 'node-' .. version .. '-win-x64.zip'
    elseif arch == 'x86_x64'
      fileName = 'node-' .. version .. '-win-x64.zip'
    elseif arch == 'arm64'
      fileName = 'node-' .. version .. '-win-arm64.zip'
    endif
  endif
  if fileName == ''
    throw 'Unsupported OS or architecture'
  endif
  url = 'https://nodejs.org/dist/' .. version .. '/' .. fileName
  call system('mkdir -p ' .. dest)
  call system('curl -o ' .. dest .. '/' .. fileName .. ' ' .. url)
  call system('tar -xf ' .. dest .. '/' .. fileName .. ' -C ' .. dest)
enddef
