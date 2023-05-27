library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity D_FF is
   port(d , clk, RSTA, RSTS : in std_logic;
         q : out std_logic);
       end;
       architecture behave of D_FF is
       begin
   process(rsts,rsta,clk)
       begin
       if (RSTA='1') then
         q <= '0';
         elsif (clk'event and clk='1') then
           if (RSTS= '1') then
              q <= '0' ;
            else
              q <= d;
           end if;
       end if;
   end process;
 end;          