let g:quickrun_config = {}

""" use QuickRun
let g:quickrun_config._ = {'runner' : 'vimproc'}

let g:quickrun_config['markdown'] = {
            \ 'type': 'markdown/pandoc',
            \ 'cmdopt': '-s --toc',
            \ 'outputter': 'browser'
            \ }

let g:quickrun_config['page'] = {
            \ 'type': 'markdown/pandoc',
            \ 'cmdopt': '-s --toc',
            \ 'outputter': 'browser'
            \ }

let g:quickrun_config['dot'] = {
            \ 'type': 'graphviz/dot',
            \ 'exec': 'dot -Tpng %s -o /tmp/tmp.png; ~/develop/libsixel/converters/img2sixel /tmp/tmp.png',
            \ 'runner': 'shell',
            \ }

let g:quickrun_config['html'] = {
            \ 'outputter': 'browser'}


map <Space>qm <Esc>:QuickRun markdown<Enter>
