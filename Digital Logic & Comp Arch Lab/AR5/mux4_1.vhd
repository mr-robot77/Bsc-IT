Library ieee;
use ieee.std_logic_1164.all;
entity MUX4to1 is
  port(m3,m2,m1,m0: in std_logic;
       s : in std_logic_vector(1 downto 0);
       o : out std_logic);
     end MUX4to1;
     architecture struct1 of MUX4to1 is
       begin
       o<= m0 when s="00" else
           m1 when s="01" else
           m2 when s="10" else
           m3 when s="11" ;
      end struct1;
