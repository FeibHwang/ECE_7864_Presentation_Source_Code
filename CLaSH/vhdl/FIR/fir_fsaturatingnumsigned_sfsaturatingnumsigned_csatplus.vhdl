-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.fir_types.all;

entity fir_fsaturatingnumsigned_sfsaturatingnumsigned_csatplus is
  port(a      : in signed(15 downto 0);
       b      : in signed(15 downto 0);
       result : out signed(15 downto 0));
end;

architecture structural of fir_fsaturatingnumsigned_sfsaturatingnumsigned_csatplus is
  signal app_arg      : std_logic_vector(15 downto 0);
  signal app_arg_0    : std_logic_vector(15 downto 0);
  signal app_arg_1    : std_logic_vector(0 downto 0);
  signal app_arg_2    : std_logic_vector(0 downto 0);
  signal r            : signed(16 downto 0);
  signal r_0          : std_logic_vector(15 downto 0);
  signal case_scrut   : std_logic_vector(0 downto 0);
  signal app_arg_3    : std_logic_vector(0 downto 0);
  signal app_arg_4    : std_logic_vector(0 downto 0);
  signal case_alt     : signed(15 downto 0);
  signal case_alt_0   : signed(15 downto 0);
  signal case_scrut_0 : std_logic_vector(0 downto 0);
  signal app_arg_5    : std_logic_vector(16 downto 0);
  signal case_alt_1   : signed(15 downto 0);
  signal case_scrut_1 : fir_types.tup2_0;
begin
  app_arg <= std_logic_vector(b);
  
  app_arg_0 <= std_logic_vector(a);
  
  -- msb begin 
  app_arg_1 <= app_arg(app_arg'high downto app_arg'high);
  -- msb end
  
  -- msb begin 
  app_arg_2 <= app_arg_0(app_arg_0'high downto app_arg_0'high);
  -- msb end
  
  r <= resize(a,17) + resize(b,17);
  
  r_0 <= case_scrut_1.tup2_0_sel1;
  
  case_scrut <= app_arg_2 and app_arg_1;
  
  -- msb begin 
  app_arg_3 <= r_0(r_0'high downto r_0'high);
  -- msb end
  
  -- msb begin 
  app_arg_4 <= app_arg_5(app_arg_5'high downto app_arg_5'high);
  -- msb end
  
  case_alt <= signed(r_0);
  
  with (case_scrut) select
    case_alt_0 <= signed'(0 => '0', 1 to 16-1  => '1') when "0",
                  signed'(0 => '1', 1 to 16-1 => '0') when others;
  
  case_scrut_0 <= app_arg_4 xor app_arg_3;
  
  app_arg_5 <= std_logic_vector(r);
  
  with (case_scrut_0) select
    case_alt_1 <= case_alt when "0",
                  case_alt_0 when others;
  
  -- split begin
  case_scrut_1 <= (app_arg_5(app_arg_5'high downto 16)
             ,app_arg_5(16-1 downto 0)
             );
  -- split end
  
  result <= case_alt_1;
end;
