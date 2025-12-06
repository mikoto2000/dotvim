vim9script

export def Install()
  DownloadDenoBinary(GetOS(), GetMachineArchitecture(), 'v2.5.6', '~/.vim/tools/deno')
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

def DownloadDenoBinary(os: string, arch: string, version: string, dest: string)
  var url: string
  var fileName: string = ''
  if os == 'linux'
    if arch == 'x64'
      fileName = 'deno-x86_64-unknown-linux-gnu.zip'
    elseif arch == 'x86_64'
      fileName = 'deno-x86_64-unknown-linux-gnu.zip'
    elseif arch == 'arm64'
      fileName = 'deno-aarch64-unknown-linux-gnu.zip'
    endif
  elseif os == 'darwin'
    if arch == 'x64'
      fileName = 'deno-x86_64-apple-darwinu.zip'
    elseif arch == 'x86_x64'
      fileName = 'deno-x86_64-apple-darwinu.zip'
    elseif arch == 'arm64'
      fileName = 'deno-aarch64-apple-darwin.zip'
    endif
  elseif os == 'windows'
    if arch == 'x64'
      fileName = 'deno-x86_64-pc-windows-msvc.zip'
    elseif arch == 'x86_x64'
      fileName = 'deno-x86_64-pc-windows-msvc.zip'
    elseif arch == 'arm64'
      fileName = 'deno-aarch64-pc-windows-msvc.zip'
    endif
  endif
  if fileName == ''
    throw 'Unsupported OS or architecture'
  endif
  url = 'https://github.com/denoland/deno/releases/download/' .. version .. '/' .. fileName
  call system('mkdir -p ' .. dest)
  call system('curl -L ' .. url .. ' -o /tmp/' .. fileName)
  call system('unzip /tmp/' .. fileName .. ' -d ' .. dest)
  call system('rm /tmp/' .. fileName)
enddef
