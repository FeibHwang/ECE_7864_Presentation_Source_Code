import Control.Monad
import Control.Monad.Instances

isPrime = ap (all.((0/=).).mod) $ flip takeWhile primes.(.join(*)).flip(<=)
primes = 2:filter isPrime[3,5..]

-- open ghci, Haskell interpreter
-- type following command:

-- isPrime 3
-- isPrime 4
-- take 100 primes
-- primes
-- to stop: control+C