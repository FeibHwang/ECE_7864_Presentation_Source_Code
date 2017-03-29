-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.fir_types.all;

entity fir_window is
  port(w2              : in signed(15 downto 0);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out fir_types.array_of_signed_16(0 to 3));
end;

architecture structural of fir_window is
  signal result_0      : fir_types.array_of_signed_16(0 to 2);
  signal x             : fir_types.array_of_signed_16(0 to 2);
  signal vs            : fir_types.array_of_signed_16(0 to 2);
  signal vs_case_scrut : fir_types.tup2_1;
  signal vs_app_arg    : fir_types.array_of_signed_16(0 to 3);
  signal x_0           : fir_types.array_of_signed_16(0 to 2);
  signal vs_app_arg_0  : fir_types.array_of_signed_16(0 to 0);
begin
  result_0 <= x;
  
  -- register begin
  fir_window_register : process(system1000,system1000_rstn)
  begin
    if system1000_rstn = '0' then
      x <= (fir_types.array_of_signed_16'(0 to 3-1 =>  to_signed(0,16) ));
    elsif rising_edge(system1000) then
      x <= vs;
    end if;
  end process;
  -- register end
  
  vs <= x_0;
  
  -- splitAt begin
  vs_case_scrut <= (vs_app_arg(0 to 3-1)
             ,vs_app_arg(3 to vs_app_arg'high));
  -- splitAt end
  
  vs_app_arg <= fir_types.array_of_signed_16'(fir_types.array_of_signed_16'(vs_app_arg_0) & fir_types.array_of_signed_16'(result_0));
  
  x_0 <= vs_case_scrut.tup2_1_sel0;
  
  vs_app_arg_0 <= fir_types.array_of_signed_16'(0 => w2);
  
  result <= fir_types.array_of_signed_16'(signed'(w2) & result_0);
end;
