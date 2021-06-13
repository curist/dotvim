(macros {:def (fn [name value] `(local ,name ,value))
         :defn (fn [name ...] `(fn ,name ,...))})

(def a (require :aniseed.core))

(def state {:active-list ""})

(defn active-list [] (. state :active-list))

(defn is-qf-open? []
  (->> (vim.api.nvim_tabpage_list_wins 0)
       (a.filter #(= :qf (vim.fn.getwinvar $ :&ft)))
       (a.filter #(= 0 (-> (vim.fn.getwininfo $) (. 1) (. :loclist))))
       length (= 1)))

(defn has-loclist? []
  (-> (vim.fn.winnr) vim.fn.getloclist length (> 0)))

(defn is-loclist-open? []
  (let [win-loc-info (vim.fn.getloclist 0 {:winid true})]
    (> (. win-loc-info :winid) 0)))

(defn open-list []
  (let [cmd (if (= (active-list) :q) :copen :lopen)]
    (vim.cmd (.. cmd 10))))

(defn close-list []
  (let [cmd (if (= (active-list) :q) :cclose :lclose)]
    (vim.cmd cmd)))

(defn set-alter-list []
  (let [kind (if (= (active-list) :q) :l :q)]
    (tset state :active-list kind)))

(defn set-active-list []
  (let [wininfo (-> (vim.fn.win_getid) vim.fn.getwininfo (. 1))
        isloc (= 1 wininfo.loclist)
        kind (if isloc :l :q)]
    (tset state :active-list kind)))

;; we may want to 
;; 1. if active list is qf, just toggle it
;; 2. if active list is loc, should check for current window only
(defn toggle-list []
  (when (is-loclist-open?)
    (tset state :active-list :l)
    (close-list)
    (lua :return))
  (if (= :q (active-list))
      (if (is-qf-open?)
        (close-list)
        (open-list))
      (if (has-loclist?)
        (open-list)
        (do ;; active loc list is set by other windows
          (set-alter-list)
          (toggle-list)))))

(defn safe-list-move [list-type direction]
  (let [(ok? _) (pcall vim.cmd list-move-cmd)
        cmd (.. list-type direction)
        wrap-cmd (.. list-type (if (= direction :next) :first :last))]
    (when (not ok?)
      (print "no more list items")
      (pcall vim.cmd wrap-cmd))))

(defn local-list-next []
  (if (or (= :q (active-list)) (not (has-loclist?)))
    (safe-list-move :c :next)
    (safe-list-move :l :next)))

(defn local-list-prev []
  (if (or (= :q (active-list)) (not (has-loclist?)))
    (safe-list-move :c :prev)
    (safe-list-move :l :prev)))

{:set_list set-active-list
 :toggle_list toggle-list
 :local_list_next local-list-next
 :local_list_prev local-list-prev}
