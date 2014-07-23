-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2   	
-- Description: Multiplexer for control inputs
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity multiplex is
	port(
	i0 : in std_logic_vector(7 downto 0);
	i1 : in std_logic_vector(7 downto 0); 
	i2 : in std_logic_vector(7 downto 0); 
	i3 : in std_logic_vector(7 downto 0); 
	ws1 : in std_logic;-- system clock
 	ws0 : in std_logic;-- system clock
	wave_value : out std_logic_vector(7 downto 0)-- output to DAC
	);
	
end multiplex;
	
	
architecture behavioral of multiplex is

begin
	process(ws1,ws0,i0,i1,i2,i3)
	begin		 
		if (ws1 = '0' and ws0 = '0') then
			wave_value <= i0;
		elsif (ws1 = '0' and ws0 = '1') then
			wave_value <= i1;
		elsif (ws1 = '1' and ws0 = '0') then
			wave_value <= i2;
		else
			wave_value <= i3;
		end if;
	end process;
end behavioral;

	
	