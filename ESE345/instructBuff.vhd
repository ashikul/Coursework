library ieee;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;

entity instructBuff is
	port(clk : in std_logic;
		din : in std_logic_vector(15 downto 0);
		dout : out std_logic_vector(15 downto 0);
		write : in std_logic);
end instructBuff;

architecture instructBuff of instructBuff is				
	signal instruct0 : std_logic_vector(15 downto 0);		  
	signal instruct1 : std_logic_vector(15 downto 0);
	signal instruct2 : std_logic_vector(15 downto 0);
	signal instruct3 : std_logic_vector(15 downto 0);
	signal instruct4 : std_logic_vector(15 downto 0);
	signal instruct5 : std_logic_vector(15 downto 0);
	signal instruct6 : std_logic_vector(15 downto 0);
	signal instruct7 : std_logic_vector(15 downto 0);
	signal instruct8 : std_logic_vector(15 downto 0);
	signal instruct9 : std_logic_vector(15 downto 0);
	signal instruct10 : std_logic_vector(15 downto 0);		
	signal instruct11 : std_logic_vector(15 downto 0);
	signal instruct12 : std_logic_vector(15 downto 0);
	signal instruct13 : std_logic_vector(15 downto 0);
	signal instruct14 : std_logic_vector(15 downto 0);
	signal instruct15 : std_logic_vector(15 downto 0);	 
	signal count : integer := 0;			
	signal d : std_logic_vector(15 downto 0);
	
begin
	
	process(clk, write) 
	begin
		
		if(write = '1' and rising_edge(clk)) then
			case count is
				when 0 => instruct0 <= din;	
				when 1 => instruct1 <= din;
				when 2 => instruct2 <= din;
				when 3 => instruct3 <= din;
				when 4 => instruct4 <= din;
				when 5 => instruct5 <= din;
				when 6 => instruct6 <= din;
				when 7 => instruct7 <= din;
				when 8 => instruct8 <= din;
				when 9 => instruct9 <= din;
				when 10 => instruct10 <= din;
				when 11 => instruct11 <= din;
				when 12 => instruct12 <= din;
				when 13 => instruct13 <= din;
				when 14 => instruct14 <= din;
				when 15 => instruct15 <= din;
				when others => NULL;
			end case;	
			if(count = 15) then
				count <= 0;
			else
				count <= count + 1;
			end if;
		elsif(write = '0' and rising_edge(clk)) then
			case count is
				when 0 => dout <= instruct0;	
				when 1 => dout <= instruct1;
				when 2 => dout <= instruct2;
				when 3 => dout <= instruct3;
				when 4 => dout <= instruct4;
				when 5 => dout <= instruct5;
				when 6 => dout <= instruct6;
				when 7 => dout <= instruct7;
				when 8 => dout <= instruct8;
				when 9 => dout <= instruct9;
				when 10 => dout <= instruct10;
				when 11 => dout <= instruct11;
				when 12 => dout <= instruct12;
				when 13 => dout <= instruct13;
				when 14 => dout <= instruct14;
				when 15 => dout <= instruct15;
				when others => NULL;
			end case;
			if(count = 15) then
				count <= 0;
			else
				count <= count + 1;
			end if;
		end if;	
	end process;  
	
	
	
	
end instructBuff;



