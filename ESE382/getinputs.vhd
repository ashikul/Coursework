-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 12: DDS with Serial Peripheral Interface
-- Section 3 Bench 2  
-- TASK 2
-- Description: Entity to get the inputs for the Slave

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 


entity getinputs is
	port(
	clk : in std_logic;
	rst_bar : in std_logic;
	rx_data_in : in std_logic_vector(15 downto 0);
	freq_val : out std_logic_vector(13 downto 0);
	ws1 : out std_logic;-- system clock
 	ws0 : out std_logic-- system clock
	);
	
end getinputs;

architecture break of getinputs is
signal w : std_logic_vector (1 downto 0);
begin
	
	process (clk, rst_bar)
	begin 
		if rst_bar = '0' then
			freq_val <= "00000000000000";
			ws1 <= '0';
			ws0 <= '0';
		elsif rising_edge(clk) then	
			
			w <= rx_data_in (15 downto 14);
			freq_val <= rx_data_in (13 downto 0);
			ws1 <= w(1);
			ws0 <= w(0);
		end if;
	end process; 

end break;