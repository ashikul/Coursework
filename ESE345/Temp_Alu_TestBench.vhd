--Cla_4bit testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
USE ieee.std_logic_arith.ALL;


entity Temp_Alu_TestBench is
end Temp_Alu_TestBench;

architecture waveform of Temp_Alu_TestBench is
	
	--stimulus signals - inputs to the UUT		
	signal opcode: std_logic_vector(3 downto 0);
	signal a, b: std_logic_vector(63 downto 0);
	
	
	--observed signals - outputs of the UUT
	signal sum: std_logic_vector(63 downto 0);
	
	constant period : time := 50ns;
	
begin
	
	-- Unit under test port map
	UUT: entity arithmatic_module port map(
		opcode => opcode ,a => a, b => b , r => sum);
	
	--signal assignment statements 
	process
	begin
		
		
		
		opcode <= "0011";
		a <= x"FEEEFFFF1111F777";
		b <= x"01100001EEE0777F";
		
		wait for period;  
		
		opcode <= "0011"	   ;	  --7
		a <= x"AFFF100011110000"; 
		b <= x"1000FFFFF0002222";  
		
		wait for period; 
		
		opcode <= "0011"	   ;	  --7
		a <= x"FFFF010001115555"; 
		b <= x"0010FFFFF0002222";  
		
		wait for period;  
		
		opcode <= "0011"	   ;	  --7
		a <= x"000200011111FFFF"; 
		b <= x"0001FFFF00002222"; 
		
		wait for period;  
		
		--
		
		opcode <= "0010"	   ;	--6
		a <= x"000FAAAA11110007"; 
		b <= x"0000AAAA00000006"; 
		
		wait for period;
		
		opcode <= "0010"	   ;	  --7
		a <= x"0000333311113333"; 
		b <= x"0000FFAA40002222";
		
		wait for period; 	
		
		opcode <= "0010"	   ;	  --7
		a <= x"FFFF000111110001"; 
		b <= x"0000FFFFFFFF2222"; 
		
		wait for period; 
		
		
		
		--end loop;  
		wait;	
	end process;
end waveform;