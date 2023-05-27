library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all; 
use ieee. std_logic_unsigned.all;

entity serial_adder is
   port (a, b : in bit_vector(7 downto 0); 
     start, clock : in bit;
         result : buffer bit_vector (7 downto 0));
end serial_adder;

architecture structural of serial_adder is
  component counter is
    port (res, clk : in bit; 
          counting : out bit := '0');
  end component;
  
  component sh1 is
  port (sin, res, en, clk : in bit; 
        sout :   buffer bit_vector(7 downto 0));
 end component;
 
  component sh2 is
  port (sin, res, en, clk : in bit; 
        sout :   buffer bit_vector(7 downto 0));
 end component;
  
  component fulladder is
    port (a, b: in bit_vector(7 downto 0) ;
      cin: in bit ;
          sum, cout : out bit);
  end component;
  
  component flop is
    port (res, din, clk : in bit; 
          qout : buffer bit := '0');
  end component;
--
  signal serial_sum, carry_in, carry_out, counting : bit;
begin
  u1 : fulladder port map (a,b,carry_in, serial_sum, carry_out);
  u2 : flop port map (start, carry_out, clock, carry_in);
  u3 : counter port map (start, clock, counting);
  u4 : sh1 port map (serial_sum, start, counting, clock, result);
  u5 : sh2 port map (serial_sum, start, counting, clock, result); 
end structural;