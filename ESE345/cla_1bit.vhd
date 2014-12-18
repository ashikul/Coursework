library ieee;
use ieee.std_logic_1164.all;

--carry lookahead 1bit block
entity cla_1bit is
	port(
		a, b, cin, sub: in std_logic;
		g, p, s: out std_logic);
end cla_1bit;

architecture structural of cla_1bit is
	signal x, y: std_logic;
	component and_2 is
		port(
			i1 : in STD_LOGIC;
			i2 : in STD_LOGIC;
			o1 : out STD_LOGIC
			);
	end component;
	
	component or_2 is
		port(
			i1 : in STD_LOGIC;
			i2 : in STD_LOGIC;
			o1 : out STD_LOGIC
			);
	end component; 
	
	component xor_2 is
		port(
			i1 : in STD_LOGIC;
			i2 : in STD_LOGIC;
			o1 : out STD_LOGIC
			);
	end component;	
	
begin
	and1: and_2 port map(a, y, g);
	
	or1: or_2 port map(a, y, p); 
	
	xor1: xor_2 port map(a, y, x);
	
	xor2: xor_2 port map(x, cin, s); 
	
	xor3: xor_2 port map(b, sub, y);
end structural;
