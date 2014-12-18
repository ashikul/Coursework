LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Temp_logical_TestBench IS
END Temp_logical_TestBench;

ARCHITECTURE behavior OF Temp_logical_TestBench IS 
	
	
	signal a,b,r,lvData : std_logic_vector(63 downto 0) := (others => '0');
	signal opcode : std_logic_vector(3 downto 0) := (others => '0');
	constant Clk_period : time := 50 ns;
	
BEGIN
	
	-- Instantiate the Unit Under Test (UUT)
	uut: entity work.logical_shift_module PORT MAP (
		a => a,
		b => b,
		opcode => opcode,
		r => r,			 		  
		lvData => lvData
		);
	
	process
	begin	
		
		lvData <= x"000000000000FFFF";
		--Adder check
		opcode <= "1100";  --and
		a <= x"0101010101010101"; 
		b <= x"1010101010101010"; 
		wait for Clk_period; 
		opcode <= "1100"; --or
		a <= x"FFFF010101010101"; 
		b <= x"1010FFFF10101010"; 
		wait for Clk_period; 
		opcode <= "1100";	 --xor
		a <= x"0101010101010101"; 
		b <= x"1010101010101010"; 
		wait for Clk_period; 
		opcode <= "1100";	 --clz
		a <= x"0101A1A1A1010101"; 
		b <= x"10101A1A1A101010";
		wait for Clk_period; 
		opcode <= "1100";	  --cntb
		a <= x"0101010101010101"; 
		b <= x"1010101010101010";
		wait for Clk_period; 
		opcode <= "0001";		 --mpyu
		a <= x"0101010101010101"; 
		b <= x"1010101010101010";
		wait for Clk_period; 
		opcode <= "0000";		--absdb
		a <= x"0101010101010101"; 
		b <= x"1010101010101010"; 
		wait for Clk_period; 
		
		
		
		--end loop;  
		wait;	
	end process;
	
END;