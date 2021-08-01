"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

command W :execute 'silent! write !sudo tee % >/dev/null' | edit! " Write with Sudo and reload file 
command WQ :execute 'silent! write !sudo tee % >/dev/null' | quit! " Write with Sudo and quit

colorscheme vividchalk                      " Set color scheme
set t_Co=256                                " set 256 colors
set nobackup 	                            " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile 	                            " no swap files
set number                                  " show line numbers
set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set smarttab                                " set tabs for a shifttabs logic
set expandtab                               " expand tabs into spaces
set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}
set vb                                      " Set Visual Bell
