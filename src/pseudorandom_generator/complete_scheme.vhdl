--------------------------------------------------
-- Module: Posit add
--------------------------------------------------

--------------------------------------------------------------------------------
--                      Normalizer_ZO_30_30_31_comb_uid6
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_30_30_31_comb_uid6 is
    port (X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_31_comb_uid6 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(29 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(29 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(29 downto 22) = (29 downto 22=>sozb) else '0';
   level3<= level4(29 downto 0) when count3='0' else level4(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb) else '0';
   level1<= level2(29 downto 0) when count1='0' else level2(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb) else '0';
   level0<= level1(29 downto 0) when count0='0' else level1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                          Posit2PIF_32_2_comb_uid4
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Oregane Desrentes 2019
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: I
-- Output signals: O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Posit2PIF_32_2_comb_uid4 is
    port (I : in  std_logic_vector(31 downto 0);
          O : out  std_logic_vector(40 downto 0)   );
end entity;

architecture arch of Posit2PIF_32_2_comb_uid4 is
   component Normalizer_ZO_30_30_31_comb_uid6 is
      port ( X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal s :  std_logic;
signal count_type :  std_logic;
signal remainder :  std_logic_vector(29 downto 0);
signal not_s :  std_logic;
signal zero_NAR :  std_logic;
signal is_NAR :  std_logic;
signal is_not_zero :  std_logic;
signal implicit_bit :  std_logic;
signal neg_count :  std_logic;
signal lzCount :  std_logic_vector(4 downto 0);
signal usefulBits :  std_logic_vector(29 downto 0);
signal extended_neg_count :  std_logic_vector(6 downto 0);
signal comp2_range_count :  std_logic_vector(6 downto 0);
signal fraction :  std_logic_vector(26 downto 0);
signal partialExponent :  std_logic_vector(1 downto 0);
signal us_partialExponent :  std_logic_vector(1 downto 0);
signal exponent :  std_logic_vector(8 downto 0);
signal biased_exponent :  std_logic_vector(8 downto 0);
signal extended_is_not_zero :  std_logic_vector(8 downto 0);
signal final_biased_exponent :  std_logic_vector(8 downto 0);
signal round :  std_logic;
signal sticky :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
s<= I(31);
count_type<= I(30);
remainder<= I(29 downto 0);
not_s<= not s;
zero_NAR <= not count_type when remainder="000000000000000000000000000000" else '0';
is_NAR<= zero_NAR and s;
is_not_zero<= not(zero_NAR and not_s);
implicit_bit<= is_not_zero and not_s;
neg_count<= not (s xor count_type);
   lzoc: Normalizer_ZO_30_30_31_comb_uid6
      port map ( OZb => count_type,
                 X => remainder,
                 Count => lzCount,
                 R => usefulBits);
with neg_count  select  extended_neg_count <= 
   "0000000" when '0', 
   "1111111" when '1', 
   "-------" when others;
comp2_range_count<= extended_neg_count xor ("00" & lzCount);
fraction<= usefulBits(26 downto 0);
partialExponent<= usefulBits(28 downto 27);
with s  select  us_partialExponent<= 
   partialExponent when '0',
   not partialExponent when '1',
   "--" when others;
exponent<= comp2_range_count & us_partialExponent;
biased_exponent<= exponent + 121;
with is_not_zero  select   extended_is_not_zero <= 
   "000000000" when '0', 
   "111111111" when '1', 
   "---------" when others;
final_biased_exponent<= extended_is_not_zero and biased_exponent;
round<= '0';
sticky<= '0';
O <= is_NAR & s & final_biased_exponent & implicit_bit & fraction & round & sticky;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                     Normalizer_ZO_30_30_31_comb_uid10
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_30_30_31_comb_uid10 is
    port (X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_31_comb_uid10 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(29 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(29 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(29 downto 22) = (29 downto 22=>sozb) else '0';
   level3<= level4(29 downto 0) when count3='0' else level4(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb) else '0';
   level1<= level2(29 downto 0) when count1='0' else level2(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb) else '0';
   level0<= level1(29 downto 0) when count0='0' else level1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                          Posit2PIF_32_2_comb_uid8
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Oregane Desrentes 2019
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: I
-- Output signals: O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Posit2PIF_32_2_comb_uid8 is
    port (I : in  std_logic_vector(31 downto 0);
          O : out  std_logic_vector(40 downto 0)   );
end entity;

architecture arch of Posit2PIF_32_2_comb_uid8 is
   component Normalizer_ZO_30_30_31_comb_uid10 is
      port ( X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal s :  std_logic;
signal count_type :  std_logic;
signal remainder :  std_logic_vector(29 downto 0);
signal not_s :  std_logic;
signal zero_NAR :  std_logic;
signal is_NAR :  std_logic;
signal is_not_zero :  std_logic;
signal implicit_bit :  std_logic;
signal neg_count :  std_logic;
signal lzCount :  std_logic_vector(4 downto 0);
signal usefulBits :  std_logic_vector(29 downto 0);
signal extended_neg_count :  std_logic_vector(6 downto 0);
signal comp2_range_count :  std_logic_vector(6 downto 0);
signal fraction :  std_logic_vector(26 downto 0);
signal partialExponent :  std_logic_vector(1 downto 0);
signal us_partialExponent :  std_logic_vector(1 downto 0);
signal exponent :  std_logic_vector(8 downto 0);
signal biased_exponent :  std_logic_vector(8 downto 0);
signal extended_is_not_zero :  std_logic_vector(8 downto 0);
signal final_biased_exponent :  std_logic_vector(8 downto 0);
signal round :  std_logic;
signal sticky :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
s<= I(31);
count_type<= I(30);
remainder<= I(29 downto 0);
not_s<= not s;
zero_NAR <= not count_type when remainder="000000000000000000000000000000" else '0';
is_NAR<= zero_NAR and s;
is_not_zero<= not(zero_NAR and not_s);
implicit_bit<= is_not_zero and not_s;
neg_count<= not (s xor count_type);
   lzoc: Normalizer_ZO_30_30_31_comb_uid10
      port map ( OZb => count_type,
                 X => remainder,
                 Count => lzCount,
                 R => usefulBits);
with neg_count  select  extended_neg_count <= 
   "0000000" when '0', 
   "1111111" when '1', 
   "-------" when others;
comp2_range_count<= extended_neg_count xor ("00" & lzCount);
fraction<= usefulBits(26 downto 0);
partialExponent<= usefulBits(28 downto 27);
with s  select  us_partialExponent<= 
   partialExponent when '0',
   not partialExponent when '1',
   "--" when others;
exponent<= comp2_range_count & us_partialExponent;
biased_exponent<= exponent + 121;
with is_not_zero  select   extended_is_not_zero <= 
   "000000000" when '0', 
   "111111111" when '1', 
   "---------" when others;
final_biased_exponent<= extended_is_not_zero and biased_exponent;
round<= '0';
sticky<= '0';
O <= is_NAR & s & final_biased_exponent & implicit_bit & fraction & round & sticky;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                 RightShifterSticky31_by_max_31_comb_uid14
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky31_by_max_31_comb_uid14 is
    port (X : in  std_logic_vector(30 downto 0);
          S : in  std_logic_vector(4 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(30 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky31_by_max_31_comb_uid14 is
signal ps :  std_logic_vector(4 downto 0);
signal Xpadded :  std_logic_vector(30 downto 0);
signal level5 :  std_logic_vector(30 downto 0);
signal stk4 :  std_logic;
signal level4 :  std_logic_vector(30 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(30 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(30 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(30 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(30 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level5<= Xpadded;
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1')   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(30 downto 16);
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(30 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(30 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(30 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(30 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                     Normalizer_ZO_33_33_63_comb_uid16
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_33_33_63_comb_uid16 is
    port (X : in  std_logic_vector(32 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(5 downto 0);
          R : out  std_logic_vector(32 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_33_33_63_comb_uid16 is
signal level6 :  std_logic_vector(32 downto 0);
signal sozb :  std_logic;
signal count5 :  std_logic;
signal level5 :  std_logic_vector(32 downto 0);
signal count4 :  std_logic;
signal level4 :  std_logic_vector(32 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(32 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(32 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(32 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(32 downto 0);
signal sCount :  std_logic_vector(5 downto 0);
begin
   level6 <= X ;
   sozb<= OZb;
   count5<= '1' when level6(32 downto 1) = (32 downto 1=>sozb) else '0';
   level5<= level6(32 downto 0) when count5='0' else level6(0 downto 0) & (31 downto 0 => '0');

   count4<= '1' when level5(32 downto 17) = (32 downto 17=>sozb) else '0';
   level4<= level5(32 downto 0) when count4='0' else level5(16 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(32 downto 25) = (32 downto 25=>sozb) else '0';
   level3<= level4(32 downto 0) when count3='0' else level4(24 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(32 downto 29) = (32 downto 29=>sozb) else '0';
   level2<= level3(32 downto 0) when count2='0' else level3(28 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(32 downto 31) = (32 downto 31=>sozb) else '0';
   level1<= level2(32 downto 0) when count1='0' else level2(30 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(32 downto 32) = (32 downto 32=>sozb) else '0';
   level0<= level1(32 downto 0) when count0='0' else level1(31 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count5 & count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                           PIFAdd_9_27_comb_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Oregane Desrentes 2019
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PIFAdd_9_27_comb_uid12 is
    port (X : in  std_logic_vector(40 downto 0);
          Y : in  std_logic_vector(40 downto 0);
          R : out  std_logic_vector(40 downto 0)   );
end entity;

architecture arch of PIFAdd_9_27_comb_uid12 is
   component RightShifterSticky31_by_max_31_comb_uid14 is
      port ( X : in  std_logic_vector(30 downto 0);
             S : in  std_logic_vector(4 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(30 downto 0);
             Sticky : out  std_logic   );
   end component;

   component Normalizer_ZO_33_33_63_comb_uid16 is
      port ( X : in  std_logic_vector(32 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(5 downto 0);
             R : out  std_logic_vector(32 downto 0)   );
   end component;

signal X_is_NAR :  std_logic;
signal X_s :  std_logic;
signal X_exponent :  std_logic_vector(8 downto 0);
signal X_fraction :  std_logic_vector(27 downto 0);
signal Y_is_NAR :  std_logic;
signal Y_s :  std_logic;
signal Y_exponent :  std_logic_vector(8 downto 0);
signal Y_fraction :  std_logic_vector(27 downto 0);
signal is_larger_exp :  std_logic;
signal larger_exp :  std_logic_vector(8 downto 0);
signal smaller_exp :  std_logic_vector(8 downto 0);
signal larger_mantissa :  std_logic_vector(28 downto 0);
signal smaller_mantissa :  std_logic_vector(28 downto 0);
signal larger_sign :  std_logic;
signal pad :  std_logic;
signal offset :  std_logic_vector(9 downto 0);
signal sup_offset :  std_logic_vector(4 downto 0);
signal saturate :  std_logic;
signal inf_offset :  std_logic_vector(4 downto 0);
signal input_shifter :  std_logic_vector(30 downto 0);
signal shifted_frac :  std_logic_vector(30 downto 0);
signal sticky :  std_logic;
signal shifted_frac_trunc :  std_logic_vector(29 downto 0);
signal padded_larger_mantissa :  std_logic_vector(30 downto 0);
signal add_mantissa :  std_logic_vector(32 downto 0);
signal count_type :  std_logic;
signal lzCount :  std_logic_vector(5 downto 0);
signal significand :  std_logic_vector(32 downto 0);
signal exponent :  std_logic_vector(8 downto 0);
signal round :  std_logic;
signal not_sticky :  std_logic;
signal pre_is_zero :  std_logic;
signal fraction :  std_logic_vector(27 downto 0);
signal fraction_is_zero :  std_logic;
signal is_zero :  std_logic;
signal s :  std_logic;
signal final_exponent :  std_logic_vector(8 downto 0);
signal is_NAR :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
X_is_NAR<= X(40);
X_s<= X(39);
X_exponent<= X(38 downto 30);
X_fraction<= X(29 downto 2);
Y_is_NAR<= Y(40);
Y_s<= Y(39);
Y_exponent<= Y(38 downto 30);
Y_fraction<= Y(29 downto 2);
is_larger_exp<= '1' when X_exponent > Y_exponent else '0';
with is_larger_exp  select  larger_exp<= 
   X_exponent when '1',
   Y_exponent when '0',
   "---------" when others;
with is_larger_exp  select  smaller_exp<= 
   Y_exponent when '1',
   X_exponent when '0',
   "---------" when others;
with is_larger_exp  select  larger_mantissa<= 
   X_s & X_fraction when '1',
   Y_s & Y_fraction when '0',
   "-----------------------------" when others;
with is_larger_exp  select  smaller_mantissa<= 
   Y_s & Y_fraction when '1',
   X_s & X_fraction when '0',
   "-----------------------------" when others;
with is_larger_exp  select  larger_sign<= 
   X_s when '1',
   Y_s when '0',
   '-' when others;
with is_larger_exp  select  pad<= 
   Y_s when '1',
   X_s when '0',
   '-' when others;
offset <= ('0' & larger_exp) - ('0' & smaller_exp);
sup_offset <= offset(9 downto 5);
saturate <= '0' when sup_offset = "00000" else '1';
with saturate  select  inf_offset<=
   "11111" when '1',
   offset(4 downto 0) when '0',
   "-----" when others;
input_shifter <= smaller_mantissa & "00";
   mantissa_shift: RightShifterSticky31_by_max_31_comb_uid14
      port map ( S => inf_offset,
                 X => input_shifter,
                 padBit => pad,
                 R => shifted_frac,
                 Sticky => sticky);
shifted_frac_trunc<= shifted_frac(30 downto 1);
with larger_sign  select  padded_larger_mantissa<= 
   "0" & larger_mantissa & '0' when '0',
   "1" & larger_mantissa & '0' when '1',
   "-------------------------------" when others;
add_mantissa<= ((padded_larger_mantissa) + (pad & shifted_frac_trunc)) & shifted_frac(0) & sticky;
count_type<= add_mantissa(32);
   norm: Normalizer_ZO_33_33_63_comb_uid16
      port map ( OZb => count_type,
                 X => add_mantissa,
                 Count => lzCount,
                 R => significand);
exponent <= larger_exp + 2 - lzCount;
round<= significand(4);
not_sticky<= '1' when significand(3 downto 0) = "0000" else '0';
pre_is_zero<= (not round) or (not_sticky and round);
fraction<= significand(32 downto 5);
fraction_is_zero<= '1' when fraction = "0000000000000000000000000000" else '0';
is_zero<= not count_type and fraction_is_zero and pre_is_zero;
with is_zero  select  s<= 
   '0' when '1',
   not fraction(27) when '0',
   '-' when others;
with is_zero  select  final_exponent<= 
   "000000000" when '1',
   exponent when '0',
   "000000000" when others;
is_NAR <= X(40) or Y(40);
R <= is_NAR & s & final_exponent & fraction & round & (not not_sticky);
end architecture;

--------------------------------------------------------------------------------
--                 RightShifterSticky32_by_max_32_comb_uid20
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky32_by_max_32_comb_uid20 is
    port (X : in  std_logic_vector(31 downto 0);
          S : in  std_logic_vector(5 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(31 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky32_by_max_32_comb_uid20 is
signal ps :  std_logic_vector(5 downto 0);
signal Xpadded :  std_logic_vector(31 downto 0);
signal level6 :  std_logic_vector(31 downto 0);
signal stk5 :  std_logic;
signal level5 :  std_logic_vector(31 downto 0);
signal stk4 :  std_logic;
signal level4 :  std_logic_vector(31 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(31 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(31 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(31 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(31 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level6<= Xpadded;
   stk5 <= '1' when (level6(31 downto 0)/="00000000000000000000000000000000" and ps(5)='1')   else '0';
   level5 <=  level6 when  ps(5)='0'    else (31 downto 0 => padBit) ;
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1') or stk5 ='1'   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(31 downto 16);
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(31 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(31 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(31 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(31 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                         PIF2Posit_32_2_comb_uid18
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Oregane Desrentes 2019
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: I
-- Output signals: O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PIF2Posit_32_2_comb_uid18 is
    port (I : in  std_logic_vector(40 downto 0);
          O : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of PIF2Posit_32_2_comb_uid18 is
   component RightShifterSticky32_by_max_32_comb_uid20 is
      port ( X : in  std_logic_vector(31 downto 0);
             S : in  std_logic_vector(5 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(31 downto 0);
             Sticky : out  std_logic   );
   end component;

signal is_NAR :  std_logic;
signal s :  std_logic;
signal biased_exponent :  std_logic_vector(8 downto 0);
signal fraction :  std_logic_vector(27 downto 0);
signal is_zero :  std_logic;
signal exponent :  std_logic_vector(8 downto 0);
signal partial_exponent :  std_logic_vector(1 downto 0);
signal partial_exponent_us :  std_logic_vector(1 downto 0);
signal bin_regime :  std_logic_vector(5 downto 0);
signal first_regime :  std_logic;
signal regime :  std_logic_vector(5 downto 0);
signal pad :  std_logic;
signal start_regime :  std_logic_vector(1 downto 0);
signal input_shifter :  std_logic_vector(31 downto 0);
signal extended_posit :  std_logic_vector(31 downto 0);
signal pre_sticky :  std_logic;
signal truncated_posit :  std_logic_vector(30 downto 0);
signal lsb :  std_logic;
signal guard :  std_logic;
signal sticky :  std_logic;
signal round_bit :  std_logic;
signal rounded_reg_exp_frac :  std_logic_vector(30 downto 0);
signal rounded_posit :  std_logic_vector(31 downto 0);
signal rounded_posit_zero :  std_logic_vector(31 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
is_NAR<= I(40);
s<= I(39);
biased_exponent<= I(38 downto 30);
fraction<= I(28 downto 1);
is_zero<= '1' when I(40 downto 0) = "00000000000000000000000000000000000000000" else '0';
exponent<= biased_exponent - 121;
partial_exponent<= exponent(1 downto 0);
with s  select  partial_exponent_us <= 
   partial_exponent when '0',
   not partial_exponent when '1',
   "--" when others;
bin_regime<= exponent(7 downto 2);
first_regime<= exponent(8);
with first_regime  select  regime <= 
   bin_regime when '0', 
   not bin_regime when '1', 
   "------" when others;
pad<= not(first_regime xor s);
with pad  select  start_regime <= 
   "01" when '0', 
   "10" when '1', 
   "--" when others;
input_shifter<= start_regime & partial_exponent_us & fraction;
   rshift: RightShifterSticky32_by_max_32_comb_uid20
      port map ( S => regime,
                 X => input_shifter,
                 padBit => pad,
                 R => extended_posit,
                 Sticky => pre_sticky);
truncated_posit<= extended_posit(31 downto 1);
lsb<= extended_posit(1);
guard<= extended_posit(0);
sticky<= I(0) or pre_sticky;
round_bit<= guard and (sticky or lsb);
rounded_reg_exp_frac<= truncated_posit + round_bit;
rounded_posit<= s & rounded_reg_exp_frac;
rounded_posit_zero<= rounded_posit when is_zero= '0' else "00000000000000000000000000000000";
O <= rounded_posit_zero when is_NAR = '0' else "10000000000000000000000000000000";
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                          PositAdd_32_2_comb_uid2
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Oregane Desrentes 2019
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositAdd_32_2_comb_uid2 is
    port (X : in  std_logic_vector(31 downto 0);
          Y : in  std_logic_vector(31 downto 0);
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of PositAdd_32_2_comb_uid2 is
   component Posit2PIF_32_2_comb_uid4 is
      port ( I : in  std_logic_vector(31 downto 0);
             O : out  std_logic_vector(40 downto 0)   );
   end component;

   component Posit2PIF_32_2_comb_uid8 is
      port ( I : in  std_logic_vector(31 downto 0);
             O : out  std_logic_vector(40 downto 0)   );
   end component;

   component PIFAdd_9_27_comb_uid12 is
      port ( X : in  std_logic_vector(40 downto 0);
             Y : in  std_logic_vector(40 downto 0);
             R : out  std_logic_vector(40 downto 0)   );
   end component;

   component PIF2Posit_32_2_comb_uid18 is
      port ( I : in  std_logic_vector(40 downto 0);
             O : out  std_logic_vector(31 downto 0)   );
   end component;

signal X_PIF :  std_logic_vector(40 downto 0);
signal Y_PIF :  std_logic_vector(40 downto 0);
signal R_PIF :  std_logic_vector(40 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
   X_conversion: Posit2PIF_32_2_comb_uid4
      port map ( I => X,
                 O => X_PIF);
   Y_conversion: Posit2PIF_32_2_comb_uid8
      port map ( I => Y,
                 O => Y_PIF);
   Addition: PIFAdd_9_27_comb_uid12
      port map ( X => X_PIF,
                 Y => Y_PIF,
                 R => R_PIF);
   R_conversion: PIF2Posit_32_2_comb_uid18
      port map ( I => R_PIF,
                 O => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;


--------------------------------------------------
-- Module: Posit Mult
--------------------------------------------------

--------------------------------------------------------------------------------
--                 LZOCShifter_30_to_30_counting_32_F400_uid6
-- VHDL generated for Kintex7 @ 400MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles
-- Clock period (ns): 2.5
-- Target frequency (MHz): 400
-- Input signals: I OZb
-- Output signals: Count O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LZOCShifter_30_to_30_counting_32_F400_uid6 is
    port (clk : in std_logic;
          I : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          O : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of LZOCShifter_30_to_30_counting_32_F400_uid6 is
signal level5, level5_d1 :  std_logic_vector(29 downto 0);
signal sozb, sozb_d1, sozb_d2, sozb_d3, sozb_d4 :  std_logic;
signal count4, count4_d1, count4_d2, count4_d3 :  std_logic;
signal level4, level4_d1 :  std_logic_vector(29 downto 0);
signal count3, count3_d1, count3_d2 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2, count2_d1, count2_d2 :  std_logic;
signal level2, level2_d1 :  std_logic_vector(29 downto 0);
signal count1, count1_d1 :  std_logic;
signal level1, level1_d1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            level5_d1 <=  level5;
            sozb_d1 <=  sozb;
            sozb_d2 <=  sozb_d1;
            sozb_d3 <=  sozb_d2;
            sozb_d4 <=  sozb_d3;
            count4_d1 <=  count4;
            count4_d2 <=  count4_d1;
            count4_d3 <=  count4_d2;
            level4_d1 <=  level4;
            count3_d1 <=  count3;
            count3_d2 <=  count3_d1;
            count2_d1 <=  count2;
            count2_d2 <=  count2_d1;
            level2_d1 <=  level2;
            count1_d1 <=  count1;
            level1_d1 <=  level1;
         end if;
      end process;
   level5 <= I ;
   sozb<= OZb;
   count4<= '1' when level5_d1(29 downto 14) = (29 downto 14=>sozb_d1) else '0';
   level4<= level5_d1(29 downto 0) when count4='0' else level5_d1(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4_d1(29 downto 22) = (29 downto 22=>sozb_d2) else '0';
   level3<= level4_d1(29 downto 0) when count3='0' else level4_d1(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb_d2) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2_d1(29 downto 28) = (29 downto 28=>sozb_d3) else '0';
   level1<= level2_d1(29 downto 0) when count1='0' else level2_d1(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1_d1(29 downto 29) = (29 downto 29=>sozb_d4) else '0';
   level0<= level1_d1(29 downto 0) when count0='0' else level1_d1(28 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count4_d3 & count3_d2 & count2_d2 & count1_d1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                        PositDecoder_32_2_F400_uid4
-- VHDL generated for Kintex7 @ 400MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles
-- Clock period (ns): 2.5
-- Target frequency (MHz): 400
-- Input signals: Input
-- Output signals: Sign Reg Exp Frac z inf Abs_in

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder_32_2_F400_uid4 is
    port (clk : in std_logic;
          Input : in  std_logic_vector(31 downto 0);
          Sign : out  std_logic;
          Reg : out  std_logic_vector(5 downto 0);
          Exp : out  std_logic_vector(1 downto 0);
          Frac : out  std_logic_vector(27 downto 0);
          z : out  std_logic;
          inf : out  std_logic;
          Abs_in : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of PositDecoder_32_2_F400_uid4 is
   component LZOCShifter_30_to_30_counting_32_F400_uid6 is
      port ( clk : in std_logic;
             I : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             O : out  std_logic_vector(29 downto 0)   );
   end component;

signal s :  std_logic;
signal nzero, nzero_d1, nzero_d2, nzero_d3, nzero_d4 :  std_logic;
signal is_zero :  std_logic;
signal is_NAR :  std_logic;
signal rep_sign :  std_logic_vector(30 downto 0);
signal twos :  std_logic_vector(30 downto 0);
signal rc, rc_d1, rc_d2, rc_d3, rc_d4 :  std_logic;
signal remainder :  std_logic_vector(29 downto 0);
signal lzCount :  std_logic_vector(4 downto 0);
signal usefulBits :  std_logic_vector(29 downto 0);
signal final_reg :  std_logic_vector(5 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            nzero_d1 <=  nzero;
            nzero_d2 <=  nzero_d1;
            nzero_d3 <=  nzero_d2;
            nzero_d4 <=  nzero_d3;
            rc_d1 <=  rc;
            rc_d2 <=  rc_d1;
            rc_d3 <=  rc_d2;
            rc_d4 <=  rc_d3;
         end if;
      end process;
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Extract Sign bit -------------------------------
s <= Input(31);
Sign <= s;
-------------------------------- Special Cases --------------------------------
nzero <= Input(30) when Input(29 downto 0) = "000000000000000000000000000000" else '1';
   -- 1 if Input is zero
is_zero <= s NOR nzero;
z <= is_zero;
   -- 1 if Input is infinity
is_NAR<= s AND (NOT nzero);
inf <= is_NAR;
--------------------------- 2's Complement of Input ---------------------------
rep_sign <= (others => s);
twos <= (rep_sign XOR Input(30 downto 0)) + s;
rc <= twos(twos'high);
----------------- Count leading zeros of regime & shift it out -----------------
remainder<= twos(29 downto 0);
   lzoc: LZOCShifter_30_to_30_counting_32_F400_uid6
      port map ( clk  => clk,
                 I => remainder,
                 OZb => rc,
                 Count => lzCount,
                 O => usefulBits);
------------------------ Extract fraction and exponent ------------------------
Frac <= nzero_d4 & usefulBits(26 downto 0);
Exp <= usefulBits(28 downto 27);
-------------------------------- Select regime --------------------------------
with rc_d4  select  final_reg<= 
   "0" & lzCount when '1',
   NOT("0" & lzCount)  when '0',
   "------" when others;
Reg <= final_reg;
Abs_in <= twos;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                LZOCShifter_30_to_30_counting_32_F400_uid10
-- VHDL generated for Kintex7 @ 400MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2016)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles
-- Clock period (ns): 2.5
-- Target frequency (MHz): 400
-- Input signals: I OZb
-- Output signals: Count O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LZOCShifter_30_to_30_counting_32_F400_uid10 is
    port (clk : in std_logic;
          I : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          O : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of LZOCShifter_30_to_30_counting_32_F400_uid10 is
signal level5, level5_d1 :  std_logic_vector(29 downto 0);
signal sozb, sozb_d1, sozb_d2, sozb_d3, sozb_d4 :  std_logic;
signal count4, count4_d1, count4_d2, count4_d3 :  std_logic;
signal level4, level4_d1 :  std_logic_vector(29 downto 0);
signal count3, count3_d1, count3_d2 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2, count2_d1, count2_d2 :  std_logic;
signal level2, level2_d1 :  std_logic_vector(29 downto 0);
signal count1, count1_d1 :  std_logic;
signal level1, level1_d1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            level5_d1 <=  level5;
            sozb_d1 <=  sozb;
            sozb_d2 <=  sozb_d1;
            sozb_d3 <=  sozb_d2;
            sozb_d4 <=  sozb_d3;
            count4_d1 <=  count4;
            count4_d2 <=  count4_d1;
            count4_d3 <=  count4_d2;
            level4_d1 <=  level4;
            count3_d1 <=  count3;
            count3_d2 <=  count3_d1;
            count2_d1 <=  count2;
            count2_d2 <=  count2_d1;
            level2_d1 <=  level2;
            count1_d1 <=  count1;
            level1_d1 <=  level1;
         end if;
      end process;
   level5 <= I ;
   sozb<= OZb;
   count4<= '1' when level5_d1(29 downto 14) = (29 downto 14=>sozb_d1) else '0';
   level4<= level5_d1(29 downto 0) when count4='0' else level5_d1(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4_d1(29 downto 22) = (29 downto 22=>sozb_d2) else '0';
   level3<= level4_d1(29 downto 0) when count3='0' else level4_d1(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb_d2) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2_d1(29 downto 28) = (29 downto 28=>sozb_d3) else '0';
   level1<= level2_d1(29 downto 0) when count1='0' else level2_d1(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1_d1(29 downto 29) = (29 downto 29=>sozb_d4) else '0';
   level0<= level1_d1(29 downto 0) when count0='0' else level1_d1(28 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count4_d3 & count3_d2 & count2_d2 & count1_d1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                        PositDecoder_32_2_F400_uid8
-- VHDL generated for Kintex7 @ 400MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles
-- Clock period (ns): 2.5
-- Target frequency (MHz): 400
-- Input signals: Input
-- Output signals: Sign Reg Exp Frac z inf Abs_in

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder_32_2_F400_uid8 is
    port (clk : in std_logic;
          Input : in  std_logic_vector(31 downto 0);
          Sign : out  std_logic;
          Reg : out  std_logic_vector(5 downto 0);
          Exp : out  std_logic_vector(1 downto 0);
          Frac : out  std_logic_vector(27 downto 0);
          z : out  std_logic;
          inf : out  std_logic;
          Abs_in : out  std_logic_vector(30 downto 0)   );
end entity;

architecture arch of PositDecoder_32_2_F400_uid8 is
   component LZOCShifter_30_to_30_counting_32_F400_uid10 is
      port ( clk : in std_logic;
             I : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             O : out  std_logic_vector(29 downto 0)   );
   end component;

signal s :  std_logic;
signal nzero, nzero_d1, nzero_d2, nzero_d3, nzero_d4 :  std_logic;
signal is_zero :  std_logic;
signal is_NAR :  std_logic;
signal rep_sign :  std_logic_vector(30 downto 0);
signal twos :  std_logic_vector(30 downto 0);
signal rc, rc_d1, rc_d2, rc_d3, rc_d4 :  std_logic;
signal remainder :  std_logic_vector(29 downto 0);
signal lzCount :  std_logic_vector(4 downto 0);
signal usefulBits :  std_logic_vector(29 downto 0);
signal final_reg :  std_logic_vector(5 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            nzero_d1 <=  nzero;
            nzero_d2 <=  nzero_d1;
            nzero_d3 <=  nzero_d2;
            nzero_d4 <=  nzero_d3;
            rc_d1 <=  rc;
            rc_d2 <=  rc_d1;
            rc_d3 <=  rc_d2;
            rc_d4 <=  rc_d3;
         end if;
      end process;
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Extract Sign bit -------------------------------
s <= Input(31);
Sign <= s;
-------------------------------- Special Cases --------------------------------
nzero <= Input(30) when Input(29 downto 0) = "000000000000000000000000000000" else '1';
   -- 1 if Input is zero
is_zero <= s NOR nzero;
z <= is_zero;
   -- 1 if Input is infinity
is_NAR<= s AND (NOT nzero);
inf <= is_NAR;
--------------------------- 2's Complement of Input ---------------------------
rep_sign <= (others => s);
twos <= (rep_sign XOR Input(30 downto 0)) + s;
rc <= twos(twos'high);
----------------- Count leading zeros of regime & shift it out -----------------
remainder<= twos(29 downto 0);
   lzoc: LZOCShifter_30_to_30_counting_32_F400_uid10
      port map ( clk  => clk,
                 I => remainder,
                 OZb => rc,
                 Count => lzCount,
                 O => usefulBits);
------------------------ Extract fraction and exponent ------------------------
Frac <= nzero_d4 & usefulBits(26 downto 0);
Exp <= usefulBits(28 downto 27);
-------------------------------- Select regime --------------------------------
with rc_d4  select  final_reg<= 
   "0" & lzCount when '1',
   NOT("0" & lzCount)  when '0',
   "------" when others;
Reg <= final_reg;
Abs_in <= twos;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                 RightShifterSticky59_by_max_31_F400_uid12
-- VHDL generated for Kintex7 @ 400MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles
-- Clock period (ns): 2.5
-- Target frequency (MHz): 400
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky59_by_max_31_F400_uid12 is
    port (clk : in std_logic;
          X : in  std_logic_vector(58 downto 0);
          S : in  std_logic_vector(4 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(58 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky59_by_max_31_F400_uid12 is
signal ps, ps_d1, ps_d2 :  std_logic_vector(4 downto 0);
signal level5, level5_d1 :  std_logic_vector(58 downto 0);
signal stk4, stk4_d1 :  std_logic;
signal level4, level4_d1 :  std_logic_vector(58 downto 0);
signal stk3 :  std_logic;
signal level3, level3_d1 :  std_logic_vector(58 downto 0);
signal stk2, stk2_d1 :  std_logic;
signal level2, level2_d1, level2_d2 :  std_logic_vector(58 downto 0);
signal stk1 :  std_logic;
signal level1, level1_d1, level1_d2 :  std_logic_vector(58 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(58 downto 0);
signal padBit_d1 :  std_logic;
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            ps_d1 <=  ps;
            ps_d2 <=  ps_d1;
            level5_d1 <=  level5;
            stk4_d1 <=  stk4;
            level4_d1 <=  level4;
            level3_d1 <=  level3;
            stk2_d1 <=  stk2;
            level2_d1 <=  level2;
            level2_d2 <=  level2_d1;
            level1_d1 <=  level1;
            level1_d2 <=  level1_d1;
            padBit_d1 <=  padBit;
         end if;
      end process;
   ps<= S;
   level5<= X;
   stk4 <= '1' when (level5_d1(15 downto 0)/="0000000000000000" and ps(4)='1')   else '0';
   level4 <=  level5_d1 when  ps(4)='0'    else (15 downto 0 => padBit_d1) & level5_d1(58 downto 16);
   stk3 <= '1' when (level4_d1(7 downto 0)/="00000000" and ps_d1(3)='1') or stk4_d1 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit_d1) & level4(58 downto 8);
   stk2 <= '1' when (level3_d1(3 downto 0)/="0000" and ps_d1(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit_d1) & level3(58 downto 4);
   stk1 <= '1' when (level2_d2(1 downto 0)/="00" and ps_d2(1)='1') or stk2_d1 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit_d1) & level2(58 downto 2);
   stk0 <= '1' when (level1_d2(0 downto 0)/="0" and ps_d2(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit_d1) & level1(58 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                          PositMult_32_2_F400_uid2
-- VHDL generated for Kintex7 @ 400MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- Pipeline depth: 10 cycles
-- Clock period (ns): 2.5
-- Target frequency (MHz): 400
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositMult_32_2_F400_uid2 is
    port (clk : in std_logic;
          X : in  std_logic_vector(31 downto 0);
          Y : in  std_logic_vector(31 downto 0);
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of PositMult_32_2_F400_uid2 is
   component PositDecoder_32_2_F400_uid4 is
      port ( clk : in std_logic;
             Input : in  std_logic_vector(31 downto 0);
             Sign : out  std_logic;
             Reg : out  std_logic_vector(5 downto 0);
             Exp : out  std_logic_vector(1 downto 0);
             Frac : out  std_logic_vector(27 downto 0);
             z : out  std_logic;
             inf : out  std_logic;
             Abs_in : out  std_logic_vector(30 downto 0)   );
   end component;

   component PositDecoder_32_2_F400_uid8 is
      port ( clk : in std_logic;
             Input : in  std_logic_vector(31 downto 0);
             Sign : out  std_logic;
             Reg : out  std_logic_vector(5 downto 0);
             Exp : out  std_logic_vector(1 downto 0);
             Frac : out  std_logic_vector(27 downto 0);
             z : out  std_logic;
             inf : out  std_logic;
             Abs_in : out  std_logic_vector(30 downto 0)   );
   end component;

   component RightShifterSticky59_by_max_31_F400_uid12 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(58 downto 0);
             S : in  std_logic_vector(4 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(58 downto 0);
             Sticky : out  std_logic   );
   end component;

signal sign_X :  std_logic;
signal reg_X :  std_logic_vector(5 downto 0);
signal exp_X :  std_logic_vector(1 downto 0);
signal frac_X :  std_logic_vector(27 downto 0);
signal z_X, z_X_d1 :  std_logic;
signal inf_X, inf_X_d1 :  std_logic;
signal sign_Y :  std_logic;
signal reg_Y :  std_logic_vector(5 downto 0);
signal exp_Y :  std_logic_vector(1 downto 0);
signal frac_Y :  std_logic_vector(27 downto 0);
signal z_Y, z_Y_d1 :  std_logic;
signal inf_Y, inf_Y_d1 :  std_logic;
signal sf_X :  std_logic_vector(7 downto 0);
signal sf_Y :  std_logic_vector(7 downto 0);
signal sign, sign_d1, sign_d2, sign_d3, sign_d4, sign_d5, sign_d6, sign_d7, sign_d8, sign_d9, sign_d10 :  std_logic;
signal z, z_d1, z_d2, z_d3, z_d4, z_d5, z_d6, z_d7, z_d8, z_d9 :  std_logic;
signal inf, inf_d1, inf_d2, inf_d3, inf_d4, inf_d5, inf_d6, inf_d7, inf_d8, inf_d9 :  std_logic;
signal frac_mult, frac_mult_d1 :  std_logic_vector(55 downto 0);
signal ovf_m :  std_logic;
signal normFrac, normFrac_d1 :  std_logic_vector(56 downto 0);
signal sf_mult :  std_logic_vector(8 downto 0);
signal sf_sign, sf_sign_d1, sf_sign_d2 :  std_logic;
signal nzero :  std_logic;
signal FinalExp, FinalExp_d1 :  std_logic_vector(1 downto 0);
signal RegimeAns_tmp :  std_logic_vector(5 downto 0);
signal RegimeAns, RegimeAns_d1 :  std_logic_vector(5 downto 0);
signal reg_ovf, reg_ovf_d1, reg_ovf_d2, reg_ovf_d3, reg_ovf_d4 :  std_logic;
signal FinalRegime, FinalRegime_d1 :  std_logic_vector(5 downto 0);
signal input_shifter :  std_logic_vector(58 downto 0);
signal shift_offset :  std_logic_vector(4 downto 0);
signal pad :  std_logic;
signal shifted_frac, shifted_frac_d1, shifted_frac_d2, shifted_frac_d3 :  std_logic_vector(58 downto 0);
signal S_bit_tmp, S_bit_tmp_d1 :  std_logic;
signal tmp_ans, tmp_ans_d1, tmp_ans_d2, tmp_ans_d3, tmp_ans_d4 :  std_logic_vector(30 downto 0);
signal LSB, LSB_d1, LSB_d2, LSB_d3 :  std_logic;
signal G_bit, G_bit_d1, G_bit_d2, G_bit_d3 :  std_logic;
signal R_bit, R_bit_d1, R_bit_d2, R_bit_d3 :  std_logic;
signal S_bit :  std_logic;
signal round, round_d1 :  std_logic;
signal result :  std_logic_vector(31 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            z_X_d1 <=  z_X;
            inf_X_d1 <=  inf_X;
            z_Y_d1 <=  z_Y;
            inf_Y_d1 <=  inf_Y;
            sign_d1 <=  sign;
            sign_d2 <=  sign_d1;
            sign_d3 <=  sign_d2;
            sign_d4 <=  sign_d3;
            sign_d5 <=  sign_d4;
            sign_d6 <=  sign_d5;
            sign_d7 <=  sign_d6;
            sign_d8 <=  sign_d7;
            sign_d9 <=  sign_d8;
            sign_d10 <=  sign_d9;
            z_d1 <=  z;
            z_d2 <=  z_d1;
            z_d3 <=  z_d2;
            z_d4 <=  z_d3;
            z_d5 <=  z_d4;
            z_d6 <=  z_d5;
            z_d7 <=  z_d6;
            z_d8 <=  z_d7;
            z_d9 <=  z_d8;
            inf_d1 <=  inf;
            inf_d2 <=  inf_d1;
            inf_d3 <=  inf_d2;
            inf_d4 <=  inf_d3;
            inf_d5 <=  inf_d4;
            inf_d6 <=  inf_d5;
            inf_d7 <=  inf_d6;
            inf_d8 <=  inf_d7;
            inf_d9 <=  inf_d8;
            frac_mult_d1 <=  frac_mult;
            normFrac_d1 <=  normFrac;
            sf_sign_d1 <=  sf_sign;
            sf_sign_d2 <=  sf_sign_d1;
            FinalExp_d1 <=  FinalExp;
            RegimeAns_d1 <=  RegimeAns;
            reg_ovf_d1 <=  reg_ovf;
            reg_ovf_d2 <=  reg_ovf_d1;
            reg_ovf_d3 <=  reg_ovf_d2;
            reg_ovf_d4 <=  reg_ovf_d3;
            FinalRegime_d1 <=  FinalRegime;
            shifted_frac_d1 <=  shifted_frac;
            shifted_frac_d2 <=  shifted_frac_d1;
            shifted_frac_d3 <=  shifted_frac_d2;
            S_bit_tmp_d1 <=  S_bit_tmp;
            tmp_ans_d1 <=  tmp_ans;
            tmp_ans_d2 <=  tmp_ans_d1;
            tmp_ans_d3 <=  tmp_ans_d2;
            tmp_ans_d4 <=  tmp_ans_d3;
            LSB_d1 <=  LSB;
            LSB_d2 <=  LSB_d1;
            LSB_d3 <=  LSB_d2;
            G_bit_d1 <=  G_bit;
            G_bit_d2 <=  G_bit_d1;
            G_bit_d3 <=  G_bit_d2;
            R_bit_d1 <=  R_bit;
            R_bit_d2 <=  R_bit_d1;
            R_bit_d3 <=  R_bit_d2;
            round_d1 <=  round;
         end if;
      end process;
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Data Extraction -------------------------------
   X_decoder: PositDecoder_32_2_F400_uid4
      port map ( clk  => clk,
                 Input => X,
                 Abs_in => open,
                 Exp => exp_X,
                 Frac => frac_X,
                 Reg => reg_X,
                 Sign => sign_X,
                 inf => inf_X,
                 z => z_X);
   Y_decoder: PositDecoder_32_2_F400_uid8
      port map ( clk  => clk,
                 Input => Y,
                 Abs_in => open,
                 Exp => exp_Y,
                 Frac => frac_Y,
                 Reg => reg_Y,
                 Sign => sign_Y,
                 inf => inf_Y,
                 z => z_Y);
   -- Gather scale factors
sf_X <= reg_X & exp_X;
sf_Y <= reg_Y & exp_Y;
---------------------- Sign and Special Cases Computation ----------------------
sign <= sign_X XOR sign_Y;
z <= z_X_d1 OR z_Y_d1;
inf <= inf_X_d1 OR inf_Y_d1;
--------------- Multiply the fractions & add the exponent values ---------------
frac_mult <= frac_X * frac_Y;
   -- Adjust for overflow
ovf_m <= frac_mult(frac_mult'high);
with ovf_m  select  normFrac<= 
   frac_mult & '0' when '0',
   '0' & frac_mult when '1',
   "---------------------------------------------------------" when others;
sf_mult <= (sf_X(sf_X'high) & sf_X) + (sf_Y(sf_Y'high) & sf_Y) + ovf_m;
sf_sign <= sf_mult(sf_mult'high);
---------------------- Compute Regime and Exponent value ----------------------
nzero <= '0' when frac_mult_d1 = "00000000000000000000000000000000000000000000000000000000" else '1';
   -- Unpack scaling factors
FinalExp <= sf_mult(1 downto 0);
RegimeAns_tmp <= sf_mult(7 downto 2);
   -- Get Regime's absolute value
with sf_sign  select  RegimeAns<=
   (NOT RegimeAns_tmp) + 1 when '1',
   RegimeAns_tmp when '0',
   "------" when others;
   -- Check for Regime overflow
reg_ovf <= '1' when RegimeAns_d1 > "011110" else '0';
with reg_ovf  select  FinalRegime <=
   "011110" when '1',
   RegimeAns_d1 when '0',
   "------" when others;
------------------------------- Packing Stage 1 -------------------------------
with sf_sign_d1  select  input_shifter<=
   '0' & nzero    & FinalExp_d1    & normFrac_d1(54 downto 0) when '1',
   nzero & '0'    & FinalExp_d1    & normFrac_d1(54 downto 0) when '0',
   "-----------------------------------------------------------" when others;
with sf_sign_d2  select  shift_offset <=
   FinalRegime_d1(4 downto 0) - 1 when '1',
   FinalRegime_d1(4 downto 0) when '0',
   "-----" when others;
pad<= input_shifter(input_shifter'high);
   right_signed_shifter: RightShifterSticky59_by_max_31_F400_uid12
      port map ( clk  => clk,
                 S => shift_offset,
                 X => input_shifter,
                 padBit => pad,
                 R => shifted_frac,
                 Sticky => S_bit_tmp);
tmp_ans <= shifted_frac(58 downto 28);
--------------------- Packing Stage 2 - Unbiased Rounding ---------------------
LSB <= shifted_frac(28);
G_bit <= shifted_frac(27);
R_bit <= shifted_frac(26);
S_bit <= S_bit_tmp_d1 when shifted_frac_d3(25 downto 0) = "00000000000000000000000000" else '1';
with reg_ovf_d4  select  round<=
   '0' when '1',
   G_bit_d3 AND (LSB_d3 OR R_bit_d3 OR S_bit) when '0',
   '-' when others;
with sign_d10  select  result<=
   '0' & (tmp_ans_d4 + round_d1) when '0',
   '1' & ((NOT(tmp_ans_d4 + round_d1))+1) when '1',
   "--------------------------------" when others;
R <= '1' & "0000000000000000000000000000000" when inf_d9 = '1' else 
   "00000000000000000000000000000000" when z_d9 = '1' else
    result;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------
-- Module: Mux
--------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux9to1 is
    Port ( S : in  STD_LOGIC_VECTOR (3 downto 0);
           A0, A1, A2, A3, A4, A5, A6, A7, A8 : in  STD_LOGIC_VECTOR (31 downto 0);
           Q : out STD_LOGIC_VECTOR (31 downto 0));
end Mux9to1;

architecture Behavioral of Mux9to1 is
begin
    process (S, A0, A1, A2, A3, A4, A5, A6, A7, A8)
    begin
        case S is
            when "0000" => Q <= A0;
            when "0001" => Q <= A1;
            when "0010" => Q <= A2;
            when "0011" => Q <= A3;
            when "0100" => Q <= A4;
            when "0101" => Q <= A5;
            when "0110" => Q <= A6;
            when "0111" => Q <= A7;
            when "1000" => Q <= A8;
            when others => Q <= (others => '0');  -- Default case to avoid latches
        end case;
    end process;

end Behavioral;

--------------------------------------------------
-- Module: Counter untill m
--------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
entity Counter_Untill_m is 
   generic(
    m: integer := 15  -- Default max value (can be changed)
    );
   port( 
   Clock: in std_logic;
   RESET: in std_logic;
   Output: out std_logic_vector(3 downto 0) -- 4-bit output
   );
end Counter_Untill_m;
 
architecture Behavioral of Counter_Untill_m is
   signal temp: integer range 0 to m := 0;
begin   
   process(Clock, RESET)
   begin
      if RESET = '1' then
         temp <= 0;
      elsif rising_edge(Clock) then
         if temp < m then
            temp <= temp + 1;
         end if;
      end if;
   end process;
  
   Output <= std_logic_vector(to_unsigned(temp, 4)); -- Convert integer to 4-bit vector

end Behavioral;

--------------------------------------------------------------------------------
-- Module:                 Generic Delay
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity generic_delay is
	 generic(
   	 -- Divisor
		m: integer 
    );
	 
port ( clk,reset: in std_logic;
clock_out: out std_logic);
end generic_delay;
  
architecture bhv of generic_delay is
  
signal count: integer:=1;
signal tmp : std_logic := '0';
  
begin
  
process(clk,reset)
begin
	if(reset='1') then
		count<=1;
		tmp<='0';
	elsif(clk'event and clk='0') then
		count <=count+1;
		if (count = m) then
		tmp <= NOT tmp;
		count <= 1;
		end if;
	end if;
	clock_out <= tmp;
end process;
end;

--------------------------------------------------------------------------------
-- Module:                 Register
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--                           register32or64
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

ENTITY register32or64 IS
  GENERIC(
    m : natural := 32
    
  );
    PORT (
     D1   : IN std_logic_vector(m-1 downto 0);
     clk,RESET : IN std_logic;
     Q1   : OUT std_logic_vector(m-1 downto 0)
    );
END register32or64;

ARCHITECTURE RTL OF register32or64 IS
signal Qh1   : std_logic_vector(m-1 downto 0):= (others => '0'); 
    BEGIN
    
     PROCESS (clk, RESET)                  
       BEGIN
       IF (clk'EVENT AND clk = '1') THEN    
         Qh1 <= D1;
       END IF;
       IF RESET ='1' THEN
         Qh1 <= (others => '0'); 
       END IF; 
    END PROCESS; 
  Q1 <= Qh1;
END RTL;


--------------------------------------------------------------------------------
-- Module:                 Sine map
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity SineMap is
    port (clk, rst: in std_logic;
          X : in  std_logic_vector(31 downto 0);
          Y : out  std_logic_vector(31 downto 0);
          Y_ready : out std_logic
       );
end entity;

architecture arch of SineMap is  
component Mux9to1 is
   Port ( S : in  STD_LOGIC_VECTOR (3 downto 0);
          A0, A1, A2, A3, A4, A5, A6, A7, A8 : in  STD_LOGIC_VECTOR (31 downto 0);
          Q : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component register32or64 IS
  GENERIC(
    m : natural := 32
  );
    PORT (
     D1   : IN std_logic_vector(m-1 downto 0);
     clk,RESET : IN std_logic;
     Q1   : OUT std_logic_vector(m-1 downto 0)
    );
END component;

component generic_delay is
   generic(
      -- Divisor
     m: integer 
   );
   
port ( clk,reset: in std_logic;
clock_out: out std_logic);
end component;

component Counter_Untill_m is 
   generic(
    m: integer := 15  -- Default max value (can be changed)
    );
   port( 
   Clock: in std_logic;
   RESET: in std_logic;
   Output: out std_logic_vector(3 downto 0) -- 4-bit output
   );
end component;

component PositAdd_32_2_comb_uid2 is
   port ( 
     Y: in std_logic_vector(31 downto 0);
       X : in  std_logic_vector(31 downto 0);
       R : out  std_logic_vector(31 downto 0)
       );
end component;

component PositMult_32_2_F400_uid2 is
   port ( 
      clk : in std_logic;
      X : in  std_logic_vector(31 downto 0);
      Y : in  std_logic_vector(31 downto 0);
      R : out  std_logic_vector(31 downto 0));
end component;

signal mux_a_output: std_logic_vector(31 downto 0);
signal mux_b_output: std_logic_vector(31 downto 0);
signal mux_c_output: std_logic_vector(31 downto 0);

signal mult_output: std_logic_vector(31 downto 0);
signal add_output: std_logic_vector(31 downto 0);

signal register_1_output: std_logic_vector(31 downto 0);
signal register_2_output: std_logic_vector(31 downto 0);
signal register_3_output: std_logic_vector(31 downto 0);
signal register_4_output: std_logic_vector(31 downto 0);
signal register_out_output: std_logic_vector(31 downto 0);

signal clock_delayed: std_logic;

signal clock_output: std_logic;

signal counter_output: std_logic_vector(3 downto 0);

signal reset_signal : std_logic;

begin
   reset_signal <= clock_output or rst;

   MuxA : Mux9to1 port map ( 
      S => counter_output,
      A0 => "01001100100100001111110110101010", -- pi
      A1 => "11001101110100000110011111001001", -- a_w1
      A2 => "00110010001011111001100000110111", -- a_w2
      A3 => "00111010001011111001100000110111", -- a_z1
      A4 => "11000101110100000110011111001001", -- a_z2
      A5 => register_4_output,
      A6 => register_2_output,
      A7 => register_1_output,
      A8 => "00111111011001111111001111001111", -- eta: 0.962
      Q  => mux_a_output);
   
   MuxB : Mux9to1 port map ( 
      S => counter_output,
      A0 => X,
      A1 => register_1_output,
      A2 => register_2_output,
      A3 => register_3_output,
      A4 => register_4_output,
      A5 => register_2_output,
      A6 => register_4_output,
      A7 => "01000000000000000000000000000000", -- 1
      A8 => register_1_output,
      Q  => mux_b_output);

   MuxC : Mux9to1 port map ( 
      S => counter_output,
      A0 => "00000000000000000000000000000000", -- 0
      A1 => "01000000000000000000000000000000", -- 1
      A2 => "00000000000000000000000000000000", -- 0
      A3 => "00000000000000000000000000000000", -- 0
      A4 => "01001000000000000000000000000000", -- 2
      A5 => "00000000000000000000000000000000", -- 0
      A6 => "00000000000000000000000000000000", -- 0
      A7 => register_2_output,
      A8 => "00000000000000000000000000000000", -- 0
      Q  => mux_c_output);

   Mult: PositMult_32_2_F400_uid2 port map( 
		clk => clk,
		X => mux_a_output,
		Y => mux_b_output,
		R => mult_output);

   Add: PositAdd_32_2_comb_uid2 port map ( 
      Y => mult_output,
      X => mux_c_output,
      R => add_output);

   Register1: register32or64 generic map (
         m  => 32
      ) port map (
        D1     => add_output,
        clk    => clock_delayed,
        RESET  => reset_signal,
        Q1     => register_1_output);
   
   Register2: register32or64 generic map (
         m  => 32
      ) port map (
        D1     => register_1_output,
        clk    => clock_delayed,
        RESET  => reset_signal,
        Q1     => register_2_output);

   Register3: register32or64 generic map (
         m  => 32
      ) port map (
        D1     => register_2_output,
        clk    => clock_delayed,
        RESET  => reset_signal,
        Q1     => register_3_output);

   Register4: register32or64 generic map (
         m  => 32
      ) port map (
        D1     => register_3_output,
        clk    => clock_delayed,
        RESET  => reset_signal,
        Q1     => register_4_output);
   
   RegisterOutput: register32or64 generic map (
         m  => 32
      ) port map (
        D1     => add_output,
        clk    => clock_output,
        RESET  => rst,
        Q1     => register_out_output);
   
   Counter: Counter_Untill_m generic map(
       m => 9
   ) port map( 
      Clock => clock_delayed,
      RESET => reset_signal,
      Output => counter_output);

   delay: generic_delay generic map(
      m => 15
   ) port map(
      clk => clk,
      reset => reset_signal,
      clock_out => clock_delayed);
   
   clock_output <= '1' when counter_output = "1001" else '0';

   Y <= register_out_output;
   Y_ready <= clock_output;
end architecture;


--------------------------------------------------------------------------------
-- Module:                 Shift register
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--                  ShiftRegisterBit
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegisterBit is
    Port (  CLK : in  STD_LOGIC;
			RESET: in STD_LOGIC;
            Q : out  STD_LOGIC_VECTOR(26 downto 0) );
end ShiftRegisterBit;

architecture Behavioral of ShiftRegisterBit is

	-- Declara um tipo para uma matriz
	type reg is array ( 26 downto 0 ) of std_logic;
 						 
   signal registrador: reg := ('1', '0', '1', '0', '1', '0', '0', '1', '0', '1', '1', '1', '1', '0', '1', '1', '0', '1', '1', '1', '1', '1', '1', '1', '0', '0', '0');

begin
	process(CLK,RESET)
		variable temp : std_logic;
		begin
			if falling_edge(CLK) then
				temp := registrador(26);
            for I in 25 downto 0 loop
                registrador(I+1) <= registrador(I);
				end loop;
				registrador(0) <= temp xor registrador(25);
			end if;
			if RESET ='1' then
				registrador <= ('1', '0', '1', '0', '1', '0', '0', '1', '0', '1', '1', '1', '1', '0', '1', '1', '0', '1', '1', '1', '1', '1', '1', '1', '0', '0', '0');
			end if;
	end process;

   Q <=  registrador(26) &
               registrador(25) &
               registrador(24) &
               registrador(23) &
               registrador(22) &
               registrador(21) &
               registrador(20) &
               registrador(19) &
               registrador(18) &
               registrador(17) &
               registrador(16) &
               registrador(15) &
               registrador(14) &
               registrador(13) &
               registrador(12) &
               registrador(11) &
               registrador(10) &
               registrador(9)  &
               registrador(8)  &
               registrador(7)  &
               registrador(6)  &
               registrador(5)  &
               registrador(4)  &
               registrador(3)  &
               registrador(2)  &
               registrador(1)  &
               registrador(0);
end Behavioral;

--------------------------------------------------------------------------------
-- Module:                 FFlopD
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--                           FFlopD
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

ENTITY FFlopD IS
    PORT (
     D   : IN std_logic;
     rst : IN std_logic;
     clk : IN std_logic;
     Q   : OUT std_logic
    );
END FFlopD;

ARCHITECTURE RTL OF FFlopD IS

    BEGIN
    
     PROCESS (clk,rst)                 
       BEGIN
       IF (rst = '1') THEN
           Q <= '0';
       ELSIF (clk'EVENT AND clk = '1' AND rst = '0') THEN    
           Q <= D;
       END IF;
       
    END PROCESS;
END RTL;

--------------------------------------------------------------------------------
-- Module:                 Complete scheme
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity complete_scheme is
    port (clk, rst: in std_logic;
          X : in  std_logic_vector(31 downto 0);
          Y : out  std_logic_vector(31 downto 0)
       );
end entity;

architecture arch of complete_scheme is  
    component ShiftRegisterBit is
        Port (  CLK : in  STD_LOGIC;
                RESET: in STD_LOGIC;
                Q : out  STD_LOGIC_VECTOR(26 downto 0) );
    end component;


    component SineMap is
        port (clk, rst: in std_logic;
            X : in  std_logic_vector(31 downto 0);
            Y : out  std_logic_vector(31 downto 0);
            Y_ready : out std_logic
        );
    end component;

    component FFlopD IS
        PORT (
        D   : IN std_logic;
        rst : IN std_logic;
        clk : IN std_logic;
        Q   : OUT std_logic
        );
    END component;


   component register32or64 IS
   GENERIC(
   m : natural := 32
   );
   PORT (
      D1   : IN std_logic_vector(m-1 downto 0);
      clk,RESET : IN std_logic;
      Q1   : OUT std_logic_vector(m-1 downto 0)
   );
   END component;

    signal selection: std_logic;
    signal last_value: std_logic_vector(31 downto 0);
    signal current_input: std_logic_vector(31 downto 0);
    signal output_sine_map: std_logic_vector(31 downto 0);
    signal output_shift_register: std_logic_vector(26 downto 0);
    signal mask_27: std_logic_vector(26 downto 0);
    signal next_iteration: std_logic_vector(31 downto 0);
    signal scheme_output: std_logic_vector(31 downto 0);
    signal Y_ready_signal: std_logic;
    signal mask: std_logic_vector(4 downto 0);
begin
    ShiftRegister1: ShiftRegisterBit port map( 
        CLK => Y_ready_signal,
        RESET => rst,
        Q => output_shift_register);

    SineMap1: SineMap port map(
        clk => clk,
        rst => rst,
        X => current_input,
        Y => output_sine_map,
        Y_ready => Y_ready_signal);
    
    FlipFlop: FFlopD port map (D => '1', rst => rst, clk => Y_ready_signal, Q => selection);

    RegisterInput: register32or64 generic map (
         m  => 32
      ) port map (
        D1     => current_input,
        clk    => Y_ready_signal,
        RESET  => rst,
        Q1     => last_value);

    mask_27 <= (output_shift_register xor output_sine_map (26 downto 0));
    next_iteration <= output_sine_map(31 downto 27) & mask_27;
    mask <= mask_27(4 downto 0) xor last_value(4 downto 0);
    scheme_output <= (output_sine_map(31 downto 27) xor mask) & mask_27;
    Y <= scheme_output;
    current_input <= X when selection = '0' else next_iteration;
end architecture;