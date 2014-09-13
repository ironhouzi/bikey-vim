" BiKey - Bilingual Keyboard support for Vim in KDE
" Maintainer:   Robin Skahjem-Eriksen <robinds@student.matnat.uio.no>
" Version:      0.1

if exists('g:loaded_bikey_plugin')
    finish
endif
let g:loaded_bikey_plugin = 1

function! Biling_init()
    let g:kbd_langs = split(system("qdbus org.kde.keyboard /Layouts getLayoutsList"))
    let g:current_kbd = 0
endfunction

function! SwitchKbd()
    let g:current_kbd = !g:current_kbd
endfunction

function! SetLayout(layout)
    if g:current_kbd == 1
        call system("qdbus org.kde.keyboard /Layouts setLayout " . a:layout)
    endif
endfunction

function! GetCurrentKbd()
    return g:kbd_langs[g:current_kbd]
endfunction

function! KbdCode()
    return strpart(g:kbd_langs[g:current_kbd], 0, 2)
endfunction

autocmd InsertEnter * call SetLayout(GetCurrentKbd())
autocmd InsertLeave * call SetLayout(g:kbd_langs[0])
call Biling_init()
execute "nnoremap <silent> <leader>k :call SwitchKbd()<CR>"

call airline#parts#define_function('bikeystat', 'KbdCode')
let g:airline_section_a = airline#section#create(['mode', ' [', 'bikeystat', ']'])
