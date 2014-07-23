-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 12: DDS with Serial Peripheral Interface
-- Section 3 Bench 2 
-- TASK1
-- Description: SPI Receiver Shifter testbench
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity slv_spi_rx_shifter_tb is
end slv_spi_rx_shifter_tb;

architecture tb_architecture of slv_spi_rx_shifter_tb is 
	
	signal rxd: std_logic;
	signal rst_bar : std_logic;
	signal sel_bar : std_logic;																				 
	signal clk : std_logic := '0';
	signal shift_en : std_logic; 
	-- observed signals
	signal rx_data_out : std_logic_vector(15 downto 0);
	
	constant period : time := 10 ns;
	
begin
	
	-- Unit Under Test port map
	UUT : entity slv_spi_rx_shifter
	port map (rxd=>rxd,
	rst_bar=>rst_bar,
	sel_bar=>sel_bar,
	clk=>clk,
	shift_en=>shift_en,
	rx_data_out=>rx_data_out);
	
	rst_bar <= '0', '1' after 4 * period;	-- reset signal	
	sel_bar <= '0', '1' after 5 * period;
	shift_en <= '0';
	rxd <= '1', '0' after 15 * period, '1' after 17 * period;
	
	clock: process				-- system clock
	begin
		for i in 0 to 1000 loop
			wait for period;
			clk <= not clk;	 
		end loop;
		wait;
	end process;
	
end tb_architecture;