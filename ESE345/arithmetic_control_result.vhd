library ieee;
use ieee.std_logic_1164.all;

entity arithmetic_control_result is
	port(
		opcode : in std_logic_vector(3 downto 0); 
		ax : in std_logic_vector(31 downto 0);
		bx : in std_logic_vector(31 downto 0);
		
		ay : in std_logic_vector(31 downto 0);
		by : in std_logic_vector(31 downto 0);
		
		r1 : in std_logic_vector(31 downto 0);
		r2 : in std_logic_vector(31 downto 0);
		cout0x : in STD_LOGIC;
		cout1x : in STD_LOGIC;
		cout0y : in STD_LOGIC;
		cout1y : in STD_LOGIC;
		result : out std_logic_vector(63 downto 0)	
		
		);
end arithmetic_control_result;						

architecture dataflow of arithmetic_control_result is	 
	
begin
	
	process(opcode, r1, r2, ax, bx, ay, by, cout0x, cout1x, cout0y, cout1y)
	begin	   
		
		case opcode is 
			when "0111" =>			--add word 
				
			result <= r1 & r2;
			when "0110" => 			--subraft from word
				
			result <= r1 & r2;
			when "0101" => 		    --addhalfword
				
			result <= r1 & r2;
			when "0100" => 			 --subhalfword
				
				result <= r1 & r2;	
			
			when "0011" => 		    --addhalfword saturated
				
				
				if (cout1x = '1') then --overflow
					result(63 downto 48) <= x"FFFF";
				else
					result(63 downto 48) <=r1(31 downto 16);
				end if;
				
				if (cout0x = '1') then --overflow
					result(47 downto 32) <= x"FFFF";
				else
					result(47 downto 32) <= r1(15 downto 0);
				end if;
				
				if (cout1y = '1') then --overflow
					result(31 downto 16) <= x"FFFF"; 
				else
					result(31 downto 16) <= r2(31 downto 16);
				end if;	 
				
				if (cout0y = '1') then --overflow
					result(15 downto 0) <= x"FFFF"; 
				else
					result(15 downto 0) <= r2(15 downto 0);
				end if;
				
			
			when "0010" => 
				
				
				if (ax(31 downto 16) < bx(31 downto 16)) then --underflow
					result(63 downto 48) <= x"0000";
				else
					result(63 downto 48) <=r1(31 downto 16);
				end if;
				
				if (ax(15 downto 0) < bx(15 downto 0)) then --underflow
					result(47 downto 32) <= x"0000";
				else
					result(47 downto 32) <= r1(15 downto 0);
				end if;
				
				if (ay(31 downto 16) < by(31 downto 16)) then --underflow
					result(31 downto 16) <= x"0000"; 
				else
					result(31 downto 16) <= r2(31 downto 16);
				end if;	 
				
				if (ay(15 downto 0) < by(15 downto 0)) then --underflow
					result(15 downto 0) <= x"0000"; 
				else
					result(15 downto 0) <= r2(15 downto 0);
				end if;
			
			when others =>
			result <= (others => '0');
		end case; 
		
	end process;		
end dataflow; 	