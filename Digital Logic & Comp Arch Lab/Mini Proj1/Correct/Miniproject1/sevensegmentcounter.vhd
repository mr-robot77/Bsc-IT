----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:04:39 12/14/2015 
-- Design Name: 
-- Module Name:    sevensegmentcounter - Behavioral 
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sevensegmentcounter is
    Port ( clk      : in  STD_LOGIC;
           stop     : in  STD_LOGIC;
           rst      : in  STD_LOGIC;
			  seg_sel  : out STD_LOGIC_VECTOR(4 downto 0);
           seg_data : out STD_LOGIC_VECTOR(7 downto 0));
			  
end sevensegmentcounter;

architecture Behavioral of sevensegmentcounter is
        signal counterseg1    :integer;
		  signal counterseg2    :integer;
		  signal counterseg3    :integer;
		  signal counterseg4    :integer;
		  signal seg_data1      :std_logic_vector (7 downto 0);
		  signal seg_data2      :std_logic_vector (7 downto 0);
		  signal seg_data3      :std_logic_vector (7 downto 0);
		  signal seg_data4      :std_logic_vector (7 downto 0);
		  signal seg_data5      :std_logic_vector (7 downto 0);
		  signal counter1       :integer range 0 to 400000;
		  signal counter2       :integer range 0 to 400000;
		  signal refreshseg     :integer range 0 to 5  :=0;
		  signal flag           :integer;
		  
		  
     begin
     process(clk,rst,stop)
        begin
          if ( rst='0') then 
          counterseg1 <= 0;
			 counterseg2 <= 0;
			 counterseg3 <= 0;
			 counterseg4 <= 0;
          counter1    <= 0;
			 elsif(stop='0') then counter1 <= 0;
			 elsif(rising_edge(clk)) then
			 counter1 <= counter1 + 1 ;
          if(counter1 = 400000  ) then
			 counterseg1 <= counterseg1 + 1;
          
          if(counterseg1 = 9)
			 then 
          counterseg1 <= 0 ;		
	       counterseg2 <= counterseg2 + 1;
			 flag<= 0 ;

			 if(counterseg2 = 9)
			 then 
			 counterseg2 <= 0 ;
			 counterseg3 <= counterseg3 + 1;
			 flag<= 1 ;
			 if(counterseg3 = 9)
			 then counterseg3 <= 0 ;
			 counterseg4 <= counterseg4 + 1;
			 
			 if(counterseg4 = 9)
			 then counterseg4 <= 0 ;
			
			 end if;
          end if;
			 end if;
			 end if;
			 end if;
			 end if;
			 
			
      end process;

		
		with counterseg1 select
seg_data1<= "00111111" when 0,
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
		    
		with counterseg2 select
seg_data2<= "00111111" when 0,
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
		
		with counterseg3 select
seg_data3<= "00111111" when 0,
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
		
		with counterseg4 select
seg_data4<= "00111111" when 0,
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
		with flag select
seg_data5<= "00000011" when 1 ,
	         "00000000" when others;
				
	  process(clk,rst)
	  begin
	  if(rising_edge(clk))
	  then 
	  counter2 <= counter2 + 1;
	  refreshseg <= refreshseg + 1;
	  if(counter2=40000) then
	  case refreshseg is
	   
	   when 1 => 
		         seg_sel  <= "00001";
		         seg_data <= seg_data1;
	           -- refreshseg <=1;
		
		when 2 =>
		         seg_sel  <= "00010";
		         seg_data <= seg_data2;
	           -- refreshseg <= 2;
		
		when 3 =>
		         seg_sel  <= "00100";
		         seg_data <= seg_data3;
		        -- refreshseg <=3;
		
		when 4 =>
		         seg_sel  <="01000";
		         seg_data <= seg_data4;
		      --   refreshseg <=4;
		
		when 5 =>
	  	         seg_sel  <="10000";
		         seg_data <=seg_data5;
		      --   refreshseg<= 0;
	            when others => null;
	  end case;
	  counter2<=0;
  end if;
	
	  
	  end if;
 end process;
end Behavioral;

