---------------------------------------------------------------------------
-- This VHDL file was developed by Daniel Llamocca (2013).  It may be
-- freely copied and/or distributed at no cost.  Any persons using this
-- file for any purpose do so at their own risk, and are responsible for
-- the results of such use.  Daniel Llamocca does not guarantee that
-- this file is complete, correct, or fit for any particular purpose.
-- NO WARRANTY OF ANY KIND IS EXPRESSED OR IMPLIED.  This notice must
-- accompany any copy of this file.
--------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.log2;
use ieee.math_real.ceil;

entity dig_stopwatch is
	port (resetn, clock, pause: in std_logic;
	      segs: out std_logic_vector (6 downto 0);
			EN: out std_logic_vector (3 downto 0));
end dig_stopwatch;

architecture Behavioral of dig_stopwatch is
	component my_genpulse
		generic (COUNT: INTEGER:= (10**8)/2); -- (10**8)/2 cycles of T = 10 ns --> 0.5 s
		port (clock, resetn, E: in std_logic;
				Q: out std_logic_vector ( integer(ceil(log2(real(COUNT)))) - 1 downto 0);
				z: out std_logic);
	end component;
	
	component sevenseg
		port (bcd: in std_logic_vector (3 downto 0);
				sevseg: out std_logic_vector (6 downto 0);
				EN: out std_logic_vector(3 downto 0)
				);
	end component;
	
	signal npause, z, z_0, z_1, z_2, z_3,E_1, E_2,E_3: std_logic;
	signal omux, Q_0, Q_1, Q_2, Q_3: std_logic_vector (3 downto 0);
	signal s: std_logic_vector (1 downto 0);
	signal E_fsm: std_logic;
	type state is (S1, S2, S3, S4);
	signal y: state;
	
begin

npause <= not (pause);

Q_3(3) <= '0';

-- Counter: 0.01s
gz: my_genpulse generic map (COUNT => 10**6)
    port map (clock => clock, resetn => resetn, E => npause, z => z);
	 --z <= '1'; -- only for simulation

-- Counter: 10	 
g0: my_genpulse generic map (COUNT => 10)
    port map (clock => clock, resetn => resetn, E => z, Q => Q_0, z => z_0);

-- Counter: 10	 
g1: my_genpulse generic map (COUNT => 10)
    port map (clock => clock, resetn => resetn, E => E_1, Q => Q_1, z => z_1);
	 E_1 <= z and z_0;

-- Counter: 10	 
g2: my_genpulse generic map (COUNT => 10)
    port map (clock => clock, resetn => resetn, E => E_2, Q => Q_2, z => z_2); 
	 E_2 <= E_1 and z_1;

-- Counter: 6	 
g3: my_genpulse generic map (COUNT => 6)
    port map (clock => clock, resetn => resetn, E => E_3, Q => Q_3 (2 downto 0),z => z_3);
	 E_3 <= E_2 and z_2;

-- Multiplexor
with s select
	omux <= Q_0 when "00",
	        Q_1 when "01",
			  Q_2 when "10",
			  Q_3 when others;
			  
seg7: sevenseg port map (bcd => omux, sevseg => segs);

-- 2-to-4 decoder
with s select
		EN <= "1110" when "00",
			   "1101" when "01",
			   "1011" when "10",
			   "0111" when "11",
			   "1111" when others;

-- Counter: 0.001s
gfsm: my_genpulse generic map (COUNT => 10**5)
    port map (clock => clock, resetn => resetn, E => '1', z => E_fsm);
	 
	Transitions: process (resetn, clock, E_fsm)
	begin
		if resetn = '0' then -- asynchronous signal
			y <= S1; -- if resetn asserted, go to initial state: S1			
		elsif (clock'event and clock = '1') then
			if E_fsm = '1' then
				case y is
					when S1 => y <= S2;
					when S2 => y <= S3;
					when S3 => y <= S4;
					when S4 => y <= S1;
				end case;
			end if;
		end if;		
	end process;
	
	Outputs: process (y)
	begin
		case y is
			when S1 => s <= "00";
			when S2 => s <= "01";
			when S3 => s <= "10";
			when S4 => s <= "11";
		end case;
	end process;
	
end Behavioral;
