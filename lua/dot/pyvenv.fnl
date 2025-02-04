;; :FnlCompileBuffer
(local M {})

(var current-venv nil)
(var prev-system-bin-path nil)

(local vim (or _G.vim {}))
(local notify {})

(each [k (pairs vim.log.levels)]
  (tset notify (k:lower)
        (fn [msg] (vim.notify msg (. vim.log.levels k)))))

(fn get-bin-path [venv-path]
  (case venv-path
    p (vim.fn.resolve (.. p "/bin"))))

(fn get-python-path [venv-path]
  (case (get-bin-path venv-path)
    p (vim.fn.resolve (.. p "/python"))))

(fn M.init-venv [path]
  ;; TODO: shell out, set path, uv init && uv venv
  )

(local lsps ["pyright" "ruff"])

(fn setup-lsp [lsp-name python-path]
  (let [clients (vim.lsp.get_clients {:name lsp-name})]
    (each [_ client (ipairs clients)]
      (if client.settings
        (set client.settings.python
             (vim.tbl_deep_extend :force client.settings.python
                                  {:pythonPath python-path}))
        (set client.config.settings
             (vim.tbl_deep_extend :force client.config.settings
                                  {:python {:pythonPath python-path}})))
      (client.notify :workspace/didChangeConfiguration {:settings nil }))))

(fn setup-lsps [python-path]
  (each [_ lsp (ipairs lsps)]
    (setup-lsp lsp python-path)))

(fn M.activate [path]
  ;; TODO: set venv & bin path, setup lsp with (venv, venv-python)
  (when current-venv (M.deactivate))
  (set current-venv (vim.fn.resolve (.. path "/.venv")))
  (let [bin-path (get-bin-path current-venv)
        python-path (get-python-path current-venv)]
    (when (= nil python-path)
      (notify.error
        (.. "The python path '" python-path "' does not exist."))
      (lua "return"))
    (set prev-system-bin-path (vim.fn.getenv :PATH))
    (vim.fn.setenv :PATH (.. bin-path ":" prev-system-bin-path))
    (vim.fn.setenv :VIRTUAL_ENV current-venv)
    (setup-lsps python-path)
    (notify.info "Activated python virtual env")))


(fn M.deactivate []
  (vim.fn.setenv :VIRTUAL_ENV "")
  (set current-venv nil)
  (case prev-system-bin-path
    p (do (vim.fn.setenv :PATH p)
          (set prev-system-bin-path nil))))

M
