-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 12: Top level testbench
-- Section 3 Bench 2
-- TASK 3
-- Description: Test Bench for DDS
library ieee;
use ieee.std_logic_1164.all;

entity dds_spi_tb is
end dds_spi_tb;

architecture tb_architecture of dds_spi_tb is
	
	-- stimulus signals
	signal clk : std_logic := '0';
	signal reset_bar : std_logic;
	signal mosi : std_logic := '1';																				 
	signal sck : std_logic;
	signal ss_bar : std_logic; 
	-- observed signals
	signal wave_value : std_logic_vector(7 downto 0);
	signal pos : std_logic;
	
	constant period : time := 10 ns;
	
begin
	
	-- Unit Under Test port map
	UUT : entity dds_spi
	port map (
		clk => clk,
		reset_bar => reset_bar,
		mosi => mosi,
		sck => sck,
		ss_bar => ss_bar,
		wave_value => wave_value,
		pos => pos);
	
	reset_bar <= '0', '1' after 70 * period;	-- reset signal	
	ss_bar <= '0', '1' after 106 * period;
	sck <= '1', '0' after 106 * period;
	mosi <= '0' after 68 * period, '1' after 70 * period, '0' after 72 * period, '1' after 74 * period, '0' after 76 * period, '1' after 78 * period, '0' after 80 * period, '1' after 82 * period;
	
	clock: process				-- system clock
	begin
		for i in 0 to 1000 loop
			wait for period;
			clk <= not clk;
		end loop;
		wait;
	end process;
	
end tb_architecture;