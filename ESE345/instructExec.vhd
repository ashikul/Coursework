library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity instructExec is
	port(clk : in std_logic; 
		writein : in std_logic;
		
		opcode : in std_logic_vector(3 downto 0);  
		opcodeOut : out std_logic_vector(3 downto 0); 
		
		newrd : in std_logic_vector(3 downto 0); 
		oldrd: out std_logic_vector(3 downto 0); 
		
		rsData : in std_logic_vector(63 downto 0);
		rtData : in std_logic_vector(63 downto 0); 
		operand1 : out std_logic_vector(63 downto 0);
		operand2 : out std_logic_vector(63 downto 0);
		
		rdData : in std_logic_vector(63 downto 0)); 
	
end instructExec;

architecture instructExec of instructExec is
	
begin
	
	process(clk, opcode, rsData, rtData, writein, rdData)
		
		variable s : line;
		variable cnt : integer:=0; 
		
	begin
		if(rising_edge(clk)) then
			operand1 <= rtData;
			operand2 <= rsData;	  
			opcodeOut <= opcode;
			oldrd <= newrd;	
			
			if (opcode = "1111") then  --for nop operation
				oldrd <= "ZZZZ";
			end if;
			
			
					  if (writein = '0') then
						write(s, string'("RD/EX     -opcode:")); 
						hwrite(s, opcode); 
						write(s, string'("  rd:")); 
						hwrite(s, newrd);
						writeline(output, s);
						
						write(s, string'("-reading rs2 Data:"));
						hwrite(s, rsData);
						writeline(output, s); 
						
						write(s, string'("-reading rs1 Data:"));
						hwrite(s, rtData);
						writeline(output, s);
						
						
						
						write(s, string'("WB to last cycle rd")); 
						writeline(output, s);
						
						write(s, string'("-writing Data:"));
						hwrite(s, rdData);
				   		writeline(output, s); 
					end if;
						
		end if;
	end process;
	
end instructExec;
