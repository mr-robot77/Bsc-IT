----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:54 12/27/2015 
-- Design Name: 
-- Module Name:    alu8bit - Structural
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
------------------------------------------------------------------------------------
----------------------------------- 1BIT FULL ADDER --------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity full_adder is
Port ( a : in STD_LOGIC;
       b : in STD_LOGIC;
      ci : in STD_LOGIC;
       s : out STD_LOGIC;
      co : out STD_LOGIC);
end full_adder;
architecture bhv_full of full_adder is
begin
s <= (a xor b) xor ci;
co <= (a and b) or ((a xor b) and ci);
end bhv_full;
-------------------------------------------------------------------------------
------------------------------------ 1BIT AND ---------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity AND_1bit is
Port ( i_a : in STD_LOGIC ;
       i_b : in STD_LOGIC ;
result_and : out STD_LOGIC);
end AND_1bit;
architecture Bhv_and_1bit of AND_1bit is
begin
result_and <=i_a and i_b ;
end Bhv_and_1bit;
-------------------------------------------------------------------------------
------------------------------------ 1BIT OR ----------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity OR_1bit is
Port ( in_a : in STD_LOGIC;
       in_b : in STD_LOGIC;
  result_or : out STD_LOGIC );
end OR_1bit;
architecture Bhv_or_1bit of OR_1bit is
begin
result_or <=in_a or in_b;
end Bhv_or_1bit;
-------------------------------------------------------------------------------
------------------------------------ slt --------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
entity slt is
port ( slt_a: in std_logic;
slt_b:in std_logic;
slt_set:out std_logic);
end slt;
architecture bhv_slt of slt is
begin
process(slt_a,slt_b)
begin
if (slt_a < slt_b)then
 slt_set<='1';
else 
slt_set<='0';
end if;
end process;
end bhv_slt; 
---------------------------------------------------------------------------------------
------------------------ Mux 2to1 -----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux_2to1 is
    Port ( binvert : in  STD_LOGIC;
                 b : in std_logic ;
                 O : out STD_LOGIC);
end mux_2to1;

architecture Behav of mux_2to1 is

begin
process(binvert,b)
begin
 case binvert is
  when '1' => O <= not b;
  when '0' => O <= b;
  when others => null;
  end case;
end process;

end Behav;
---------------------------------------------------------------------------------------
------------------------ Mux 4to1 -----------------------------------------------------
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--entity mux4to1 is
--port(z0,z1,z2,z3:in std_logic;
--operate:in std_logic_vector (2 downto 0);
--Result:out std_logic);
--end mux4to1;

--architecture Behave of mux4to1 is
--signal result_and : std_logic;
--signal result_or : std_logic;
--signal s : std_logic;
--signal set : std_logic;
--begin
--process(operate)
--begin
-- case operate is
  -- when "000"=>Result<= result_and;
  -- when "001"=>Result<= result_or;
  -- when "010"=>Result<= s;
  -- when "110"=>Result<= not s;
  -- when "111"=>Result<= set;
   --when others => null;
  --end case;
--end process;

--end Behave;
---------------------------------------------------------------------------------------
------------------------ Overflow -----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Overflow is 
port (carryin:in std_logic;
     carryout:in std_logic;
      overflw: out std_logic);
end Overflow;
architecture Bhv of Overflow is
begin
process(carryin,carryout)
begin
--overflw<=carryin xor carryout;
case (carryin xor carryout) is
when '1' => overflw <='1';  --overflow occured!
when '0' => overflw <='0';
when others => null;
end case;
end process;
end Bhv;
---------------------------------------------------------------------------------------
------------------------ LAST ALU -----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;	
 entity LAST_ALU is
         port ( a_input : in std_logic;
         b_input : in std_logic;
         c_in : in std_logic:='0' ;
         opert: in std_logic_vector (2 downto 0);
         lss : in std_logic;
         overflow : out std_logic ;
         res : out std_logic ;
         set_slt : out std_logic );

end LAST_ALU ;
---------------------------------------------------------------------------------------
------------------------ 1BIT ALU -----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ALU_1BIT is 
  port ( a_in : in std_logic;
         b_in : in std_logic;
         carry_in : in std_logic ;
         operation : in std_logic_vector (2 downto 0);
			b_invert : in std_logic;
         carry_out : out std_logic ;
         Result: out std_logic);

end ALU_1BIT ;

ARCHITECTURE structure OF ALU_1BIT IS

    COMPONENT AND_1bit
        Port ( i_a : in STD_LOGIC ;
               i_b : in STD_LOGIC ;
               result_and : out STD_LOGIC);
    END COMPONENT;

    COMPONENT OR_1bit 
        Port ( in_a : in STD_LOGIC;
               in_b : in STD_LOGIC;
               result_or : out STD_LOGIC ); 
    END COMPONENT;
    
    COMPONENT full_adder
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
              ci : in STD_LOGIC;
               s : out STD_LOGIC;
              co : out STD_LOGIC);
    END COMPONENT;
	 
component slt
	 port(slt_a: in std_logic;
	 slt_b:in std_logic;
	 slt_set:out std_logic);
end component;
    
    COMPONENT  mux_2to1

      Port ( binvert : in  STD_LOGIC;
                 b : in std_logic ;
                 O : out STD_LOGIC);
        
    END COMPONENT;
	 
	 component LAST_ALU
         port ( a_input : in std_logic;
         b_input : in std_logic;
         c_in : in std_logic:='0' ;
         opert: in std_logic_vector (2 downto 0);
         lss : in std_logic;
         overflow : out std_logic ;
         res : out std_logic ;
         set_slt : out std_logic );
