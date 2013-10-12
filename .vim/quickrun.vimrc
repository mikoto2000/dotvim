let g:quickrun_config = {}

""" use QuickRun
let g:quickrun_config._ = {'runner' : 'vimproc'}

let g:quickrun_config['markdown'] = {
            \ 'type': 'markdown/pandoc',
            \ 'cmdopt': '-s --toc',
            \ 'outputter': 'browser'
            \ }

map <Space>qm <Esc>:QuickRun markdown<Enter>
