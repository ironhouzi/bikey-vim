" BiKey - Bilingual Keyboard support for Vim in KDE
" Maintainer:   Robin Skahjem-Eriksen <robinds@student.matnat.uio.no>
" Version:      0.1

if exists('g:loaded_bikey_plugin')
    finish
endif
let g:loaded_bikey_plugin = 1

function! Biling_init()
    let g:kbd_langs = split(system("qdbus org.kde.keyboard /Layouts getLayoutsList"))
endfunction

function! SwitchKbd()
    let b:current_kbd = !b:current_kbd
endfunction

function! EnsureKbd()
    if !exists('b:current_kbd')
        let b:current_kbd = 0
    endif
endfunction

function! SetLayout(layout)
    if b:current_kbd == 1
        call system("qdbus org.kde.keyboard /Layouts setLayout " . a:layout)
    endif
endfunction

function! GetCurrentKbd()
    call EnsureKbd()
    return g:kbd_langs[b:current_kbd]
endfunction

function! KbdCode()
    call EnsureKbd()
    return strpart(g:kbd_langs[b:current_kbd], 0, 2)
endfunction

call Biling_init()
autocmd InsertEnter * call SetLayout(GetCurrentKbd())
autocmd InsertLeave * call SetLayout(g:kbd_langs[0])
execute "nnoremap <silent> <leader>k :call SwitchKbd()<CR>"

call airline#parts#define_function('bikeystat', 'KbdCode')
let g:airline_section_a = airline#section#create(['mode', ' [', 'bikeystat', ']'])
