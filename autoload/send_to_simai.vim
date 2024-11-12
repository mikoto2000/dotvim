vim9script

if get(g:, "devcontainer_vim", v:false)
  export def Send(host: string, port: number)
    var buffer_content = join(getbufline('%', 1, '$'), "\n")
    call send_to_simai#SendWithText(buffer_content, host, port)
  enddef

  export def SendWithText(text: string, host: string, port: number)
    var channelToSimai = ch_open($"{host}:{port}", {"mode": "raw"})
    call ch_sendraw(channelToSimai, text, {})
    call ch_close(channelToSimai)
  enddef

  export def StartPreview()
    augroup devcontainer_md
        autocmd!
        autocmd BufWritePost *.md execute ':call send_to_simai#Send("host.docker.internal", 7878)'
    augroup END
  enddef

  export def StopPreview()
    augroup devcontainer_md
        autocmd!
    augroup END
  enddef
endif

