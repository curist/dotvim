(module dotfiles.module.plugin
  {require {nvim aniseed.nvim
            core aniseed.core
            util dotfiles.util}})

;; Plugin configuration that should be loaded even if the directory doesn't
;; exist or it isn't installed according to vim-plug.
(def- always-load
  {:aniseed true})

;; Load plugin configuration modules.
(core.run!
  (fn [path]
    (let [name (nvim.fn.fnamemodify path ":t:r")]
      (match (pcall require (.. "dotfiles.module.plugin." name))
        (false err) (print "Error requiring plugin module:" name "-" err))))
  (util.glob (.. (nvim.fn.stdpath "config") "/lua/dotfiles/module/plugin/*.lua")))
