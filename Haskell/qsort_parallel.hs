import Control.Parallel

qsort_parallel [] = []
qsort_parallel [x] = [x]
qsort_parallel (x:xs) = lt `par` gt `pseq` lt ++ (x:gt)
    where
      lt = qsort_parallel [y | y <- xs, y < x]
      gt = qsort_parallel [y | y <- xs, y >= x]

main = do
  print $ head sorted -- Will be 1
  print $ last sorted -- Will be 10000
    where nums = [10000,9999..0]
          sorted = qsort_parallel nums


--  ghc --make -threaded -O2 .\qsort_parallel.hs
--  Measure-Command {.\qsort_parallel.exe}
