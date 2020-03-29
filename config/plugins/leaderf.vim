let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0

let g:Lf_PopupShowStatusline = 0
let g:Lf_IgnoreCurrentBufferName = 0
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_CursorBlink = 0

let g:Lf_ShortcutB = ''

nn <silent> <leader>b :Leaderf! buffer<cr>
nn <silent> <leader>s :Leaderf! rg --cword -s -F --regexMode<cr>
xn <silent> <leader>s :<c-u><c-r>=printf("Leaderf! rg -s -F --regexMode -e %s ", leaderf#Rg#visual())<cr><cr>
nn <silent> <leader>S :Leaderf rg<cr>

nn <silent> <leader>m :Leaderf! mru --cwd<cr>
nn <silent> <leader>M :Leaderf! mru<cr>
nn <silent> <leader>l :LeaderfSelf<cr>
nn <silent> <leader>L :Leaderf --recall<cr>
