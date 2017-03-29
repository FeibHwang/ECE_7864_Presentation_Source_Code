{-# LANGUAGE RecordWildCards, TupleSections #-}
module CPU where

import CLaSH.Prelude

type InstrAddr = Unsigned 8
type MemAddr   = Unsigned 5
type Value     = Signed 8

data Instruction
  = Compute Operator Reg Reg Reg
  | Branch Reg Value
  | Jump Value
  | Load MemAddr Reg
  | Store Reg MemAddr
  | Nop
  deriving (Eq,Show)

data Reg
  = Zero
  | PC
  | RegA
  | RegB
  | RegC
  | RegD
  | RegE
  deriving (Eq,Show,Enum)

data Operator = Add | Sub | Incr | Imm | CmpGt
  deriving (Eq,Show)

data MachCode
  = MachCode
  { inputX  :: Reg
  , inputY  :: Reg
  , result  :: Reg
  , aluCode :: Operator
  , ldReg   :: Reg
  , rdAddr  :: MemAddr
  , wrAddrM :: Maybe MemAddr
  , jmpM    :: Maybe Value
  }

nullCode = MachCode { inputX = Zero, inputY = Zero, result = Zero, aluCode = Imm
                    , ldReg = Zero, rdAddr = 0, wrAddrM = Nothing
                    , jmpM = Nothing
                    }


cpu :: Vec 7 Value          -- ^ Register bank
    -> (Value,Instruction)  -- ^ (Memory output, Current instruction)
    -> ( Vec 7 Value
       , (MemAddr, Maybe (MemAddr,Value), InstrAddr)
       )
cpu regbank (memOut,instr) = (regbank',(rdAddr,(,aluOut) <$> wrAddrM,fromIntegral ipntr))
  where
    -- Current instruction pointer
    ipntr = regbank !! PC

    -- Decoder
    (MachCode {..}) = case instr of
      Compute op rx ry res -> nullCode {inputX=rx,inputY=ry,result=res,aluCode=op}
      Branch cr a          -> nullCode {inputX=cr,jmpM=Just a}
      Jump a               -> nullCode {aluCode=Incr,jmpM=Just a}
      Load a r             -> nullCode {ldReg=r,rdAddr=a}
      Store r a            -> nullCode {inputX=r,wrAddrM=Just a}
      Nop                  -> nullCode

    -- ALU
    regX   = regbank !! inputX
    regY   = regbank !! inputY
    aluOut = alu aluCode regX regY

    -- next instruction
    nextPC = case jmpM of
               Just a | aluOut /= 0 -> ipntr + a
               _                    -> ipntr + 1

    -- update registers
    regbank' = replace Zero   0
             $ replace PC     nextPC
             $ replace result aluOut
             $ replace ldReg  memOut
             $ regbank

alu Add   x y = x + y
alu Sub   x y = x - y
alu Incr  x _ = x + 1
alu Imm   x _ = x
alu CmpGt x y = if x > y then 1 else 0


dataMem :: Signal MemAddr                 -- ^ Read address
        -> Signal (Maybe (MemAddr,Value)) -- ^ (write address, data in)
        -> Signal Value                   -- ^ data out
dataMem rd wrM = mealy dataMemT (replicate d32 0) (bundle (rd,wrM))
  where
    dataMemT mem (rd,wrM) = (mem',dout)
      where
        dout = mem !! rd
        mem' = case wrM of
                 Just (wr,din) -> replace wr din mem
                 _ -> mem


system :: KnownNat n => Vec n Instruction -> Signal Value
system instrs = memOut
  where
    memOut = dataMem rdAddr dout
    (rdAddr,dout,ipntr) = mealyB cpu (replicate d7 0) (memOut,instr)
    instr  = asyncRom instrs <$> ipntr





















-- Compute GCD of 4 and 6
-- clash --interactive
-- :load myCPU.hs
-- sampleN 31 $ system prog
prog = -- 0 := 4
       Compute Incr Zero RegA RegA :>
       replicate d3 (Compute Incr RegA Zero RegA) ++
       Store RegA 0 :>
       -- 1 := 6
       Compute Incr Zero RegA RegA :>
       replicate d5 (Compute Incr RegA Zero RegA) ++
       Store RegA 1 :>
       -- A := 4
       Load 0 RegA :>
       -- B := 6
       Load 1 RegB :>
       -- start
       Compute CmpGt RegA RegB RegC :>
       Branch RegC 4 :>
       Compute CmpGt RegB RegA RegC :>
       Branch RegC 4 :>
       Jump 5 :>
       -- (a > b)
       Compute Sub RegA RegB RegA :>
       Jump (-6) :>
       -- (b > a)
       Compute Sub RegB RegA RegB :>
       Jump (-8) :>
       -- end
       Store RegA 2 :>
       Load 2 RegC :>
       Nil