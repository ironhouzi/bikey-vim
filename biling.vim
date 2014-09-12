if exists('g:loaded_biling_plugin')
    finish
endif
let g:loaded_biling_plugin = 1

function! Biling_init()
    let g:kbd_langs = split(system("qdbus org.kde.keyboard /Layouts getLayoutsList"))
    let g:current_kbd = 0
endfunction

function! SwitchKbd()
    let g:current_kbd = !g:current_kbd
    echom g:kbd_langs[g:current_kbd]
endfunction

function! SetLayout(layout)
    if g:current_kbd == 1
        call system("qdbus org.kde.keyboard /Layouts setLayout " . a:layout)
    endif
endfunction

autocmd InsertEnter * call SetLayout(g:kbd_langs[g:current_kbd])
autocmd InsertLeave * call SetLayout(g:kbd_langs[0])
call Biling_init()
execute "nnoremap <leader>k :call SwitchKbd()<CR>"
