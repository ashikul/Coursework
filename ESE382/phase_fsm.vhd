-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Phase Accumulator FSM


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity phase_accumulator_fsm is
	port(
	clk : in std_logic; -- system clock
	reset_bar : in std_logic; -- asynchronous reset
	max : in std_logic; -- max count
	min : in std_logic; -- min count
	up : out std_logic; -- count direction
	pos : out std_logic -- positive half of sine cycle
	);
end phase_accumulator_fsm;
										   
architecture moore of phase_accumulator_fsm is 
type state is (state_pa, state_pd, state_na, state_nd); 
signal present_state, next_state : state; 
begin 
	
	
	state_register: process (clk, reset_bar)
	begin 
		if reset_bar = '0' then 
			present_state <= state_pa; 
		elsif rising_edge(clk) then 
			present_state <= next_state; 
		end if; 
		end process; 
	
	
	outputs: process (present_state)
		begin 
			case present_state is 
				when state_pa | state_pd => pos <= '1';
				when others => 	 			pos <= '0'; 
			end case;	 
			
			case present_state is
				when state_pa | state_na => up <= '1';
				when others =>			    up <= '0';
			end case;
			
		end process; 
		
		
		
	nxt_state: process (present_state, max, min)
		begin   
			 				
			case present_state is 
				when state_pa =>
				if max = '1' and min = '0' then 
					next_state <= state_pd; 
				else 
					next_state <= state_pa; 
				end if; 
				
				when state_pd => 
				if max = '0' and min = '1' then 
					next_state <= state_na; 
				else 
					next_state <= state_pd; 
				end if; 
				
				when state_na =>
					if max = '1' and min = '0' then 
						next_state <= state_nd; 
					else 
						next_state <= state_na; 
					end if; 
					
				when state_nd =>
					if max = '0' and min = '1' then 
						next_state <= state_pa; 
					else 
						next_state <= state_nd; 
					end if; 
					
					
			end case;
				
		end process; 
end moore;

	
			
			