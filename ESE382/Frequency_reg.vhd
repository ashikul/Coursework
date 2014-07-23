-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Frequency register


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity frequency_reg is
	generic (a : positive := 14);
	port(
		load : in std_logic; -- enable register to load data
		clk : in std_logic; -- system clock
		reset_bar : in std_logic; -- active low asynchronous reset
		d : in std_logic_vector(a-1 downto 0); -- data input
		q : out std_logic_vector(a-1 downto 0) -- register output
	);									
end frequency_reg;


architecture behavioral of frequency_reg is	
signal temp_q : std_logic_vector(13 downto 0);
begin
	

	process(clk,reset_bar)
	begin 

		if (reset_bar= '0') then			--asynch reset
				temp_q <= "00000000000000";
			
		elsif rising_edge(clk) then
				if (load = '1') then
				temp_q <= d;
				end if;

		end if;

	q <= temp_q;

	end process;
	
end behavioral;






