let g:vim_golfer_training_cast_enable = v:false
let g:vim_golfer_training_cast_delay_time = 1

function! vim_golfer_training_cast#ToggleGolfTraining() abort
  if !g:vim_golfer_training_cast_enable
    augroup golf_training
      autocmd!
      autocmd KeyInputPre * execute "sleep" .  g:vim_golfer_training_cast_delay_time
    augroup END
    let g:vim_golfer_training_cast_enable = v:true
  else
    augroup golf_training
      autocmd!
    augroup END
    let g:vim_golfer_training_cast_enable = v:false
  endif
endfunction

