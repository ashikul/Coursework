-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Adder/Subtracter for sine value
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity adder_subtracter is
	port(
		pos : in std_logic;-- indicates pos. or neg. half of cycle
		sine_value : in std_logic_vector(6 downto 0);-- from sine table
		dac_sine_val : out std_logic_vector(7 downto 0)-- output to DAC
		);
end adder_subtracter;

architecture structural of adder_subtracter is


signal s1 : std_logic_vector (7 downto 0);


begin
	 process (sine_value,pos)
			begin
				if pos = '1' then
					s1 <= '1' & sine_value;
				else
					s1 <=	std_logic_vector(to_unsigned((128 - to_integer(unsigned(sine_value))),8));
				end if;	  
				dac_sine_val <= s1;
			end process;
				
end structural;
	
		



