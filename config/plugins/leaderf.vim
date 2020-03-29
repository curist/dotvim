let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 1

let g:Lf_PopupShowStatusline = 0
let g:Lf_IgnoreCurrentBufferName = 0
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_CursorBlink = 0

let g:Lf_ShortcutB = ''

nn <silent> <leader>b :Leaderf! buffer<cr>
nn <silent> <leader>s :<c-u><c-r>=printf("Leaderf! rg -s -F --regexMode %s", expand("<cword>"))<cr><cr>
xn <silent> <leader>s :<c-u><c-r>=printf("Leaderf! rg -s -F --regexMode %s", leaderf#Rg#visual())<cr><cr>
nn <silent> <leader>S :Leaderf rg<cr>

nn <silent> <leader>m :Leaderf! mru --cwd<cr>
nn <silent> <leader>M :Leaderf! mru<cr>
nn <silent> <leader>l :LeaderfSelf<cr>
nn <silent> <leader>L :Leaderf --recall<cr>

let g:Lf_NormalMap = {
  \ 'Rg':   [['<C-q>', ':exec g:Lf_py "rgExplManager.outputToQflist()"<cr>:exec g:Lf_py "rgExplManager.quit()"<cr>:copen<cr>']],
  \ }
