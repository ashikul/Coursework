-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Testbench for Phase Accumulator


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity phase_accumulator_tb is
end phase_accumulator_tb;

architecture tb_architecture of phase_accumulator_tb is
	
-- stimulus signals
	signal clk : std_logic := '0';
	signal reset_bar : std_logic;
	signal up : std_logic;
	signal d : std_logic_vector(13 downto 0);
	
	-- observed signals	  
	signal max : std_logic;
	signal min : std_logic;
	signal q : std_logic_vector(13 downto 0);
	
	
	constant period : time := 20 ns;
	
begin
	
	-- Unit Under Test port map
	UUT : entity phase_accumulator
	port map ( 	
	clk => clk,
	reset_bar => reset_bar,
	up => up,
	d => d,
	max => max,
	min => min,
	q => q);
	
	reset_bar <= '0', '1' after 4 * period;	-- reset signal
	d <= "00000000000001";
	up <= '1', '0' after 400 * period;
	clock: process				-- system clock
	begin
		for i in 0 to 1000 loop	 
			wait for period;
			clk <= not clk;
		end loop;
		wait;
	end process;
	
end tb_architecture;