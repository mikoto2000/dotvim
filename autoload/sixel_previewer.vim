vim9script

export def Open()

  # ウィンドウを開く
  if bufwinnr("__SIXEL_PREVIEWER__") != -1
    return
  endif

  silent bo vnew __SIXEL_PREVIEWER__

  # バッファの設定
  setlocal noshowcmd
  setlocal noswapfile
  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal nobuflisted
  setlocal nowrap
  setlocal nonumber
  setlocal norelativenumber
  setlocal nocursorline
  setlocal readonly
  setlocal nomodifiable
  set colorcolumn=
enddef

export def Draw(file: string)

  # バッファ名からウィンドウ ID 取得
  var buffer_number = bufnr("__SIXEL_PREVIEWER__")
  var winnr = -1
  for win in range(1, winnr('$'))
    if winbufnr(win) == buffer_number
      winnr = win
      break
    endif
  endfor

  if winnr == -1
    #echo "プレビューウィンドウが見つかりませんでした"
    return
  endif

  # ウィンドウの位置とサイズ取得
  var wininfo = getwininfo(win_getid(winnr))[0]
  var posx = wininfo["wincol"]
  var posy = wininfo["winrow"]
  var rows = wininfo["height"]
  var cols = wininfo["width"]

  var cell_pixel_size = getcellpixels()
  var cs_xpixel = cell_pixel_size[0]
  var cs_ypixel = cell_pixel_size[1]

  var width = cs_xpixel * cols
  var height = cs_ypixel * rows

  # width, height を使って画像をリサイズしつつ sixel に変換
  # imagemagick の convert コマンドを使う
  var sixel = system($"convert {file} -resize {width}x{height} sixel:-")

  # 1. カーソルをターミナルウィンドウの左上へ移動
  # 2. 対象の画像を出力
  call echoraw($"\e[{posy};{posx}H{sixel}")

enddef

var temp_html_file_path = ""

export def DrawHtml(file: string)
  # バッファ名からウィンドウ ID 取得
  var buffer_number = bufnr("__SIXEL_PREVIEWER__")
  var winnr = -1
  for win in range(1, winnr('$'))
    if winbufnr(win) == buffer_number
      winnr = win
      break
    endif
  endfor

  if winnr == -1
    #echo "プレビューウィンドウが見つかりませんでした"
    return
  endif

  # ウィンドウの位置とサイズ取得
  var wininfo = getwininfo(win_getid(winnr))[0]
  var posx = wininfo["wincol"]
  var posy = wininfo["winrow"]
  var rows = wininfo["height"]
  var cols = wininfo["width"]

  var cell_pixel_size = getcellpixels()
  var cs_xpixel = cell_pixel_size[0]
  var cs_ypixel = cell_pixel_size[1]

  var width = cs_xpixel * cols
  var height = cs_ypixel * rows

  temp_html_file_path = $"{tempname()}.png"
  term_start($"google-chrome --headless --screenshot={temp_html_file_path} --window-size={width},{height} {file}", { "term_finish": "close", "hidden": v:true, "close_cb": function("sixel_previewer#CloseCb") })
enddef

export def CloseCb(channel: channel)
  call sixel_previewer#Draw(temp_html_file_path)
  system($"rm {temp_html_file_path}")
enddef

var temp_mdhtml_file_path = ""

export def DrawMarkdown(file: string)
  temp_mdhtml_file_path = $"{tempname()}.html"
  term_start($"pandoc --toc --toc-depth 4 --standalone --css ~/bin/default.css {file} -o {temp_mdhtml_file_path}", { "term_finish": "close", "hidden": v:true, "close_cb": function("sixel_previewer#CloseMarkdownCb") })
enddef

export def CloseMarkdownCb(channel: channel)
  call sixel_previewer#DrawHtml(temp_mdhtml_file_path)
enddef

export def StartWatch()

  augroup sixel_previewer_watch
      autocmd!
      autocmd BufWritePost *.svg execute ':call sixel_previewer#Draw(expand("%"))'
      autocmd BufWritePost *.html execute ':call sixel_previewer#DrawHtml(expand("%"))'
      autocmd BufWritePost *.md execute ':call sixel_previewer#DrawMarkdown(expand("%"))'
  augroup END

enddef

export def EndWatch()
  var file_path = expand("%")

  augroup sixel_previewer_watch
      autocmd!
  augroup END

enddef
