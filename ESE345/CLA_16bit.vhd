--16 bit Carry lookahead adder
--using 4bit CLA block as a lower level block

library ieee;
use ieee.std_logic_1164.all;

entity cla_16bit is
	port (a, b: in std_logic_vector(15 downto 0);
		cin, sub: in std_logic;
		sum: out std_logic_vector(15 downto 0);
		--CCout: out std_logic;
		PPP, GGG: out std_logic);
end cla_16bit;

architecture structural of cla_16bit is
	signal GG, PP, C: std_logic_vector(3 downto 0);
	signal CC: std_logic_vector(4 downto 0);
	component cla_4bit is
		port (a, b: in std_logic_vector(3 downto 0);
			cin, sub: in std_logic;
			sum: out std_logic_vector(3 downto 0);
			--cout: out std_logic;
			PP, GG: out std_logic);
	end component;
	
begin						  
	CC(0) <= cin; 	   	
	--instantiate four 4-bit CLA blocks
	gen_adder: for i in 1 to 4 generate
		adder: cla_4bit port map(
			a(4*i-1 downto 4*i-4), 
			b(4*i-1 downto 4*i-4), 
			CC(i-1),
			sub,
			sum(4*i-1 downto 4*i-4),
			--C(i),
			PP(i-1),
			GG(i-1));
	end generate;
	
	carry_gen: for j in 0 to 3 generate
		CC(j+1) <= GG(j) OR (PP(j) AND CC(j));
	end generate;
	
	--computation of GGG and PPP
	PPP <= PP(3) AND PP(2) AND PP(1) AND PP(0);
	GGG <= GG(3) OR (PP(3) AND GG(2)) OR (PP(3) AND PP(2) AND GG(1)) OR (PP(3) AND PP(2) AND PP(1) AND GG(0)); 
	
	
end structural;

