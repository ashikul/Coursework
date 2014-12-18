--Cla_4bit testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
USE ieee.std_logic_arith.ALL;


entity testbench_cla_32bit is
end testbench_cla_32bit;

architecture waveform of testbench_cla_32bit is
	
	--stimulus signals - inputs to the UUT
	signal a, b: std_logic_vector(31 downto 0);
	signal sub, half: std_logic;	
	
	--observed signals - outputs of the UUT
	signal sum: std_logic_vector(31 downto 0);
	signal cout1, cout0: std_logic;	
	--signal cout: std_logic;
	
	constant period : time := 50ns;
	
begin
	
	-- Unit under test port map
	UUT: entity cla_32bit port map(
		a => a, b => b, sub => sub, half => half, sum => sum, cout1 => cout1, cout0 => cout0);
	
	--signal assignment statements 
	process
	begin	
		--Adder check
		a <= std_logic_vector(to_unsigned(155,32));
		b <= std_logic_vector(to_unsigned(200,32)); 
		sub <= '0';
		half <= '0';
		wait for period;  
		
		a <= std_logic_vector(to_unsigned(1111,32));
		b <= std_logic_vector(to_unsigned(3333,32)); 
		sub <= '0';	
		half <= '0';
		wait for period;
		
		a <= std_logic_vector(to_unsigned(9999,32));
		b <= std_logic_vector(to_unsigned(9999,32)); 
		sub <= '0';	 
		half <= '1';
		wait for period;	 
		
		a <= std_logic_vector(to_unsigned(25000,32));
		b <= std_logic_vector(to_unsigned(50000,32)); 
		sub <= '0';	 
		half <= '1';
		wait for period; 
		
		--Subtract check
		a <= std_logic_vector(to_unsigned(200,32));
		b <= std_logic_vector(to_unsigned(155,32)); 
		sub <= '1';	
		half <= '0';
		wait for period;  
		
		a <= std_logic_vector(to_unsigned(3333,32));  
		b <= std_logic_vector(to_unsigned(1111,32)); 
		sub <= '1';	 
		half <= '0';
		wait for period;
		
		a <= std_logic_vector(to_unsigned(9999,32));
		b <= std_logic_vector(to_unsigned(9999,32)); 
		sub <= '1';	
		half <= '1';
		wait for period;	 
		
		a <= std_logic_vector(to_unsigned(50000,32));
		b <= std_logic_vector(to_unsigned(25000,32)); 
		sub <= '1';	 
		half <= '1';
		wait for period; 
		
		a <= std_logic_vector(to_unsigned(790713366,32));
		b <= std_logic_vector(to_unsigned(1090566665,32)); 
		sub <= '0';	 
		half <= '0';
		wait for period; 
		
		a <= std_logic_vector(to_unsigned(790713366,32));
		b <= std_logic_vector(to_unsigned(1090566665,32)); 
		sub <= '0';	 
		half <= '1';
		wait for period;
		--end loop;  
		wait;	
	end process;
end waveform;


