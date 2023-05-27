---------------------------------------------------------------------------
-- This VHDL file was developed by Daniel Llamocca (2013).  It may be
-- freely copied and/or distributed at no cost.  Any persons using this
-- file for any purpose do so at their own risk, and are responsible for
-- the results of such use.  Daniel Llamocca does not guarantee that
-- this file is complete, correct, or fit for any particular purpose.
-- NO WARRANTY OF ANY KIND IS EXPRESSED OR IMPLIED.  This notice must
-- accompany any copy of this file.
--------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- For Simulation: make sure that the Counter: 0.01s
-- is inactive. z<='1' at all times.
 
ENTITY tb_dig_stopwatch IS
END tb_dig_stopwatch;
 
ARCHITECTURE behavior OF tb_dig_stopwatch IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dig_stopwatch
    PORT(
         resetn : IN  std_logic;
         clock : IN  std_logic;
         pause : IN  std_logic;
         segs : OUT  std_logic_vector(6 downto 0);
         EN : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal resetn : std_logic := '0';
   signal clock : std_logic := '0';
   signal pause : std_logic := '0';

 	--Outputs
   signal segs : std_logic_vector(6 downto 0);
   signal EN : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dig_stopwatch PORT MAP (
          resetn => resetn,
          clock => clock,
          pause => pause,
          segs => segs,
          EN => EN
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		resetn <= '0';
      wait for clock_period*10; resetn <= '1';
		wait for clock_period*100; pause <= '1';
		wait for clock_period*2; pause <= '0';

      -- insert stimulus here 
		
      wait;
   end process;

END;
