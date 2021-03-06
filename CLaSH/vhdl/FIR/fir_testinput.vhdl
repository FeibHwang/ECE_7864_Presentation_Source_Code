-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.fir_types.all;

entity fir_testinput is
  port(-- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out signed(15 downto 0));
end;

architecture structural of fir_testinput is
begin
  fir_stimuligenerator_sstimuligenerator_result : entity fir_stimuligenerator_sstimuligenerator
    port map
      (result          => result
      ,system1000      => system1000
      ,system1000_rstn => system1000_rstn);
end;
