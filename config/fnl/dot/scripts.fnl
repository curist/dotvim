(macros {:def (fn [name value] `(local ,name ,value))
         :defn (fn [name ...] `(fn ,name ,...))})

(def dot (require :dot.utils))

(def prefix-ignore [".git"])
(def suffix-ignore ["COMMIT_EDITMSG"])

(defn starts-with [str start]
  (= start (str:sub 1 (length start))))

(defn ends-with [str end]
  (or (= end "") (= end (str:sub (- (length end))))))

(defn get-all-files []
  (dot.concat
    (-> (vim.call "fzf#vim#_buflisted_sorted")
        (dot.map #(vim.api.nvim_buf_get_name $)))
    vim.v.oldfiles))

(defn filter-filepath [pwd orig-filepath]
  (let [filepath (orig-filepath:sub (+ (length pwd) 2))]
    (not (or (not (starts-with orig-filepath pwd))
             (dot.some suffix-ignore #(ends-with filepath $))
             (dot.some prefix-ignore #(starts-with filepath $))))))

(defn filter-buffers [bufs]
  (let [pwd (vim.call "getcwd")]
    (dot.filter bufs #(filter-filepath pwd (vim.api.nvim_buf_get_name $)))))

(defn fzf_local_history []
  (let [pwd (vim.call "getcwd")
        files (-> (get-all-files)
                  (dot.filter #(filter-filepath pwd $))
                  (dot.map #($:sub (+ 2 (length pwd)))))]
    (vim.call "fzf#vim#_uniq" files)))

(defn altfile []
  (let [bufs (vim.call "fzf#vim#_buflisted_sorted")
        filtered-bufs (filter-buffers bufs)]
    (match (length filtered-bufs)
      0 :no-can-do
      1 (vim.api.nvim_set_current_buf (. filtered-bufs 1))
      _ (vim.api.nvim_set_current_buf (. filtered-bufs 2)))))

{: fzf_local_history
 : altfile}
