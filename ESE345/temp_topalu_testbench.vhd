LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Temp_TopAlu_TestBench IS
END Temp_TopAlu_TestBench;

ARCHITECTURE behavior OF Temp_TopAlu_TestBench IS 
	
	
	signal operand1,operand2,result,lvData : std_logic_vector(63 downto 0) := (others => '0');
	signal opcode : std_logic_vector(3 downto 0) := (others => '0');
	constant Clk_period : time := 50 ns;
	
BEGIN
	
	-- Instantiate the Unit Under Test (UUT)
	uut: entity work.TOPmmxAlu PORT MAP (  
		operand1 => operand1,
		operand2 => operand2,	  
		lvData => lvData,
		opcode => opcode,
		result => result
		);
	
	process
	begin	
		
		opcode <= "0111"	   ;	  --7
		operand1 <= x"FFFF000011110000"; 
		operand2 <= x"0000FFFF00002222";
		wait for Clk_period;  	
		
		opcode <= "1100"	   ;	--6
		operand1 <= x"AAAA000011110000"; 
		operand2 <= x"0000AAAA00002222";
		wait for Clk_period;
		
		opcode <= "1100"	   ;	  --7
		operand1 <= x"FFAA000011110000"; 
		operand2 <= x"0000FFAA00002222";
		wait for Clk_period; 
		
		
		wait;	
		
	end process;
	
END;