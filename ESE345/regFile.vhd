library ieee;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;

entity regFile is									--Register File		
	port(
		rs : in std_logic_vector(3 downto 0);			--Source Register
		rt : in std_logic_vector(3 downto 0);	 		--Source Register
		rd : in std_logic_vector(3 downto 0); 			--Destination Register
		
		din : in std_logic_vector(63 downto 0);	 		--Data Input
		dout : out std_logic_vector(63 downto 0);	 	--Data Out From Rs
		dout2 : out std_logic_vector(63 downto 0));		--Data Output From Rt
	
end regFile;

architecture regFile of regFile is
	--signal r0 : std_logic_vector(63 downto 0) := (others => '0');	 		--Register 0
	--signal r1 : std_logic_vector(63 downto 0) := (others => '0');			--Register 1
	--signal r2 : std_logic_vector(63 downto 0) := (others => '0');			--Register 2
	--signal r3 : std_logic_vector(63 downto 0) := (others => '0');	   		--Register 3
	--signal r4 : std_logic_vector(63 downto 0) := (others => '0');	   		--Register 4
	--signal r5 : std_logic_vector(63 downto 0) := (others => '0');	  		--Register 5 
	signal r0 : std_logic_vector(63 downto 0) := x"0101010101010101";		--For Debugging
	signal r1 : std_logic_vector(63 downto 0) := x"1010101010101010";		--For Debugging
	signal r2 : std_logic_vector(63 downto 0) := x"0101010101010101";		--For Debugging
	signal r3 : std_logic_vector(63 downto 0) := x"0002000200040004";		--For Debugging
	signal r4 : std_logic_vector(63 downto 0) := x"3333222211110000";		--For Debugging
	signal r5 : std_logic_vector(63 downto 0) := x"5555000000001111";		--For Debugging
	signal r6 : std_logic_vector(63 downto 0) := (others => '0');		   	--Register 6
	signal r7 : std_logic_vector(63 downto 0) := (others => '0');			--Register 7
	signal r8 : std_logic_vector(63 downto 0) := (others => '0');	   		--Register 8
	signal r9 : std_logic_vector(63 downto 0) := (others => '0');	  		--Register 9
	signal r10 : std_logic_vector(63 downto 0) := (others => '0');	   		--Register 10
	signal r11 : std_logic_vector(63 downto 0) := (others => '0');	  		--Register 11
	signal r12 : std_logic_vector(63 downto 0) := (others => '0');	  		--Register 12
	signal r13 : std_logic_vector(63 downto 0) := (others => '0');			--Register 13					  
	signal r14 : std_logic_vector(63 downto 0) := (others => '0');	  		--Register 14
	signal r15 : std_logic_vector(63 downto 0) := (others => '0');		   	--Register 15 
	
	--signal r1 : std_logic_vector(63 downto 0) := std_logic_vector(to_unsigned(4234242, r0'length));			 
	
begin 
	process(rs, rt, rd, din)					--Write Process
	begin	 
		
		case rd is						 	 
			when "0000" => r0 <= din;	
			when "0001" => r1 <= din;
			when "0010" => r2 <= din;
			when "0011" => r3 <= din;
			when "0100" => r4 <= din;
			when "0101" => r5 <= din;
			when "0110" => r6 <= din;
			when "0111" => r7 <= din;
			when "1000" => r8 <= din;
			when "1001" => r9 <= din;
			when "1010" => r10 <= din;
			when "1011" => r11 <= din;
			when "1100" => r12 <= din;	 
			when "1101" => r13 <= din;
			when "1110" => r14 <= din;
			when "1111" => r15 <= din;	
			when others => NULL;
		end case;
		
		case rs is								 	--Else Read Selected Register
			when "0000" => dout <= r0;	
			when "0001" => dout <= r1;
			when "0010" => dout <= r2;
			when "0011" => dout <= r3;
			when "0100" => dout <= r4;
			when "0101" => dout <= r5;
			when "0110" => dout <= r6;
			when "0111" => dout <= r7;
			when "1000" => dout <= r8;
			when "1001" => dout <= r9;
			when "1010" => dout <= r10;
			when "1011" => dout <= r11;
			when "1100" => dout <= r12;
			when "1101" => dout <= r13;
			when "1110" => dout <= r14;
			when "1111" => dout <= r15;	 
			when others => NULL;
		end case; 
		
		case rt is								  	
			when "0000" => dout2 <= r0;	
			when "0001" => dout2 <= r1;
			when "0010" => dout2 <= r2;
			when "0011" => dout2 <= r3;
			when "0100" => dout2 <= r4;
			when "0101" => dout2 <= r5;
			when "0110" => dout2 <= r6;
			when "0111" => dout2 <= r7;
			when "1000" => dout2 <= r8;
			when "1001" => dout2 <= r9;
			when "1010" => dout2 <= r10;
			when "1011" => dout2 <= r11;
			when "1100" => dout2 <= r12;
			when "1101" => dout2 <= r13;
			when "1110" => dout2 <= r14;
			when "1111" => dout2 <= r15;	 
			when others => NULL;
		end case;
		
		---Bypass logic	
		if(rs = rd) then				 
			dout <= din;
		end if;
		
		if(rt = rd) then				 
			dout2 <= din;
		end if;
		
		
	end process;
	
	
end regFile;






