-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Moore FSM edge detector


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity edge_det is
	port(
		rst_bar : in std_logic; -- asynchronous system reset
		clk : in std_logic; -- system clock
		sig : in std_logic; -- input signal
		pos : in std_logic; -- '1' for positive edge, '0' for negative
		sig_edge : out std_logic -- high for one sys. clk after edge
	);
end edge_det; 



architecture moore of edge_det is
type state is (idle0, idle1, posedge, negedge);
signal present_state, next_state : state;
begin
-- State register process
	state_reg: process(clk, rst_bar)
	begin
		if rst_bar = '0' then
			present_state <= idle0;
		elsif rising_edge(clk) then
			present_state <= next_state;
		end if;
	end process;
 -- Next state process
	nxt_state: process(sig, present_state)
	begin
		case present_state is
			when idle0 =>
			if sig = '0' then
				next_state <= idle0;
			else
				next_state <= posedge;
			end if;
			when posedge =>
			if sig = '0' then
				next_state <= negedge;
			else
				next_state <= idle1;
			end if; 
			when idle1 =>
			if sig = '0' then
				next_state <= negedge;
			else
				next_state <= idle1;
			end if; 
			when negedge =>
			if sig = '0' then
				next_state <= idle0;
			else
				next_state <= posedge;
			end if;
			end case;
		end process;
 -- Output process
	output: process(sig, pos, present_state)
	begin
		case present_state is
			when idle0 =>
			sig_edge <= '0';
			when posedge =>
 			if pos = '1' then
 				sig_edge <= '1';
			else
				sig_edge <= '0';
			end if;
			when idle1 =>
			sig_edge <= '0'; 
			when negedge =>
			if pos = '0' then
				sig_edge <= '1';
			else
				sig_edge <= '0';
			end if;
		end case;
	end process; 
end moore;
	