let g:fzf_preview_window = ''
let g:fzf_layout = { 'window': { 'width': 0.75, 'height': 0.5, 'yoffset': 1.0, 'border': 'sharp' } }
let $FZF_DEFAULT_COMMAND='rg --no-ignore-vcs --hidden --files'
let $FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS . ' --bind "alt-a:select-all,alt-d:deselect-all"'

nn <silent> <leader>f :GFiles<cr>
nn <silent> <leader>F :Files<cr>
nn <silent> <leader>M :History<cr>
nn <silent> <leader>c :Commands<cr>
nn <silent> <leader>b :Buffers<cr>
nn <silent> <leader>k :FzfFunky<cr>
nn <silent> <leader>/ :History/<cr>
nn <silent> <leader>: :History:<cr>
nn <silent> <leader>gl :BCommits<cr>
nn <silent> <leader>gL :Commits<cr>

command! -bang -nargs=* RgExact call fzf#vim#grep("rg -F --column --line-number --no-heading --color=always ".shellescape(<q-args>), 1, {'options': '-e --delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

nn <silent> <leader>S :Rg<cr>
nn <silent> <leader>s :RgExact <c-r>=expand('<cword>')<cr><cr>

nn <silent> <leader>x :BLines <c-r>=expand('<cword>')<cr><cr>
nn <silent> <leader>X :BLines <cr>

imap <c-x><c-l> <plug>(fzf-complete-line)

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

xn <silent> <leader>s <Esc>:Rg <c-r>=<SID>getVisualSelection()<cr><cr>

nn <silent> <leader>z :RggExact <c-r>=expand('<cword>')<cr><cr>
xn <silent> <leader>z <Esc>:Rgg <c-r>=<SID>getVisualSelection()<cr><cr>
nn <silent> <leader>Z :Rgg<cr>

command! -bang -nargs=* Rgg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore-vcs -- '.shellescape(<q-args>), 1,
  \   {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* RggExact
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always --hidden --no-ignore-vcs -- '.shellescape(<q-args>), 1,
  \   {'options': '-e --delimiter : --nth 4..'}, <bang>0)

function! s:fzf_local_history()
  let oldfiles = luaeval('require("dot.scripts").fzf_local_history()')
  let readable_files = filter(oldfiles, "filereadable(fnamemodify(v:val, ':p'))")
  return fzf#run(fzf#wrap({
  \ 'source': readable_files,
  \ 'sink': 'e',
  \ 'options': ['-m', '--no-sort', '--prompt', 'LHist> ']
  \}))
endfunction

command! -nargs=0 LocalHistory call <sid>fzf_local_history()
nn <silent> <leader>m :LocalHistory<cr>

function! s:fzf_projects(base)
  let base = substitute(a:base, '\/$', '', '')
  let projects = luaeval('require("dot.scripts").dirs("'.base.'")')
  let spec = { 'source': projects, 'options': ['-m', '--prompt', base . '/'], 'base': base }
  function spec.sink(match)
    execute 'cd ' . self.base . '/' . a:match
    execute 'Vaffle'
    " execute 'LocalHistory'
  endfunction
  return fzf#run(fzf#wrap(spec))
endfunction

command! -nargs=* -complete=dir Project call <sid>fzf_projects(<q-args>)
nn <silent> <leader>p :Project ~/workspace<cr>
