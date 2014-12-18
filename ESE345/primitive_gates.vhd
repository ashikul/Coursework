-----------------------------Inverter Component--------------------------------		
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity inv is
	port(
		i1 : in STD_LOGIC;
		--	     i2 : in STD_LOGIC;
		o1 : out STD_LOGIC
		);
end inv;	

architecture dataflow of inv is
begin
	o1 <= not i1;
end dataflow;

-----------------------------AND Gate Component--------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity and_2 is
	port(
		i1 : in STD_LOGIC;
		i2 : in STD_LOGIC;
		o1 : out STD_LOGIC
		);
end and_2;						

architecture dataflow of and_2 is
begin
	o1 <= i1 and i2;			  		   
end dataflow; 	 

-----------------------------OR Gate Component-------------------------------- 
library ieee;
use ieee.std_logic_1164.all;

entity or_2 is
	port(
		i1 : in STD_LOGIC;
		i2 : in STD_LOGIC;
		o1 : out STD_LOGIC
		);
end or_2;						

architecture dataflow of or_2 is
begin
	o1 <= i1 or i2;			  		   
end dataflow; 

-----------------------------XOR Gate Component-------------------------------- 
library ieee;
use ieee.std_logic_1164.all;

entity xor_2 is
	port(
		i1 : in STD_LOGIC;
		i2 : in STD_LOGIC;
		o1 : out STD_LOGIC
		);
end xor_2;						

architecture dataflow of xor_2 is
begin
	o1 <= i1 xor i2;			  		   
end dataflow;