library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Logical_Shift_Module is
	port(				 
		opcode : in std_logic_vector(3 downto 0);  	-- Operation Code
		a : in std_logic_vector(63 downto 0);		-- Register Input One (RS) Data
		b : in std_logic_vector(63 downto 0);	  	-- Register Input Two (Or Destination) (RT) Data
		r : out std_logic_vector(63 downto 0);		-- Destination Register (RD) Data	  
		lvData : in std_logic_vector(63 downto 0));  
end Logical_Shift_Module;

architecture dataflow of Logical_Shift_Module is		
	
	--////////////////////////////////
	--clz function
	--/////////////////////////////////
	function clz (signal A : std_logic_vector(63 downto 0)) return std_logic_vector is	  
		variable word1 : std_logic_vector(31 downto 0) := A(63 downto 32);
		variable word2 : std_logic_vector(31 downto 0) := A(31 downto 0);
		variable temp1 : integer range 0 to 32 := 0;	 
		variable temp2 : integer range 0 to 32 := 0;	 
		variable count1 : std_logic_vector(31 downto 0);
		variable count2 : std_logic_vector(31 downto 0);
		
	begin  
		
		loop1 : for i in 31 downto 0 loop 
			exit loop1 when word1(i) = '1'; 
			case word1(i) is 
				when '0' => temp1 := temp1 + 1; 
				when others => exit; 
			end case; 
			
		end loop;	
		
		
		if (temp1 = 0) then
			temp1 := 32;
		end if;	
		
		count1 := std_logic_vector(to_unsigned(temp1, 32)); 
		
		loop2 : for i in 31 downto 0 loop 
			exit loop2 when word2(i) = '1'; 
			case word2(i) is 
				when '0' => temp2 := temp2 + 1; 
				when others => exit; 
			end case; 
			
		end loop;		
		
		if (temp2 = 0) then
			temp2 := 32;
		end if;
		
		
		count2 := std_logic_vector(to_unsigned(temp2, 32)); 
		
		
		return count1 & count2;
	end clz;	
	
	
	--/////////////////////////////////////////
	--cntb function							  					
	--/////////////////////////////////////////
	
	function cntb (signal A : std_logic_vector(63 downto 0)) return std_logic_vector is
		variable byte1 : std_logic_vector(7 downto 0) := A(63 downto 56);
		variable byte2 : std_logic_vector(7 downto 0) := A(55 downto 48);
		variable byte3 : std_logic_vector(7 downto 0) := A(47 downto 40);
		variable byte4 : std_logic_vector(7 downto 0) := A(39 downto 32);
		variable byte5 : std_logic_vector(7 downto 0) := A(31 downto 24);
		variable byte6 : std_logic_vector(7 downto 0) := A(23 downto 16);
		variable byte7 : std_logic_vector(7 downto 0) := A(15 downto 8);	  	 
		variable byte8 : std_logic_vector(7 downto 0) := A(7 downto 0);	 
		
		variable temp1 : integer range 0 to 8; 
		variable temp2 : integer range 0 to 8;
		variable temp3 : integer range 0 to 8;
		variable temp4 : integer range 0 to 8;
		variable temp5 : integer range 0 to 8;
		variable temp6 : integer range 0 to 8;
		variable temp7 : integer range 0 to 8;
		variable temp8 : integer range 0 to 8;	   
		
		variable count1 : std_logic_vector(7 downto 0);
		variable count2 : std_logic_vector(7 downto 0);
		variable count3 : std_logic_vector(7 downto 0);
		variable count4 : std_logic_vector(7 downto 0);
		variable count5 : std_logic_vector(7 downto 0);
		variable count6 : std_logic_vector(7 downto 0);
		variable count7 : std_logic_vector(7 downto 0);
		variable count8 : std_logic_vector(7 downto 0);
		
	begin
		
		loop1 : for i in 7 downto 0 loop
			case byte1(i) is
				when '1' => temp1 := temp1 + 1;
				when others => next;
			end case;
		end loop;	
		count1 := std_logic_vector(to_signed(temp1, 8)); 
		
		loop2 : for i in 7 downto 0 loop
			case byte2(i) is
				when '1' => temp2 := temp2 + 1;
				when others => next;
			end case;
		end loop; 
		count2 := std_logic_vector(to_signed(temp2, 8)); 
		
		loop3 : for i in 7 downto 0 loop
			case byte3(i) is
				when '1' => temp3 := temp3 + 1;
				when others => next;
			end case;
		end loop;	  
		count3 := std_logic_vector(to_signed(temp3, 8)); 
		
		loop4 : for i in 7 downto 0 loop
			case byte4(i) is
				when '1' => temp4 := temp4 + 1;
				when others => next;
			end case;
		end loop;		 	  
		count4 := std_logic_vector(to_signed(temp4, 8)); 
		
		loop5 : for i in 7 downto 0 loop
			case byte5(i) is
				when '1' => temp5 := temp5 + 1;
				when others => next;
			end case;
		end loop;	   
		count5 := std_logic_vector(to_signed(temp5, 8)); 
		
		loop6 : for i in 7 downto 0 loop
			case byte6(i) is
				when '1' => temp6 := temp6 + 1;
				when others => next;
			end case;
		end loop;								  
		count6 := std_logic_vector(to_signed(temp6, 8)); 
		
		loop7 : for i in 7 downto 0 loop
			case byte7(i) is
				when '1' => temp7 := temp7 + 1;
				when others => next;
			end case;
		end loop;								  
		count7 := std_logic_vector(to_signed(temp7, 8)); 
		
		loop8 : for i in 7 downto 0 loop
			case byte8(i) is
				when '1' => temp8 := temp8 + 1;
				when others => next;
			end case;
		end loop;				  
		count8 := std_logic_vector(to_signed(temp8, 8)); 
		
		return count1 & count2 & count3 & count4 & count5 & count6 & count7 & count8; 
		
	end cntb;
	
	
	--//////////////////////////////////
	--shlhi (Shift left halfword immediate) function	 
	--packed 16-bit halfword shift left logical of the contents of register rs1 by the 4-bit immediate value of instruction field rs2. 
	--Each of the results is placed into the corresponding 16-bit slot in register rd.
	--//////////////////////////////////
	
	function shlhi (signal A : std_logic_vector(63 downto 0); signal B : std_logic_vector(3 downto 0)) return std_logic_vector is
		
		variable halfWord1 : std_logic_vector(15 downto 0) := A(63 downto 48);	--The first set of 16 bits (from Most Significant)
		variable halfWord2 : std_logic_vector(15 downto 0) := A(47 downto 32);	--The second set of 16 bits (from Most Significant)
		variable halfWord3 : std_logic_vector(15 downto 0) := A(31 downto 16);  --The third set of 16 bits (from Most Significant)
		variable halfWord4 : std_logic_vector(15 downto 0) := A(15 downto 0); 	--The Least Significant 16 Bits
		
		variable halfWord1Shift : std_logic_vector(15 downto 0) := std_logic_vector(unsigned(halfWord1) sll to_integer(unsigned(B)));	   
		variable halfWord2Shift : std_logic_vector(15 downto 0) := std_logic_vector(unsigned(halfWord2) sll to_integer(unsigned(B)));
		variable halfWord3Shift : std_logic_vector(15 downto 0) := std_logic_vector(unsigned(halfWord3) sll to_integer(unsigned(B)));
		variable halfWord4Shift : std_logic_vector(15 downto 0) := std_logic_vector(unsigned(halfWord4) sll to_integer(unsigned(B)));
		
	begin  
		
		return halfWord1Shift & halfWord2Shift & halfWord3Shift & halfWord4Shift;
		
	end shlhi;	
	
	--////////////////////////////////////////
	--mpyu function
	--///////////////////////////////////////
	
	function mpyu (signal A : std_logic_vector(63 downto 0); signal B : std_logic_vector(63 downto 0)) return std_logic_vector is
		
		variable halfWord1 : std_logic_vector(15 downto 0) := A(47 downto 32);
		variable halfWord2 : std_logic_vector(15 downto 0) := A(15 downto 0);
		variable halfWord3 : std_logic_vector(15 downto 0) := B(47 downto 32);
		variable halfWord4 : std_logic_vector(15 downto 0) := B(15 downto 0);
		
		variable word1 : std_logic_vector(31 downto 0) := std_logic_vector(unsigned(halfWord1) * unsigned(halfWord3));
		variable word2 : std_logic_vector(31 downto 0) := std_logic_vector(unsigned(halfWord2) * unsigned(halfWord4));
		
	begin
		
		return word1 & word2;
		
	end mpyu;		 
	
	--////////////////////////////////////////
	--absdb function  
	--absolute difference of bytes: the contents of each of the eight byte slots in 
	--register rs2 is subtracted from the contents of the corresponding byte slot in register rs1. 
	--The absolute value of each of the results is placed into the corresponding byte slot in register rd.
	--///////////////////////////////////////
	
	function absdb (signal A : std_logic_vector(63 downto 0); signal B : std_logic_vector(63 downto 0)) return std_logic_vector is
		
		variable byte1a : std_logic_vector(7 downto 0) := A(63 downto 56); 	 
		variable byte2a : std_logic_vector(7 downto 0) := A(55 downto 48);
		variable byte3a : std_logic_vector(7 downto 0) := A(47 downto 40);
		variable byte4a : std_logic_vector(7 downto 0) := A(39 downto 32);
		variable byte5a : std_logic_vector(7 downto 0) := A(31 downto 24);
		variable byte6a : std_logic_vector(7 downto 0) := A(23 downto 16);
		variable byte7a : std_logic_vector(7 downto 0) := A(15 downto 8);
		variable byte8a : std_logic_vector(7 downto 0) := A(7 downto 0);
		
		variable byte1b : std_logic_vector(7 downto 0) := B(63 downto 56); 	 
		variable byte2b : std_logic_vector(7 downto 0) := B(55 downto 48);
		variable byte3b : std_logic_vector(7 downto 0) := B(47 downto 40);
		variable byte4b : std_logic_vector(7 downto 0) := B(39 downto 32);
		variable byte5b : std_logic_vector(7 downto 0) := B(31 downto 24);
		variable byte6b : std_logic_vector(7 downto 0) := B(23 downto 16);
		variable byte7b : std_logic_vector(7 downto 0) := B(15 downto 8);
		variable byte8b : std_logic_vector(7 downto 0) := B(7 downto 0);
		
		variable word1 : std_logic_vector(7 downto 0) := std_logic_vector(abs(signed(byte1a) - signed(byte1b)));
		variable word2 : std_logic_vector(7 downto 0) := std_logic_vector(abs(signed(byte2a) - signed(byte2b)));
		variable word3 : std_logic_vector(7 downto 0) := std_logic_vector(abs(signed(byte3a) - signed(byte3b)));
		variable word4 : std_logic_vector(7 downto 0) := std_logic_vector(abs(signed(byte4a) - signed(byte4b)));
		variable word5 : std_logic_vector(7 downto 0) := std_logic_vector(abs(signed(byte5a) - signed(byte5b)));
		variable word6 : std_logic_vector(7 downto 0) := std_logic_vector(abs(signed(byte6a) - signed(byte6b)));
		variable word7 : std_logic_vector(7 downto 0) := std_logic_vector(abs(signed(byte7a) - signed(byte7b)));
		variable word8 : std_logic_vector(7 downto 0) := std_logic_vector(abs(signed(byte8a) - signed(byte8b)));
		
		
	begin
		
		return word1 & word2 & word3 & word4 & word5 & word6 & word7 & word8;
		
	end absdb;
	
	
	--temporary signal declaration.
	signal operand1,operand2  : std_logic_vector(63 downto 0) := (others => '0');
	
	
	
	
	
begin	
	
	process(opcode, a, b, lvData)
		
		
		variable result  : std_logic_vector(63 downto 0) := (others => '0');	 
		
		
	begin		
		
		case opcode is 
			when "1010" => 
			r <= clz(a); 
			when "1001" => 
			r <= cntb(a);  
			when "0001" => 
			r <= mpyu(a, b);
			when "1000" => 																									  
			r <= shlhi(a, b(3 downto 0)); --Logical Shift 
			when "0000" => 
			r <= absdb(operand1, operand2);
			when "1101" => 
			r <= a and b;  --AND gate
			when "1100" => 
			r <=  a or b;   --OR gate    
			when "1011" => 
			r <= operand1 xor operand2;  --XOR gate  
			when "1110" =>		 
			r <= lvData; --LV
			when "1111" => 		
			r <= (others => 'Z');		   --nop
			when others =>		  
			r <= std_logic_vector(to_unsigned(0, r'length));
		end case; 
		
		
		--		
	end process;    
	
	
	
end dataflow;