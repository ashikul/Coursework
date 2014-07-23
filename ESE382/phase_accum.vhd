-- James Jr. Iannotto 107682077		
-- Ashikul Alam 108221262
-- Laboratory 11: Direct Digital Synthesis of Sine, Triangle, and Square Wave
-- Section 3 Bench 2
-- Description: Phase Accumulator


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;




entity phase_accumulator is
	generic (m : positive := 14);-- width of phase accumulator
	port(
		clk : in std_logic; -- system clock
		reset_bar : in std_logic; -- asynchronous reset
		up : in std_logic; -- count direction control, 1 => up, 0 => dn
		d : in std_logic_vector(m-1 downto 0); -- count delta
		max : out std_logic; -- count has reached max value
		min : out std_logic; -- count has reached min value
		q : out std_logic_vector(m-1 downto 0) -- phase acc. output
		);
end phase_accumulator; 


architecture behavioral of phase_accumulator is		
	signal initial : std_logic_vector(m-1 downto 0) := "00000000000000"; 
begin 
	
	u3: process(clk, reset_bar)	
	
	 begin	 

		if reset_bar = '0' then 
			q <=(others=>'0'); 
			
		elsif rising_edge(clk) then
		
			if up = '1' then  
				if to_integer(unsigned(initial)) + to_integer(unsigned(d)) >= (2**m - 1) then 
					initial <= "11111111111111"; 
					q <= initial;
					max <= '1';
					min <= '0';
				else 
					initial <= std_logic_vector(unsigned(initial) + unsigned(d)); 
					q <= initial;
					max <= '0';
				end if;
			 
			elsif up = '0' then 
				if std_logic_vector(unsigned(initial)) <= std_logic_vector(unsigned(d)) then 
					initial <= "00000000000000";
					q <= initial;
					min <= '1';
					max <= '0';
				else
					initial <= std_logic_vector(unsigned(initial) - unsigned(d));  
					q <= initial;	
					min <= '0';
				end if;
			end if;	
		end if; 
		
	end process;  
		
end behavioral;

			
			
			
			
			
			