library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity TOPmmxAlu is
	port(			 
		opcode : in std_logic_vector(3 downto 0);
		operand1 : in std_logic_vector(63 downto 0);
		operand2 : in std_logic_vector(63 downto 0);
		lvData : in std_logic_vector(63 downto 0);
		result : out std_logic_vector(63 downto 0)); 
	
end TOPmmxAlu;

architecture mmxAlu of TOPmmxAlu is		
	
	signal Logical_Out, Arithmatic_Out: std_logic_vector(63 downto 0) := (others => '0');
	
begin 		
	
	u1: entity Logical_Shift_Module port map(
		opcode=>opcode,
		a=>operand1,
		b=>operand2, 
		r => Logical_Out,
		lvData => lvData
		);	 
	
	u2: entity arithmatic_module port map(
		opcode=>opcode, 
		a=>operand1,
		b=>operand2, 
		r=>Arithmatic_Out
		);
	
	u3: entity alu_result_or port map(
		logic=>Logical_Out, 
		arith=>Arithmatic_Out,
		result=>result 
		);
	
end mmxAlu;


