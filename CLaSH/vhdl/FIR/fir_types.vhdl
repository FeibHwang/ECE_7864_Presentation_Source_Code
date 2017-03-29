library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package fir_types is
  type tup2_2 is record
    tup2_2_sel0 : unsigned(1 downto 0);
    tup2_2_sel1 : signed(15 downto 0);
  end record;
  type array_of_signed_16 is array (integer range <>) of signed(15 downto 0);
  type tup2_0 is record
    tup2_0_sel0 : std_logic_vector(0 downto 0);
    tup2_0_sel1 : std_logic_vector(15 downto 0);
  end record;
  type tup2_3 is record
    tup2_3_sel0 : signed(15 downto 0);
    tup2_3_sel1 : boolean;
  end record;
  type tup2 is record
    tup2_sel0 : std_logic_vector(15 downto 0);
    tup2_sel1 : std_logic_vector(15 downto 0);
  end record;
  type tup2_4 is record
    tup2_4_sel0 : unsigned(1 downto 0);
    tup2_4_sel1 : fir_types.tup2_3;
  end record;
  type tup2_1 is record
    tup2_1_sel0 : fir_types.array_of_signed_16(0 to 2);
    tup2_1_sel1 : fir_types.array_of_signed_16(0 to 0);
  end record;
  function toSLV (s : in signed) return std_logic_vector;
  function toSLV (u : in unsigned) return std_logic_vector;
  function toSLV (p : fir_types.tup2_2) return std_logic_vector;
  function toSLV (value :  fir_types.array_of_signed_16) return std_logic_vector;
  function toSLV (slv : in std_logic_vector) return std_logic_vector;
  function toSLV (p : fir_types.tup2_0) return std_logic_vector;
  function toSLV (b : in boolean) return std_logic_vector;
  function fromSLV (sl : in std_logic_vector) return boolean;
  function tagToEnum (s : in signed) return boolean;
  function dataToTag (b : in boolean) return signed;
  function toSLV (p : fir_types.tup2_3) return std_logic_vector;
  function toSLV (p : fir_types.tup2) return std_logic_vector;
  function toSLV (p : fir_types.tup2_4) return std_logic_vector;
  function toSLV (p : fir_types.tup2_1) return std_logic_vector;
end;

package body fir_types is
  function toSLV (s : in signed) return std_logic_vector is
  begin
    return std_logic_vector(s);
  end;
  function toSLV (u : in unsigned) return std_logic_vector is
  begin
    return std_logic_vector(u);
  end;
  function toSLV (p : fir_types.tup2_2) return std_logic_vector is
  begin
    return (toSLV(p.tup2_2_sel0) & toSLV(p.tup2_2_sel1));
  end;
  function toSLV (value :  fir_types.array_of_signed_16) return std_logic_vector is
    alias ivalue    : fir_types.array_of_signed_16(1 to value'length) is value;
    variable result : std_logic_vector(1 to value'length * 16);
  begin
    for i in ivalue'range loop
      result(((i - 1) * 16) + 1 to i*16) := toSLV(ivalue(i));
    end loop;
    return result;
  end;
  function toSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function toSLV (p : fir_types.tup2_0) return std_logic_vector is
  begin
    return (toSLV(p.tup2_0_sel0) & toSLV(p.tup2_0_sel1));
  end;
  function toSLV (b : in boolean) return std_logic_vector is
  begin
    if b then
      return "1";
    else
      return "0";
    end if;
  end;
  function fromSLV (sl : in std_logic_vector) return boolean is
  begin
    if sl = "1" then
      return true;
    else
      return false;
    end if;
  end;
  function tagToEnum (s : in signed) return boolean is
  begin
    if s = to_signed(0,64) then
      return false;
    else
      return true;
    end if;
  end;
  function dataToTag (b : in boolean) return signed is
  begin
    if b then
      return to_signed(1,64);
    else
      return to_signed(0,64);
    end if;
  end;
  function toSLV (p : fir_types.tup2_3) return std_logic_vector is
  begin
    return (toSLV(p.tup2_3_sel0) & toSLV(p.tup2_3_sel1));
  end;
  function toSLV (p : fir_types.tup2) return std_logic_vector is
  begin
    return (toSLV(p.tup2_sel0) & toSLV(p.tup2_sel1));
  end;
  function toSLV (p : fir_types.tup2_4) return std_logic_vector is
  begin
    return (toSLV(p.tup2_4_sel0) & toSLV(p.tup2_4_sel1));
  end;
  function toSLV (p : fir_types.tup2_1) return std_logic_vector is
  begin
    return (toSLV(p.tup2_1_sel0) & toSLV(p.tup2_1_sel1));
  end;
end;
