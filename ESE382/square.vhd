-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2   
-- Description: Square with adder/subtractor
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity square is
	port(
	--addr : in std_logic_vector(6 downto 0);-- table address
	pos : in std_logic;-- indicates pos. or neg. half of cycle
	square_val : out std_logic_vector(7 downto 0)-- table entry value
	);
	
end square;

architecture behavior of square is 

signal s1 : std_logic_vector (6 downto 0);

begin
	
	process (pos)
	begin
	
		s1 <= "1111111";
		if pos = '1' then
			square_val <= '1' & s1;
		else
			square_val <=	std_logic_vector(to_unsigned((128 - to_integer(unsigned(s1))),8));
		end if;
		
		
	end process;

end	behavior;