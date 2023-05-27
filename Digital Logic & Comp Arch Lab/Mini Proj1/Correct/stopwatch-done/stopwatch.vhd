----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:43:34 12/20/2015 
-- Design Name: 
-- Module Name:    stopwatch - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stopwatch is
    Port ( clk : in  STD_LOGIC; --clock(400 MHZ)
           rst : in  STD_LOGIC;
			  key : in std_logic;  --stop key
           SEG_SEL : out  STD_LOGIC_VECTOR (4 downto 0);
			  SEG_DATA : out  STD_LOGIC_VECTOR (7 downto 0));
end stopwatch;

architecture main_func of stopwatch is
   
   signal CounterSeg1 : integer;
   signal CounterSeg2 : integer;
   signal CounterSeg3 : integer;
   signal CounterSeg4 : integer;
	signal SEG_DATA_reg1 : STD_LOGIC_VECTOR (7 downto 0);
   signal SEG_DATA_reg2 : STD_LOGIC_VECTOR (7 downto 0);
	signal SEG_DATA_reg3 : STD_LOGIC_VECTOR (7 downto 0);
	signal SEG_DATA_reg4 : STD_LOGIC_VECTOR (7 downto 0);
	signal SEG_DATA_reg5 : STD_LOGIC_VECTOR (7 downto 0);
	signal CounterSeg1sig : integer range 0 to 400000;
	signal CounterSeg2sig : integer range 0 to 400000;
	signal RefreshSEG     :integer range 0 to 6  :=0;
	signal carry           :integer;

begin
 process(clk,rst,key)
 variable count_div :integer :=0000;
 
   begin
	-- Display and keys
       if (rst='0')then
           CounterSeg1 <= 0;
           CounterSeg2 <= 0;
           CounterSeg3 <= 0;
           CounterSeg4 <= 0;
			  count_div :=0000;
   elsif (key='0')then
	CounterSeg1sig <=0;
	elsif(clk = '1' and clk'event)
	then CounterSeg1sig <= CounterSeg1sig + 1;
	if(CounterSeg1sig = 400000)then
	counterseg1 <= counterseg1 + 1;
			  if (CounterSeg1 = 9)
			  then CounterSeg1<=0;
			  CounterSeg2<= CounterSeg2 + 1 ;
			  --carry <=0;
			  if (CounterSeg2 = 9)
			  then CounterSeg2<=0;	
			  CounterSeg3 <= CounterSeg3 + 1 ;
			  --carry <=1;
			  if (CounterSeg3 = 9)
			  then CounterSeg3 <= 0;
			  CounterSeg4 <= CounterSeg4 + 1 ;
			  CounterSeg4 <= 0;
       end if;
       end if;
		 end if;
		 end if;
		 end if;
   end process;
	
	with CounterSeg1 select
	 SEG_DATA_reg1 <= "00111111" when 0,
                     "00000110" when 1,
                     "01011011" when 2,
                     "01001111" when 3,
                     "01100110" when 4,
                     "01101101" when 5,
                     "01111101" when 6,
                     "00000111" when 7,
                     "01111111" when 8,
                     "01101111" when 9,
                     "00000000" when others;
				  
	with CounterSeg2 select
	 SEG_DATA_reg2 <= "00111111" when 0,
                     "00000110" when 1,
                     "01011011" when 2,
                     "01001111" when 3,
                     "01100110" when 4,
                     "01101101" when 5,
                     "01111101" when 6,
                     "00000111" when 7,
                     "01111111" when 8,
                     "01101111" when 9,
                     "00000000" when others;
   with CounterSeg3 select
    SEG_DATA_reg3 <= "00111111" when 0,
                     "00000110" when 1,
                     "01011011" when 2,
                     "01001111" when 3,
                     "01100110" when 4,
                     "01101101" when 5,
                     "01111101" when 6,
                     "00000111" when 7,
                     "01111111" when 8,
                     "01101111" when 9,
                     "00000000" when others;
   with CounterSeg4 select
	 SEG_DATA_reg4 <= "00111111" when 0,
                     "00000110" when 1,
                     "01011011" when 2,
                     "01001111" when 3,
                     "01100110" when 4,
                     "01101101" when 5,
                     "01111101" when 6,
                     "00000111" when 7,
                     "01111111" when 8,
                     "01101111" when 9,
                     "00000000" when others;
							with carry select
            SEG_DATA_reg5<= "00000011" when 1 ,
	         "00000000" when others;
	
 process(clk,rst)
 begin
 if(clk = '1' and clk'event)
 then CounterSeg2sig <= CounterSeg2sig + 1;
 RefreshSEG <= RefreshSEG + 1;
 if(CounterSeg2sig=40000) then
 
 case RefreshSEG is
 when 1 =>
 SEG_SEL <= "00001";
 SEG_DATA <= SEG_DATA_reg1;
 -- refreshseg <=1;
 when 2 =>
 SEG_SEL <= "00010";
 SEG_DATA <= SEG_DATA_reg2;
 -- refreshseg <= 2;
 when 3 =>
 SEG_SEL <= "00100";
 SEG_DATA <= SEG_DATA_reg3;
 -- refreshseg <= 3;
 when 4 =>
 SEG_SEL <= "01000";
 SEG_DATA <= SEG_DATA_reg4;
 -- refreshseg <= 4;
 when 5 =>
 SEG_SEL <= "10000";
 SEG_DATA <= SEG_DATA_reg5;
  --   refreshseg<= 0;
 --carry <=0;
 when 6 =>
 SEG_SEL <= "00000";
 SEG_DATA <= SEG_DATA_reg5;
 --carry <=1;

 when others => null;
 
 
 end case;
CounterSeg2sig <= 0; 
  end if;
	  end if;
 end process;
 
		 end main_func;