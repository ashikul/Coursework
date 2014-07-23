-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Testbench for Phase Accumulator FSM


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity phase_accumulator_fsm_tb is
end phase_accumulator_fsm_tb;

architecture tb_architecture of phase_accumulator_fsm_tb is
	
-- stimulus signals
	signal clk : std_logic := '0';
	signal reset_bar : std_logic;				  
	signal max : std_logic;
	signal min : std_logic;
	-- observed signals	  
	
	signal up : std_logic;
	signal pos : std_logic;
	
	
	constant period : time := 20 ns;
	
begin
	
	-- Unit Under Test port map
	UUT : entity phase_accumulator_fsm
	port map ( 	
	clk => clk,
	reset_bar => reset_bar,
	max => max,
	min => min,
	up => up,
	pos => pos);
	
	reset_bar <= '0', '1' after 4 * period;	-- reset signal
	max <= '0', '1' after 6 * period, '0' after 10 * period;
--	min <= '0', '1' after 14 * period, '0' after 20 * period;
	clock: process				-- system clock
	begin
		for i in 0 to 450 loop	 
			wait for period;
			clk <= not clk;
		end loop;
		wait;
	end process;
	
end tb_architecture;