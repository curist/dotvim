(fn map [coll cb]
  (icollect [i v (ipairs coll)]
    (cb v i)))

(fn filter [coll pred]
  (icollect [i v (ipairs coll)]
    (when (pred v i) v)))

(fn reduce [coll cb ...]
  (let [[init-value] [...]
        has-init (not (= nil init-value))
        start-index (if has-init 1 2)]
    (var result (if has-init init-value (. coll 1)))
    (for [i start-index (length coll)]
      (set result (cb result (. coll i) i)))
    result))

(fn concat [coll1 coll2]
  (local result [])
  (each [_ v (ipairs coll1)]
    (table.insert result v))
  (each [_ v (ipairs coll2)]
    (table.insert result v))
  result)

(fn some [coll pred]
  (each [i v (ipairs coll)]
    (when (pred v i)
      (lua "return true")))
  false)

{: map
 : filter
 : reduce
 : concat
 : some}
