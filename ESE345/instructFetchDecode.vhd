library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity instructFetchDecode is
	port(clk : in std_logic;
		din : in std_logic_vector(15 downto 0);
		writein : in std_logic;
		rs : out std_logic_vector(3 downto 0);
		rt : out std_logic_vector(3 downto 0);
		rd : out std_logic_vector(3 downto 0);
		opcode : out std_logic_vector(3 downto 0));
end instructFetchDecode;

architecture instructFetchDecode of instructFetchDecode is
	
begin
	
	process(clk, din, writein) 
		
		variable s : line;
		variable cnt : integer:=0; 
		
	begin
		if(rising_edge(clk)) then
			opcode <= din(15 downto 12);
			rs <= din(11 downto 8);
			rt <= din(7 downto 4);
			rd <= din(3 downto 0);	   
			
			if (writein = '0') then	
							write(s, string'("*****New cycle*****")); 
							writeline(output, s); 
							write(s, string'("IF/ID     -opcode:")); 
							hwrite(s, din(15 downto 12));
							write(s, string'("    rs2:"));
							hwrite(s, din(11 downto 8));
							write(s, string'("    rs1:"));
							hwrite(s, din(7 downto 4));
							write(s, string'("    rd:"));
							hwrite(s, din(3 downto 0));
					   		writeline(output, s); 
						end if;
		end if;
		
		
	end process;
	
end instructFetchDecode;

