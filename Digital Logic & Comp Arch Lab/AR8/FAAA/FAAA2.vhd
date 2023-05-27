----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:26 11/30/2015 
-- Design Name: 
-- Module Name:    FAAA2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FAAA2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           ci : in  STD_LOGIC;
           s0 : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC);
end FAAA2;

architecture Behavioral of FAAA2 is

    component FAAA
    
     port(X:in std_logic;
          
          Y:in std_logic;
          
          cin:in std_logic;
          
          cout:out std_logic ;
          
          sum:out std_logic);
 
    end component ;
 
  signal c : std_logic_vector (2 downto 0);

begin
bit1: FAAA port map (a(0), b(0),  Ci ,  c(0), S0(0));

bit2: FAAA port map (a(1), b(1), c(0),  c(1), s0(1));

bit3: FAAA port map (a(2), b(2), c(1),  c(2), S0(2));

bit4: FAAA port map (a(3), b(3), c(2),  Co  , S0(3));
end Behavioral;

