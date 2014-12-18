library ieee;
use ieee.std_logic_1164.all;

entity arithmetic_control_subhalf is
	port(
		opcode : in std_logic_vector(3 downto 0); 
		sub : out STD_LOGIC;
		half : out STD_LOGIC
		);
end arithmetic_control_subhalf;						

architecture dataflow of arithmetic_control_subhalf is	 
	
begin
	
	process(opcode)
	begin	   
		
		case opcode is 
			when "0111" =>			--add word 
				sub <= '0';
				half <= '0';  
			
			when "0110" => 			--subraft from word
				sub <= '1';
				half <= '0';  
			
			when "0101" => 		    --addhalfword
				sub <= '0';
				half <= '1';
			
			when "0100" => 
				sub <= '1';		    --subtracthalfword
				half <= '1';
				
			
			when "0011" => 		    --addhalfword saturated
				
				sub <= '0';
				half <= '1';   
			
			when "0010" => 
				sub <= '1';		    --subtracthalfword saturated
				half <= '1';  
			
			when others =>
				sub <= '0';		     
			half <= '0';
		end case; 
		
	end process;		
end dataflow; 	