end component ;
-------------------------------------------------------------------------------------
-------------------------------- MUX OF OPERATION -----------------------------------
-------------------------------------------------------------------------------------
component mux4to1 
port(zo,z1,z2,z3:in std_logic;
operate:in std_logic_vector (2 downto 0);
Result:out std_logic);
end component;
--in the other words 
--with result select 
-- y <= a_in and b_in when (b_invert='0' and operation="00") ,
--  a_in or b_in when (b_invert='0' and operation="01") , 	 
--  a_in + b_in when (b_invert='0' and operation="10") ,            
--	 a_in - b_in when (b_invert='1' and operation="10") ,
--  a_in slt b_in when (b_invert='1' and operation="11") ,	
--  null when others;
--Result <= y ;   

--in other words
--signal less : std_logic ;
--signal y : std_logic ;

--BEGIN                
 --process(a_in,b_in,y)
  --begin
  -- case operation is
  -- when "000"=>y<= a_in and b_in;
  -- when "001"=>y<= a_in or b_in;
  -- when "010"=>y<= a_in + b_in;
  -- when "110"=>y<= a_in - b_in;
  -- when "111"=>y<= a_in slt b_in;
	--when others => null;
  -- end case;
  -- end process;
  -- Result <= y ;
	begin																																							
    R_and: AND_1bit PORT MAP   (i_a => a_in , i_b => b_in , result_and => Result );
    R_or: OR_1bit PORT MAP     (in_a => a_in , in_b => b_in , result_or => Result );
    R_add: full_adder PORT MAP (a => a_in , b => b_in ,ci => carry_in , s => Result, co => carry_out );
    R_sub: full_adder PORT MAP (a => a_in , b => b_in ,ci => carry_in , s => Result, co => carry_out );
    R_slt: slt PORT MAP        (slt_a => a_in , slt_b => b_in , slt_set => Result );  

END structure;
---------------------------------------------------------------------------------------
------------------------- Binary to BCD -----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_LOGIC_signed.all;

entity bin2bcd_8bit is
    Port ( binIN : in  STD_LOGIC_VECTOR (7 downto 0);
           ones : out  STD_LOGIC_VECTOR (3 downto 0);
           tens : out  STD_LOGIC_VECTOR (3 downto 0);
           hundreds : out  STD_LOGIC_VECTOR (3 downto 0));
                   
end bin2bcd_8bit;

architecture Behavioral of bin2bcd_8bit is

begin

 process(binIN)
 variable temp : STD_LOGIC_VECTOR (7 downto 0);
 variable bcd : SIGNED (11 downto 0) := (others => '0');
  begin
        bcd := (others => '0');
    
        temp(7 downto 0) := binIN;
    
       for i in 0 to 7 loop
    
      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      if bcd(11 downto 8) > 4 then  
        bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;
    
      bcd := bcd(10 downto 0) & temp(7);
    
      
      temp := temp(6 downto 0) & '0';
    
    end loop;
 
    
    ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
    tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
    hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
     
  end process ;           
  
end Behavioral;

----------------------------------------------------------------------------------------
------------------------ 8-BIT ALU -----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY alu8bit IS
PORT( a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      op : IN STD_LOGIC_VECTOR( 2 DOWNTO 0);
      result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      overflow : OUT STD_LOGIC);
END alu8bit;

architecture structural of alu8bit is
signal carry: std_logic_vector(7 downto 0);
signal set:std_logic;
signal less : std_logic ;
signal s: std_logic_vector(7 downto 0);
begin

--process (a_in,b_in,y,carry_out)
--begin
  --if  ((a_in(3) = '1') and (b_in(3) ='1') and (y(3) = '0')) then carry_out <= '1';
  --elsif ((a_in(3) = '1') and (b_in(3) = '0') and (y(3) = '0')) then carry_out <= '1';
  --elsif ((a_in(3) = '0') and (b_in(3) = '1') and (y(3) = '0')) then carry_out <= '1';
  --else carry_out <= '0';
 -- end if;
--end process;

 alu1: ALU_1BIT port map(a_in => a(0),b_in => b(0),operation=>op,carry_in=>op(2)   ,b_invert=>less,carry_out=>carry(0),result=>s(0));
 alu2: ALU_1BIT port map(a_in => a(1),b_in => b(1),operation=>op,carry_in=>carry(0),b_invert=>'0',carry_out=>carry(1),result=>s(1));
 alu3: ALU_1BIT port map(a_in => a(2),b_in => b(2),operation=>op,carry_in=>carry(1),b_invert=>'0',carry_out=>carry(2),result=>s(2));
 alu4: ALU_1BIT port map(a_in => a(3),b_in => b(3),operation=>op,carry_in=>carry(2),b_invert=>'0',carry_out=>carry(3),result=>s(3));
 alu5: ALU_1BIT port map(a_in => a(4),b_in => b(4),operation=>op,carry_in=>carry(3),b_invert=>'0',carry_out=>carry(4),result=>s(4));
 alu6: ALU_1BIT port map(a_in => a(5),b_in => b(5),operation=>op,carry_in=>carry(4),b_invert=>'0',carry_out=>carry(5),result=>s(5));
 alu7: ALU_1BIT port map(a_in => a(6),b_in => b(6),operation=>op,carry_in=>carry(5),b_invert=>'0',carry_out=>carry(6),result=>s(6));
 alu8: LAST_ALU port map(a_input => a(7),b_input => b(7),opert=>op,c_in=>carry(6),lss=>'0',c_out=>carry(7),set_slt=>set,res=>s(7));
  less<=set;
  result<=s;
  overflow <= (not (s(0) or s(1) or s(2) or s(3) or s(4) or s(5) or s(6) or s(7)));
end structural;
------------------------------------------------------------------------------------------