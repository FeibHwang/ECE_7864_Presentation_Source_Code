import Control.Monad
import Control.Monad.Instances

isPrime = ap (all.((0/=).).mod) $ flip takeWhile primes.(.join(*)).flip(<=)
primes = 2:filter isPrime[3,5..]