library ieee;
use ieee.std_logic_1164.all;

entity alu_result_or is
	port(	 
		logic : in std_logic_vector(63 downto 0);
		arith : in std_logic_vector(63 downto 0);
		result : out std_logic_vector(63 downto 0)	
		);
end alu_result_or;						

architecture dataflow of alu_result_or is	 
	
begin
	--
	process(logic, arith)
	begin	   
		result <= logic or arith;		
	end process;		
end dataflow; 	