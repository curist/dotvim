(module dotfiles.module.plugin.clap
  {require {nvim aniseed.nvim
            util dotfiles.util}})

(set nvim.g.clap_provider_grep_delay 50)
(set nvim.g.clap_provider_grep_opts "-H --no-heading --vimgrep --smart-case --hidden -g !.git/")
(set nvim.g.clap_layout {:relative :editor})

(defn- clapmap [from to]
  (util.nnoremap
    from
    (.. ":Clap " to)))

(clapmap :s "grep ++query=<cword>")
(clapmap :S "grep")
(clapmap :f "files")
(clapmap :b "buffers")
(clapmap :m "history")
(clapmap :: "command_history")
(clapmap :/ "search_history")
(clapmap :y "yanks")

(defn clap-input []
  (fn map [mode]
    (nvim.buf_set_keymap
      0 mode
      "<Esc>"
      "<Esc>:call clap#handler#exit()<cr>"
      {:silent true
       :noremap true}))
  (map :n)
  (map :i))

(nvim.ex.autocmd :User :ClapOnExit "call lightline#update()")
(nvim.ex.autocmd :FileType :clap_input "lua require('dotfiles.module.plugin.clap')['clap-input']()")
