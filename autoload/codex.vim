" codex
" Version: 0.0.1
" Author: mikoto2000
" License: MIT

if exists('g:loaded_codex')
  finish
endif
let g:loaded_codex = 1

let s:save_cpo = &cpo
set cpo&vim

packadd vital.vim
let s:HTTP = vital#vital#import("Web.HTTP")

let s:ENDPOINT_URL = "https://api.openai.com/v1/responses"
let s:HEADERS = {
      \  "Content-Type": "application/json",
      \  "Authorization": "Bearer " . $OPENAI_API_KEY
      \}
let s:MODEL = "gpt-5"

function! codex#OpenCodexBuffer() abort
    """ 呼び出し元のウィンドウ ID を記憶
    let s:caller_window_id = win_getid()

    """ 新しいバッファを作成
    silent bo new __CODEX_BUFFER__

    """ バッファリスト用バッファの設定
    setlocal noshowcmd
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal nonumber
endfunction

function! codex#AppendText(text) abort
  " 追記する行データを用意（文字列 or リストの両対応）
  let lines = type(a:text) == v:t_list ? a:text : split(a:text, "\n", 1)

  " 末尾に追記（空バッファなら1行目を置換）
  let lc = getbufinfo(buf)[0].linecount
  if lc == 1 && getbufline(buf, 1)[0] ==# ''
    call setbufline(buf, 1, lines)
  else
    call appendbufline(buf, lc, lines)
  endif
endfunction

function! codex#ExitCb(job, code, headers, body) abort
  let body_text = type(a:body) == v:t_list ? join(a:body, "\n") : a:body
  let body_json = json_decode(body_text)
  let text = body_json.output[1].content[0].text
  call codex#AppendText(text)
endfunction

function! codex#Request(text) abort
  let name = '__CODEX_BUFFER__'
  let buf  = bufnr(name)
  if buf == -1
    call codex#OpenCodexBuffer()
  endif

  if !bufloaded(buf) | call bufload(buf) | endif

  call s:HTTP.request_async({
        \ "url": s:ENDPOINT_URL,
        \ "method": "POST",
        \ "headers": s:HEADERS,
        \ "data": json_encode({
        \   "model": s:MODEL,
        \   "input": a:text
        \ }),
        \ "exit_cb": "codex#ExitCb"
        \})
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
