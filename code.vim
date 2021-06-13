call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-lastpat'
Plug 'curist/highlight.vim'
Plug 'tpope/vim-repeat'
call plug#end()

set ignorecase
set smartcase

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

nn <leader>s <cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<cr>
xn <leader>s <esc>:call VSCodeNotify('workbench.action.findInFiles', { 'query': '<c-r>=<sid>getVisualSelection()<cr>'})<cr>

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

nn <leader>gb <cmd>call VSCodeNotify('gitlens.toggleFileBlame')<cr>
nn <leader>gl <cmd>call VSCodeNotify('gitlens.showQuickFileHistory')<cr>
nn <leader>gL <cmd>call VSCodeNotify('gitlens.showQuickRepoHistory')<cr>
nn <leader>m <cmd>call VSCodeNotify('workbench.action.showEditorsInActiveGroup')<cr>

nn <c-w>H <cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<cr>
nn <c-w>J <cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<cr>
nn <c-w>K <cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<cr>
nn <c-w>L <cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<cr>
