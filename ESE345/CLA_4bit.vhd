--4bit_CLA		 
library ieee;
use ieee.std_logic_1164.all;  

--4-bit Carry lookahead adder:
Entity cla_4bit is
	port (a, b: in std_logic_vector(3 downto 0);
		cin, sub: in std_logic;
		sum: out std_logic_vector(3 downto 0);
		--cout: out std_logic;
		PP, GG: out std_logic);
end cla_4bit;

architecture structure of cla_4bit is
	signal G, P, C: std_logic_vector(3 downto 0);  
	component cla_1bit port (
			a, b, cin, sub: in std_logic;
			g, p, s: out std_logic);
	end component;
	
begin	
	--computation of sum, propagate(P) and generate(G) using lower blocks
	PA1: cla_1bit port map(
		a(0), b(0), cin, sub, G(0), P(0), sum(0));
	PA2: cla_1bit port map(
		a(1), b(1), c(1), sub, G(1), P(1), sum(1));
	PA3: cla_1bit port map(
		a(2), b(2), c(2), sub, G(2), P(2), sum(2));
	PA4: cla_1bit port map(
		a(3), b(3), c(3), sub, G(3), P(3), sum(3));
	
	--computation of carry:
	c(0) <= cin;
	c(1) <= G(0) OR (P(0) AND cin);
	c(2) <= G(1) OR (P(1) AND G(0)) OR (P(1) AND P(0) AND cin);
	c(3) <= G(2) OR (P(2) AND G(1)) OR (P(2) AND P(1) AND G(0)) OR (P(2) AND P(1) AND P(0) AND cin);
	
	
	--computation of PP and GG for higher blocks
	PP <= p(3) AND p(2) AND p(1) AND p(0);
	GG <= g(3) OR (p(3) AND g(2)) OR (p(3) AND p(2) AND g(1)) OR (p(3) AND p(2) AND p(1) AND g(0));
end structure;
