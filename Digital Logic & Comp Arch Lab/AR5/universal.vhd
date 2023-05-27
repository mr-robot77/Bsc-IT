LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY univ_shiftreg IS
PORT(clk, sril, srir,RST : IN STD_LOGIC;
s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
I : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END univ_shiftreg;
ARCHITECTURE struct OF univ_shiftreg IS
  
COMPONENT MUX4to1
PORT (m3, m2, m1, m0 : IN STD_LOGIC;
s: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
o: OUT STD_LOGIC);
END COMPONENT;

COMPONENT DFF
PORT(d, clk,RST : IN STD_LOGIC;
  q: OUT STD_LOGIC);
END COMPONENT;


SIGNAL o : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL qt: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN 
--:MUX4to1 PORT MAP(m3   , m2   , m1  , m0   , s , o   )
  
U0:MUX4to1 PORT MAP(I(3) , qt(2),srir , qt(3), s , o(3));                      
U1:MUX4to1 PORT MAP(I(2) , qt(1),qt(3), qt(2), s , o(2));                                   
U2:MUX4to1 PORT MAP(I(1) , qt(0),qt(2), qt(1), s , o(1));                        
U3:MUX4to1 PORT MAP(I(0) , sril ,qt(1), qt(0), s , o(0));
 
--:DFF   PORT MAP(d    , clk  ,RST  , q    );
                      
U4:DFF   PORT MAP(o(3) , clk  ,RST  , qt(3));
U5:DFF   PORT MAP(o(2) , clk  ,RST  , qt(2));
U6:DFF   PORT MAP(o(1) , clk  ,RST  , qt(1));
U7:DFF   PORT MAP(o(0) , clk  ,RST  , qt(0));
q <= qt;
END struct;