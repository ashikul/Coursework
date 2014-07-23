-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 12: DDS with Serial Peripheral Interface
-- Section 3 Bench 2   
-- TASK 3
-- Description: Structural design of DDS
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity dds_spi is
	generic (a : positive := 14; m : positive := 14);
	port(
	clk : in std_logic;-- system clock
	reset_bar : in std_logic;-- asynchronous reset
	mosi : in std_logic; -- master out slave in SPI serial data
	sck : in std_logic; -- SPI shift clock to slave
	ss_bar : in std_logic; -- DDS slave select signal
	wave_value : out std_logic_vector(7 downto 0);-- output to DAC
	pos : out std_logic-- positive half of sine wave cycle
	);
end dds_spi;	 

architecture structural of dds_spi is  

signal pos_edge_det : std_logic := '1';	 
signal sig_edge : std_logic; 
signal fr_out : std_logic_vector(a-1 downto 0);	
signal max : std_logic; -- count has reached max value
signal min : std_logic; -- count has reached min value
signal pa_out :  std_logic_vector(m - 1 downto 0); -- phase acc. output
signal up : std_logic;
signal pos_phase : std_logic;   		   
signal sine_val : std_logic_vector(6 downto 0);
signal dac_sine_value : std_logic_vector(7 downto 0);
signal triangle_value : std_logic_vector(7 downto 0);
signal square_value : std_logic_vector(7 downto 0);		
signal rx_data : std_logic_vector(15 downto 0);
signal ws1 : std_logic;
signal ws0 : std_logic; 
signal freq_val : std_logic_vector(13 downto 0);
signal load : std_logic;   -- shift register is ready to output
begin	

	u1 : entity edge_det port map (clk => clk, rst_bar => reset_bar, sig => ss_bar, pos => pos_edge_det, sig_edge => sig_edge);
	u2 : entity slv_spi_rx_shifter port map (clk => clk, rst_bar => reset_bar, sel_bar => ss_bar, rxd => mosi, shift_en => sck, rx_data_out => rx_data);	
	u3 : entity getinputs port map(clk => clk, rst_bar => reset_bar, rx_data_in => rx_data, freq_val => freq_val, ws1 =>ws1, ws0 => ws0);
	u4 : entity frequency_reg port map (load => sig_edge, clk=>clk, reset_bar=>reset_bar, d=>freq_val, q=>fr_out);
	u5 : entity phase_accumulator port map (clk=>clk, reset_bar=>reset_bar, up=>up, d=>fr_out, max=>max, min=>min, q=>pa_out);	  	  
	u6 : entity phase_accumulator_fsm port map (clk=>clk, reset_bar=>reset_bar, max=>max, min=>min, up=>up, pos=>pos_phase );	 
	u7 : entity sine_table port map (addr=>pa_out(13 downto 7), sine_val=>sine_val);	 
	u8 : entity adder_subtracter port map (pos=>pos_phase, sine_value=>sine_val, dac_sine_val=>dac_sine_value);
	u9 : entity square port map (pos=>pos_phase, square_val=>square_value);
	u10 : entity triangle_table port map (addr=>pa_out(13 downto 7), pos=>pos_phase, triangle_val=>triangle_value);
	u11 : entity multiplex port map (i0=>square_value, i1=>dac_sine_value, i2=>triangle_value, i3=>square_value, ws1=>ws1, ws0=>ws0, wave_value=>wave_value);
	pos <= pos_phase;
	
end structural; 