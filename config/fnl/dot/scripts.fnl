(macros {:def (fn [name value] `(local ,name ,value))
         :defn (fn [name ...] `(fn ,name ,...))})

(def a (require :aniseed.core))

(def prefix-ignore [".git"])
(def suffix-ignore ["COMMIT_EDITMSG"])

(defn starts-with [str start]
  (= start (str:sub 1 (length start))))

(defn ends-with [str end]
  (or (= end "") (= end (str:sub (- (length end))))))

(defn get-all-files []
  (a.concat
    (->> (vim.call "fzf#vim#_buflisted_sorted")
         (a.map #(vim.api.nvim_buf_get_name $)))
    vim.v.oldfiles))

(defn filter-filepath [pwd orig-filepath]
  (let [filepath (orig-filepath:sub (+ (length pwd) 2))]
    (not (or (not (starts-with orig-filepath pwd))
             (a.some #(ends-with filepath $) suffix-ignore)
             (a.some #(starts-with filepath $) prefix-ignore)))))

(defn filter-buffers [bufs]
  (let [pwd (vim.call "getcwd")]
    (a.filter #(filter-filepath pwd (vim.api.nvim_buf_get_name $)) bufs)))

(defn fzf_local_history []
  (let [pwd (vim.call "getcwd")]
    (->> (get-all-files)
         (a.filter #(filter-filepath pwd $))
         (a.map #($:sub (+ 2 (length pwd))))
         (vim.call "fzf#vim#_uniq"))))

(defn altfile []
  (let [bufs (vim.call "fzf#vim#_buflisted_sorted")
        filtered-bufs (filter-buffers bufs)]
    (match (length filtered-bufs)
      0 :no-can-do
      1 (vim.api.nvim_set_current_buf (. filtered-bufs 1))
      _ (vim.api.nvim_set_current_buf (. filtered-bufs 2)))))

{: fzf_local_history
 : altfile}
