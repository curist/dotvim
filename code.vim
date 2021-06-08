call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-lastpat'
Plug 'curist/highlight.vim'
Plug 'tpope/vim-repeat'
call plug#end()

let mapleader = ","
let maplocalleader = ","

nn <leader>h :noh<cr>

" other sweet mappings
nn <space> <cmd>call VSCodeNotify('editor.toggleFold')<cr>

vmap <c-c> <esc>
nn <leader><leader> <c-^>
nn <leader>d <cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>

" Keep the cursor in place while joining lines
nn J mzJ`z

nn <leader>f <cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>
nn <leader>s <cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<cr>
xn <leader>s <esc>:call VSCodeNotify('workbench.action.findInFiles', { 'query': '<c-r>=<sid>getVisualSelection()<cr>'})<cr>
nn <leader>S <cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>

function! s:getVisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)

  if len(lines) == 0
    return ""
  endif

  let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]

  return join(lines, "\n")
endfunction
