qsort [] = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++ qsort (filter (>= x) xs)

-- open ghci, Haskell interpreter
-- type following command:

-- :load qsort.hs
-- qsort [1,3,2,4,3,5]