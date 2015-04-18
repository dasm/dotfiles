"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible " Be iMproved
  endif

  set runtimepath+=/home/dasm/.vim/bundle/neobundle.vim/ "Required
endif

call neobundle#begin(expand('/home/dasm/.vim/bundle')) "Required

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim' "Required

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' } "Specify revision/branch/tag

call neobundle#end() "Required
filetype plugin indent on "Required

NeoBundleCheck "Reinstall uninstalled bundles
"End NeoBundle Scripts-------------------------

syntax on

" Python
set colorcolumn=80
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

set spell
colorscheme desert

" Whitespaces
set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" Remove whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" NeoSnippet Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" NERDTree new tab
let NERDTreeMapOpenInTab='<ENTER>'
