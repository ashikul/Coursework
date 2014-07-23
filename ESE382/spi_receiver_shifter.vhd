-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 12: DDS with Serial Peripheral Interface
-- Section 3 Bench 2 
-- TASK 1
-- Description: SPI Receiver Shifter
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity slv_spi_rx_shifter is
	port(
	rxd : in std_logic; -- data received from master
	rst_bar : in std_logic; -- asynchronous reset
	sel_bar : in std_logic; -- selects shifter for operation
	clk : in std_logic; -- system clock
	shift_en : in std_logic; -- enable shift
	rx_data_out : out std_logic_vector(15 downto 0) -- received data
	);
end slv_spi_rx_shifter;

architecture mixed of slv_spi_rx_shifter is
signal rxd_reg : std_logic_vector(15 downto 0);
begin
	
	
	rx_shift: process (clk, rst_bar)
	begin		  
		
		if rst_bar = '0' then
			rxd_reg <= (others => '0');
		elsif rising_edge(clk) then
			if sel_bar = '0' and shift_en = '1' then
				rxd_reg <= rxd_reg(14 downto 0) & rxd;
			end if;
		end if;	
		
	end process;
	
	rx_data_out <= rxd_reg;

end mixed;