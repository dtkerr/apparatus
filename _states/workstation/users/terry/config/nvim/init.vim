if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " aesthetics
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('ap/vim-buftabline')

  " utilities
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('tpope/vim-commentary')
  call dein#add('junegunn/fzf.vim')
  call dein#add('tpope/vim-fugitive')

  " syntax
  call dein#add('cespare/vim-toml')
  call dein#add('hashivim/vim-hashicorp-tools')

  " completion
  call dein#add('neoclide/coc.nvim', {
    \ 'rev': 'release',
    \ 'merged': 0,
    \ })

  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
	call dein#install()
endif
call dein#remote_plugins()

filetype plugin indent on
syntax enable

""""""""""""""""""""
""" general settings
set clipboard+=unnamedplus
set hidden
set modeline
set noshowmode
set number
set signcolumn=yes
set updatetime=300
set shortmess+=c

set termguicolors
set t_Co=256
set background=dark
colorscheme nord

"""""""""""""
""" lightline
let g:lightline = {
	\ 'colorscheme': 'nord',
	\ 'active': {
	\     'left': [ [ 'mode', 'paste' ],
	\               [ 'cocstatus', 'readonly', 'filename', 'modified' ] 
	\     ],
	\     'right': [ [ 'filetype', 'lineinfo' ],
    \                [ 'gitbranch' ],
    \     ],
	\ },
	\ 'component_function': {
	\     'cocstatus': 'coc#status',
	\     'gitbranch': 'fugitive#head',
	\ },
	\ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"""""""""
""" Vista
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_preview = ['right:50%']

""""""""""""
""" coc-nvim
let g:coc_filetype_map = {
  \ 'htmldjango': 'html',
  \ }

""""""""""""""""
""" key bindings
let mapleader = ";"
let maplocalleader = ","
" buftabline
nnoremap <silent> <C-n> :bnext<CR>
" fzf
nnoremap <C-p> :Files<CR>
" clear highlight
nnoremap <silent> <C-l> :nohl<CR>
" completion
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>fm <Plug>(coc-format)
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

""""""""""""""
""" completion
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"""""""""""""
""" filetypes
autocmd BufRead,BufNewFile *.h set ft=c
autocmd BufRead,BufNewFile *.sls set ft=yaml

"""""""""""
""" actions
" also adds missing imports
autocmd BufWritePre *.go :call CocAction('organizeImport')
