-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Testbench for Frequency Register


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity frequency_reg_tb is
end frequency_reg_tb;

architecture tb_architecture of frequency_reg_tb is
	
-- stimulus signals
	signal load : std_logic;
	signal clk : std_logic := '0';
	signal reset_bar : std_logic;
	signal d : std_logic_vector(13 downto 0);
	
	-- observed signals
	signal q : std_logic_vector(13 downto 0);
	
	
	constant period : time := 20 ns;
	
begin
	
	-- Unit Under Test port map
	UUT : entity frequency_reg
	port map ( 
	load => load,
	clk => clk,
	reset_bar => reset_bar,
	d => d,
	q => q);
	
	reset_bar <= '0', '1' after 4 * period;	-- reset signal
	load <= '1' after 6 * period;
	
	clock: process				-- system clock
	begin
		for i in 0 to 450 loop
			d <= std_logic_vector(to_unsigned((to_integer(unsigned(d)))+1, d'length));
			wait for period;
			clk <= not clk;
		end loop;
		wait;
	end process;
	
end tb_architecture;