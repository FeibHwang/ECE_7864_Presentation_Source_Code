qsort :: (Ord a) => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++ qsort (filter (>= x) xs)

main = do
  print $ head sorted -- Will be 1
  print $ last sorted -- Will be 10000
    where nums = [10000,9999..0]
          sorted = qsort nums

-- ghc --make -threaded -O2 .\qsort_serial.hs
-- Measure-Command {.\qsort_serial.exe}