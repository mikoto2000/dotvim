vim9script

# プレビュー時に使われる一時変数
var simai_host = ""
var simai_port = -1

export def Send(host: string, port: number)
  var buffer_content = join(getbufline('%', 1, '$'), "\n")
  call send_to_simai#SendWithText(buffer_content, host, port)
enddef

export def SendWithText(text: string, host: string, port: number)
  var channelToSimai = ch_open($"{host}:{port}", {"mode": "raw"})
  call ch_sendraw(channelToSimai, text, {})
  call ch_close(channelToSimai)
enddef

export def StartPreview(host: string, port: number)
  simai_host = host
  simai_port = port
  augroup devcontainer_md
      autocmd!
      autocmd BufWritePost *.md execute $":call send_to_simai#Send(\"{simai_host}\", {simai_port})"
  augroup END
enddef

export def StopPreview()
  augroup devcontainer_md
      autocmd!
  augroup END
enddef

