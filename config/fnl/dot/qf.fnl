(local a (require :aniseed.core))

(var state {:active-list :q})

(fn active-list [] (. state :active-list))

(fn is-qf-open? []
  (->> (vim.api.nvim_tabpage_list_wins 0)
       (a.filter #(= :qf (vim.fn.getwinvar $ :&ft)))
       (a.filter #(= 0 (-> (vim.fn.getwininfo $) (. 1) (. :loclist))))
       length (= 1)))

(fn has-loclist? []
  (-> (vim.fn.winnr) vim.fn.getloclist length (> 0)))

(fn is-loclist-open? []
  (let [win-loc-info (vim.fn.getloclist 0 {:winid true})]
    (> (. win-loc-info :winid) 0)))

(fn open-list []
  (let [cmd (if (= (active-list) :q) :copen :lopen)]
    (vim.cmd (.. cmd 10))))

(fn close-list []
  (let [cmd (if (= (active-list) :q) :cclose :lclose)]
    (vim.cmd cmd)))

(fn set-alter-list []
  (let [kind (if (= (active-list) :q) :l :q)]
    (tset state :active-list kind)))

(fn set-active-list []
  (let [wininfo (-> (vim.fn.win_getid) vim.fn.getwininfo (. 1))
        isloc (= 1 wininfo.loclist)
        kind (if isloc :l :q)]
    (tset state :active-list kind)))

;; we may want to 
;; 1. if active list is qf, just toggle it
;; 2. if active list is loc, should check for current window only
(fn toggle-list []
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

(fn safe-list-move [list-move-cmd]
  (let [(ok? _) (pcall vim.cmd list-move-cmd)]
    (when (not ok?)
      (print "no more list items"))))

(fn local-list-next []
  (when (= :q (active-list))
    (safe-list-move :cnext)
    (lua :return))
  (if (has-loclist?)
    (safe-list-move :lnext)
    (safe-list-move :cnext)))

(fn local-list-prev []
  (when (= :q (active-list))
    (safe-list-move :cprev)
    (lua :return))
  (if (has-loclist?)
    (safe-list-move :lprev)
    (safe-list-move :cprev)))

{:set_list set-active-list
 :toggle_list toggle-list
 :local_list_next local-list-next
 :local_list_prev local-list-prev}
