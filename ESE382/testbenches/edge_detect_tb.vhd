-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Testbench for Moore FSM edge detector


library ieee;
use ieee.std_logic_1164.all;  


entity edge_det_tb is
end edge_det_tb;

architecture tb_architecture of edge_det_tb is
	
	-- stimulus signals
	signal clk : std_logic := '0';
	signal rst_bar : std_logic;
	signal pos : std_logic;	
	signal sig : std_logic;
	
	-- observed signals
	signal sig_edge : std_logic;
	
	constant period : time := 20 ns;
	
begin
	
	-- Unit Under Test port map
	UUT : entity edge_det
	port map (
		rst_bar => rst_bar,	
		clk => clk,
		pos => pos,
		sig => sig,
		sig_edge => sig_edge
		);
	
	rst_bar <= '0', '1' after 4 * period;	-- reset signal
	pos <= '0', '1' after 100 * period, '0' after 200 * period, '1' after 300 * period, '0' after 400 * period;
	sig <= '1', '0' after 25 * period, '1' after 50 * period, '0' after 75 * period, '1' after 100 * period, '0' after 125 * period, '1' after 150 * period, '0' after 175 * period, '1' after 200 * period, '0' after 225 * period, '1' after 250 * period, '0' after 275 * period, '1' after 300 * period, '0' after 325 * period, '1' after 350 * period, '0' after 375 * period, '1' after 400 * period, '0' after 425 * period; 
	
	clock: process				-- system clock
	begin
		for i in 0 to 450 loop
			wait for period;
			clk <= not clk;
		end loop;
		wait;
	end process;
	
end tb_architecture;
