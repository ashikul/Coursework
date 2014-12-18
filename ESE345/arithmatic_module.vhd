library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

--//////////////////////////////////
--
-- arithmatic_module
--
-- 1/2 of the ALU, Processes the arithmatic functions of the ALU
--
--//////////////////////////////////

entity arithmatic_module is
	port(	
		opcode : in std_logic_vector(3 downto 0);  	-- Operation Code
		a : in std_logic_vector(63 downto 0);		-- Register Input One (RS)
		b : in std_logic_vector(63 downto 0);	  	-- Register Input Two (Or Destination) (RT)		
		r : out std_logic_vector(63 downto 0)		-- Destination Register (RD)				
		
		);  
end arithmatic_module;

architecture Behavioral of arithmatic_module is						
	
	--temporary signal declaration.
	signal operand1,operand2,operand1pt2,operand2pt2,resultpt1,resultpt2 : std_logic_vector(31 downto 0) := (others => '0');
	signal sub, half, cout1x, cout0x, cout1y, cout0y : std_logic;	
begin
	
	
	u1: entity cla_32bit port map(
		a => a(63 downto 32), b => b(63 downto 32), sub => sub, half => half, sum => resultpt1, cout1 => cout1x, cout0 => cout0x);
	u2: entity cla_32bit port map(
		a => a(31 downto 0), b => b(31 downto 0), sub => sub, half => half, sum => resultpt2, cout1 => cout1y, cout0 => cout0y);
	u3: entity arithmetic_control_result port map(	
		ax => a(63 downto 32),
		bx => b(63 downto 32),
		ay => a(31 downto 0),
		by => b(31 downto 0),
		opcode => opcode,
		r1=> resultpt1,
		r2=> resultpt2,
		result=> r,
		cout1x => cout1x,
		cout0x => cout0x,
		cout1y => cout1y,
		cout0y => cout0y
		);
	u4: entity arithmetic_control_subhalf port map(
		opcode => opcode,
		sub => sub,
		half => half 
		);
	
	
	
	
end Behavioral;