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
   
   signal CounterSeg1 : std_logic_vector(3 downto 0);
   signal CounterSeg2 : std_logic_vector(3 downto 0);
   signal CounterSeg3 : std_logic_vector(3 downto 0);
   signal CounterSeg4 : std_logic_vector(3 downto 0);
   signal SEG_DATA_reg1 :  STD_LOGIC_VECTOR (7 downto 0);
   signal SEG_DATA_reg2 :  STD_LOGIC_VECTOR (7 downto 0);
   signal SEG_DATA_reg3 : STD_LOGIC_VECTOR (7 downto 0);
	signal SEG_DATA_reg4 :   STD_LOGIC_VECTOR (7 downto 0);
	signal SEG_DATA_reg5 :   STD_LOGIC_VECTOR (7 downto 0);
	signal CounterSeg1sig : STD_LOGIC_VECTOR(7 downto 0);
	signal CounterSeg2sig : STD_LOGIC_VECTOR(7 downto 0);
	signal CounterSeg3sig : STD_LOGIC_VECTOR(7 downto 0);
	signal CounterSeg4sig : STD_LOGIC_VECTOR(7 downto 0);

  begin
  process(clk,rst,key)
  variable clk_cnt_hunscnt : integer;
  variable hunscnt :integer;
  variable clk_cnt_tenscnt : integer;
  variable tenscnt :integer;
  variable clk_cnt_onescnt : integer;
  variable onescnt :integer;
  variable clk_cnt_tencnt : integer;
  variable tencnt :integer;
  variable count_div :integer :=0000;
  variable flag : integer;
   begin
	-- Display and keys
       if (rst='0') and (key='0')
		 then count_div :=0000;
           CounterSeg1 <= "0000";
           CounterSeg2 <= "0000";
           CounterSeg3 <= "0000";
           CounterSeg4 <= "0000";
   if (clk = '1' and clk'event)
	and (key='1' and count_div<400000) then
	 count_div := count_div + 1 ;
	 elsif (count_div>400000) and (key='1')then
			  count_div :=0000;
		-- Begin the hunscnt normally put 400_000_000 / 1000 which equals 400_000,
      -- Starts the count independent of the others
			 if clk_cnt_hunscnt = 400000 then
               clk_cnt_hunscnt := 0;
			 if (CounterSeg1 = "1001") then
           CounterSeg2 <= CounterSeg2 + 1; 
			  CounterSeg1 <="0000";
			  else CounterSeg1 <= CounterSeg1 + 1;
			  end if;
			  else clk_cnt_hunscnt := clk_cnt_hunscnt + 1;
			  end if;
		-- Begin the tenscnt normally put 400_000_000 / 100 which equals 4_000_000,
      -- Starts the count independent of the others
			if clk_cnt_tenscnt = 4000000 then
               clk_cnt_tenscnt := 0;
			if (CounterSeg2 = "1001") then
           CounterSeg3 <= CounterSeg3 + 1;
           CounterSeg2 <= "0000";
           else CounterSeg2 <= CounterSeg2 + 1;
			  end if;
			  else clk_cnt_tenscnt := clk_cnt_tenscnt + 1;
			  end if;
		-- Begin the tenscnt normally put 400_000_000 / 10 which equals 40_000_000,
      -- Starts the count independent of the others
			  if clk_cnt_onescnt = 40000000 then
               clk_cnt_onescnt := 0;
			  if CounterSeg3 = "1001" then
           CounterSeg4 <= CounterSeg4 + 1;
           CounterSeg3 <= "0000";
           else CounterSeg3 <= CounterSeg3 + 1;
			  end if;
			  else clk_cnt_onescnt := clk_cnt_onescnt + 1;
			  end if;
		-- Begins the tencnt on the stopwatch
      -- Implement 400_000_000 beginning of second
			 if clk_cnt_tencnt = 400000000 then
           clk_cnt_tencnt := 0;
           flag := 0;
			 if CounterSeg3 = "1001" and CounterSeg4 = "1001" then
           CounterSeg4 <= "0000";
           CounterSeg3 <= "0000";
           flag := 1;
           else
           if CounterSeg3 = 9 then
           CounterSeg4 <= CounterSeg4 + 1;
           CounterSeg3 <= "0000";
           flag := 0;
           else  
           CounterSeg3 <= CounterSeg3 + 1;
           flag := 0;
			  end if;
			  end if;
			  else clk_cnt_tencnt := clk_cnt_tencnt + 1;
           flag := 0;
			  end if;
			  if flag = 1 then
           flag := 0;
			  end if;
			  end if;
         end if;  
			end process;
	
	with CounterSeg1sig select
	 SEG_DATA_reg1 <= "00111111" when "00000000",
                     "00000110" when "00000001",
                     "01011011" when "00000010",
                     "01001111" when "00000011",
                     "01100110" when "00000100",
                     "01101101" when "00000101",
                     "01111101" when "00000110",
                     "00000111" when "00000111",
                     "01111111" when "00001000",
                     "01101111" when "00001001",
                     "00000000" when others;
				  
	with CounterSeg2sig select
	 SEG_DATA_reg2 <= "00111111" when "00000000",
                     "00000110" when "00000001",
                     "01011011" when "00000010",
                     "01001111" when "00000011",
                     "01100110" when "00000100",
                     "01101101" when "00000101",
                     "01111101" when "00000110",
                     "00000111" when "00000111",
                     "01111111" when "00001000",
                     "01101111" when "00001001",
                     "00000000" when others;
   with CounterSeg3sig select
    SEG_DATA_reg3 <= "00111111" when "00000000",
                     "00000110" when "00000001",
                     "01011011" when "00000010",
                     "01001111" when "00000011",
                     "01100110" when "00000100",
                     "01101101" when "00000101",
                     "01111101" when "00000110",
                     "00000111" when "00000111",
                     "01111111" when "00001000",
                     "01101111" when "00001001",
                     "00000000" when others;
   with CounterSeg4sig select
	 SEG_DATA_reg4 <= "00111111" when "00000000",
                     "00000110" when "00000001",
                     "01011011" when "00000010",
                     "01001111" when "00000011",
                     "01100110" when "00000100",
                     "01101101" when "00000101",
                     "01111101" when "00000110",
                     "00000111" when "00000111",
                     "01111111" when "00001000",
                     "01101111" when "00001001",
                     "00000000" when others;
							
 process(clk)
variable RefreshSEG : std_logic_vector(7 downto 0) ;
 begin
 
 case RefreshSEG is
 when "00000000" =>
 SEG_SEL <= "00001";
 SEG_DATA <= SEG_DATA_reg1;
 when "00000001" =>
 SEG_SEL <= "00010";
 SEG_DATA <= SEG_DATA_reg2;
 when "00000010" =>
 SEG_SEL <= "00100";
 SEG_DATA <= SEG_DATA_reg3;
 when "00000011" =>
 SEG_SEL <= "01000";
 SEG_DATA <= SEG_DATA_reg4;
 when "00000100" =>
 SEG_SEL <= "10000";
 SEG_DATA <= SEG_DATA_reg5;
 when others => null;
 end case;
 
 end process;
 
		 end main_func;