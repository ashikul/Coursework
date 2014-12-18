library ieee;
use ieee.std_logic_1164.all;

entity mmx_proc is
	port(clk : in std_logic;
		lvData : in std_logic_vector(63 downto 0);
		dataIntoInstructBuff : in std_logic_vector(15 downto 0);
		instructBuffWrite : in std_logic;
		result : out std_logic_vector(63 downto 0);	
		QinstructBuffOut : out std_logic_vector(15 downto 0);
		Qrs : out std_logic_vector(3 downto 0);
		Qrt : out std_logic_vector(3 downto 0);
		Qrd : out std_logic_vector(3 downto 0);
		Qopcode : out std_logic_vector(3 downto 0);
		QopcodeFromInstructExec : out std_logic_vector(3 downto 0);
		Qoldrd : out std_logic_vector(3 downto 0);
		Qoperand1 : out std_logic_vector(63 downto 0);
		Qoperand2 : out std_logic_vector(63 downto 0));	
	
	
end mmx_proc;

architecture mmx_proc of mmx_proc is
	
	
	signal instructBuffOut : std_logic_vector(15 downto 0);
	signal rs : std_logic_vector(3 downto 0);
	signal rt : std_logic_vector(3 downto 0); 
	signal rd : std_logic_vector(3 downto 0);
	signal regIn : std_logic_vector(63 downto 0);
	signal rsData : std_logic_vector(63 downto 0);
	signal rtData : std_logic_vector(63 downto 0);
	signal opcode : std_logic_vector(3 downto 0);
	signal operand1 : std_logic_vector(63 downto 0);
	signal operand2 : std_logic_vector(63 downto 0); 
	signal sigresult : std_logic_vector(63 downto 0);
	signal opcodeFromInstructExec : std_logic_vector(3 downto 0); 
	signal oldrd : std_logic_vector(3 downto 0);
	
begin
	
	u0 : entity instructBuff   
	port map(clk => clk,
		din => dataIntoInstructBuff,
		dout => instructBuffOut,
		write => instructBuffWrite);
	
	u1 : entity regFile
	port map(
		rs => rs,
		rt => rt,
		rd => oldrd,
		
		din => regIn,
		dout => rsData,
		dout2 => rtData
		);
	
	u2 : entity instructFetchDecode
	port map(clk => clk,
		din => instructBuffOut,
		rs => rs,
		rt => rt,
		rd => rd,
		opcode => opcode,
		writein => instructBuffWrite);
	
	u3 : entity instructExec
	port map(clk => clk,
		opcode => opcode,
		rsData => rsData,
		rtData => rtData,
		operand1 => operand1,
		operand2 => operand2,
		writein => instructBuffWrite,
		opcodeOut => opcodeFromInstructExec,
		rdData => regIn,
		--rdresult => sigresult, 
		newrd => rd,
		oldrd => oldrd
		
		);	 
	
	u4 : entity TOPmmxalu
	port map( 	
		lvData => lvData,
		opcode => opcodeFromInstructExec,
		operand1 => operand1,
		operand2 => operand2,
		result => regIn
		);
	
	result <= regIn; 
	QinstructBuffOut <= instructBuffOut;
	Qrs <= rs;
	Qrt <= rt;
	Qrd <= rd;
	Qopcode <= opcode;
	QopcodeFromInstructExec <= opcodeFromInstructExec;
	Qoldrd <= oldrd;
	Qoperand1 <= operand1;
	Qoperand2 <= operand2;
	
end mmx_proc;

