library ieee;
use ieee.std_logic_1164.all;

entity cla_32bit is
	port (a, b: in std_logic_vector(31 downto 0);
		sub, half: in std_logic;
		sum: out std_logic_vector(31 downto 0);
		cout1, cout0: out std_logic); 
end cla_32bit;		

architecture structure of cla_32bit is
	signal GGG, PPP, C: std_logic_vector(1 downto 0);
	signal CCC: std_logic_vector(2 downto 0); 
	signal Cint, i, a1, a2, carry: std_logic;
	component cla_16bit is
		port (a, b: in std_logic_vector(15 downto 0);
			cin, sub: in std_logic;
			sum: out std_logic_vector(15 downto 0);
			--CCout: out std_logic;
			PPP, GGG: out std_logic);
	end component; 
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
	
	component inv is
		port(
			i1 : in STD_LOGIC;
			--	     i2 : in STD_LOGIC;
			o1 : out STD_LOGIC
			);
	end component;
	
begin
	CCC(0) <= sub;	  
	
	second_level_1: cla_16bit port map(
		a (15 downto 0),
		b (15 downto 0),
		sub,
		sub,
		sum (15 downto 0),
		--C(0),
		PPP(0),
		GGG(0));   
	
	second_level_2: cla_16bit port map(
		a (31 downto 16),
		b (31 downto 16),
		carry,
		sub,
		sum (31 downto 16),
		--C(1),
		PPP(1),
		GGG(1));
	
	CCC(1) <= GGG(0) OR (PPP(0) AND CCC(0));
	Cint <= GGG(1) OR (PPP(1) AND GGG(0)) OR (PPP(1) AND PPP(0) AND (CCC(0)));		
	Cout1 <= Cint XOR sub;	
	cout0 <= CCC(1) XOR sub;
	
	inv1: inv port map(half, i);
	and1: and_2 port map(i, CCC(1), a1);
	and2: and_2 port map(half, sub, a2);
	or1: or_2 port map(a1, a2, carry);
	
end structure;