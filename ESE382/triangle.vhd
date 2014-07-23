-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Triangle table with adder/subtractor
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity triangle_table is
	port(
	addr : in std_logic_vector(6 downto 0);-- table address
	pos : in std_logic;-- indicates pos. or neg. half of cycle
	triangle_val : out std_logic_vector(7 downto 0)-- table entry value
	);
	
end triangle_table;

architecture behavior of triangle_table is 

signal s1: std_logic_vector (6 downto 0);
signal s2: std_logic_vector (7 downto 0);
type tbl is array (0 to 127) of std_logic_vector(6 downto 0);

constant tlu_triangle: tbl :=(	
"0000000", 
"0000001", 
"0000010", 
"0000011", 
"0000100", 
"0000101", 
"0000110", 
"0000111", 
"0001000", 
"0001001", 
"0001010", 
"0001011", 
"0001100", 
"0001101", 
"0001110", 
"0001111", 
"0010000", 
"0010001", 
"0010010", 
"0010011", 
"0010100", 
"0010101", 
"0010110", 
"0010111", 
"0011000", 
"0011001", 
"0011010", 
"0011011", 
"0011100", 
"0011101", 
"0011110", 
"0011111", 
"0100000", 
"0100001", 
"0100010", 
"0100011", 
"0100100", 
"0100101", 
"0100110", 
"0100111", 
"0101000", 
"0101001", 
"0101010", 
"0101011", 
"0101100", 
"0101101", 
"0101110", 
"0101111", 
"0110000", 
"0110001", 
"0110010", 
"0110011", 
"0110100", 
"0110101", 
"0110110", 
"0110111", 
"0111000", 
"0111001", 
"0111010", 
"0111011", 
"0111100", 
"0111101", 
"0111110", 
"0111111", 
"1000000", 
"1000001", 
"1000010", 
"1000011", 
"1000100", 
"1000101", 
"1000110", 
"1000111", 
"1001000", 
"1001001", 
"1001010", 
"1001011", 
"1001100", 
"1001101", 
"1001110", 
"1001111", 
"1010000", 
"1010001", 
"1010010", 
"1010011", 
"1010100", 
"1010101", 
"1010110", 
"1010111", 
"1011000", 
"1011001", 
"1011010", 
"1011011", 
"1011100", 
"1011101", 
"1011110", 
"1011111", 
"1100000", 
"1100001", 
"1100010", 
"1100011", 
"1100100", 
"1100101", 
"1100110", 
"1100111", 
"1101000", 
"1101001", 
"1101010", 
"1101011", 
"1101100", 
"1101101", 
"1101110", 
"1101111", 
"1110000", 
"1110001", 
"1110010", 
"1110011", 
"1110100", 
"1110101", 
"1110110", 
"1110111", 
"1111000", 
"1111001", 
"1111010", 
"1111011", 
"1111100", 
"1111101", 
"1111110", 
"1111111");	


begin
	
	process (addr,pos)
	begin
	
		s1 <= tlu_triangle(to_integer(unsigned(addr)));
		if pos = '1' then
			s2 <= '1' & s1;
		else
			s2 <=	std_logic_vector(to_unsigned((128 - to_integer(unsigned(s1))),8));
		end if;		  
		
		
	end process;  
	
	triangle_val <= s2;	 
	
	
end	behavior;