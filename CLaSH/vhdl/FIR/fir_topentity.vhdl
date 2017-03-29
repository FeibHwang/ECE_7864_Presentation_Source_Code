-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.fir_types.all;

entity fir_topentity is
  port(input_0         : in signed(15 downto 0);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       output_0        : out signed(15 downto 0));
end;

architecture structural of fir_topentity is
begin
  fir_topentity_0_inst : entity fir_topentity_0
    port map
      (arg             => input_0
      ,system1000      => system1000
      ,system1000_rstn => system1000_rstn
      ,result          => output_0);
end;
