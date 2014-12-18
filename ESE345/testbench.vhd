library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity testbench is
end testbench;

architecture testbench of testbench is
	signal clk : std_logic := '0';	 	 
	signal lvData : std_logic_vector(63 downto 0);
	signal dataInToInstructBuff : std_logic_vector(15 downto 0);	
	signal instructBuffWrite : std_logic;	  
	
	signal IF_instruction : std_logic_vector(15 downto 0);
	signal ID_opcode : std_logic_vector(3 downto 0);
	signal ID_rs2 : std_logic_vector(3 downto 0);
	signal ID_rs1 : std_logic_vector(3 downto 0); 
	signal ID_rd : std_logic_vector(3 downto 0); 
	signal EX_opcode : std_logic_vector(3 downto 0);
	signal EX_rs2Data : std_logic_vector(63 downto 0);
	signal EX_rs1Data : std_logic_vector(63 downto 0); 
	signal WB_rd : std_logic_vector(3 downto 0);  
	signal WB_result : std_logic_vector(63 downto 0);
	
	constant period : time := 50 ns;
	
begin	
	UUT : entity mmx_proc										 
	port map(clk => clk,
		lvData => lvData,
		dataIntoInstructBuff => dataIntoInstructBuff,
		result => WB_result,
		instructBuffWrite => instructBuffWrite,
		QinstructBuffOut => IF_instruction,
		Qrs => ID_rs2,  
		Qrt => ID_rs1, 
		Qrd => ID_rd, 
		Qopcode => ID_opcode, 
		QopcodeFromInstructExec => EX_opcode,  
		Qoldrd => WB_rd,  
		Qoperand1 => EX_rs1Data, 
		Qoperand2 => EX_rs2Data 
		);
	
	clk <= not clk after period/2;
	
	process	 
		
		variable s : line;
		variable cnt : integer:=0;
		
		
	begin
		instructBuffWrite <= '1'; 
		
		--lvData <= std_logic_vector(to_unsigned(16, lvData'length));	 
		lvData <= x"0000FFFF0000FFFF";
		
		for I in 1 to 16 loop
			
			case cnt is
				--							when 0 => dataIntoInstructBuff <=  x"E12A";	
				--							when 1 => dataIntoInstructBuff <=  x"E122";
				--							when 2 => dataIntoInstructBuff <=  x"C133";
				--							when 3 => dataIntoInstructBuff <=  x"C454";
				--							when 4 => dataIntoInstructBuff <=  x"C124";
				--							when 5 => dataIntoInstructBuff <=  x"B243";
				--							when 6 => dataIntoInstructBuff <=  x"D424";
				--							when 7 => dataIntoInstructBuff <=  x"C153";
				--							when 8 => dataIntoInstructBuff <=  x"B254";
				--							when 9 => dataIntoInstructBuff <=  x"C452";
				--							when 10 => dataIntoInstructBuff <=  x"D01B";
				--							when 11 => dataIntoInstructBuff <=  x"B20C";
				--							when 12 => dataIntoInstructBuff <=  x"C31D";
				--							when 13 => dataIntoInstructBuff <=  x"D15E";
				--							when 14 => dataIntoInstructBuff <=  x"B21F";
				--							when 15 => dataIntoInstructBuff <=  x"E001"; 
				
				
				when 0 => dataIntoInstructBuff <=  x"E001";	
				when 1 => dataIntoInstructBuff <=  x"1122";
				when 2 => dataIntoInstructBuff <=  x"2133";
				when 3 => dataIntoInstructBuff <=  x"3454";
				when 4 => dataIntoInstructBuff <=  x"4124";
				when 5 => dataIntoInstructBuff <=  x"5123";
				when 6 => dataIntoInstructBuff <=  x"6424";
				when 7 => dataIntoInstructBuff <=  x"7863";
				when 8 => dataIntoInstructBuff <=  x"8254";
				when 9 => dataIntoInstructBuff <=  x"9452";
				when 10 => dataIntoInstructBuff <=  x"F01B";
				when 11 => dataIntoInstructBuff <=  x"B20C";
				when 12 => dataIntoInstructBuff <=  x"C31D";
				when 13 => dataIntoInstructBuff <=  x"D10E";
				when 14 => dataIntoInstructBuff <=  x"021F";
				when 15 => dataIntoInstructBuff <=  x"E001";
				
				when others => NULL;
			end case; 
			
			 
			write(s, cnt);
			write(s, string'("---Loading instruction: "));
			cnt := cnt + 1;
			write(s, dataIntoInstructBuff);
			writeline(output, s);  
			wait for period;
		end loop;
		
		instructBuffWrite <= '0';
		dataIntoInstructBuff <=  x"0000";
		
		wait;
	end process;
	
	
end testbench;



