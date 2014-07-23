-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 12: DDS with Serial Peripheral Interface
-- Section 3 Bench 2  
-- TASK 2
-- Description: testbench to get the inputs for the Slave

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 


entity getinputs_tb is
end getinputs_tb;

architecture tb_architecture of getinputs_tb is

	-- stimulus signals
	signal clk : std_logic;
	signal rst_bar : std_logic;
	signal rx_data_in : std_logic_vector(15 downto 0);																				 
	-- observed signals
	signal freq_val : std_logic_vector(13 downto 0);
	signal ws1 : std_logic;
	signal ws0 : std_logic;	 
	
	constant period : time := 10 ns;
	
begin  
	
	UUT : entity getinputs
	port map (
		clk => clk,
		rst_bar => rst_bar,
		rx_data_in => rx_data_in,
		freq_val => freq_val,
		ws1 => ws1,
		ws0 => ws0);
		
		
		rst_bar <= '0', '1' after 4 * period;	-- reset signal
		
		
		clock: process				-- system clock
		begin
		for i in 0 to 1000 loop
			wait for period;
			clk <= not clk;
			rx_data_in <= std_logic_vector(to_signed(i, rx_data_in'length));
		end loop;
		wait;
	end process;
	
end tb_architecture;
		
		
		
	