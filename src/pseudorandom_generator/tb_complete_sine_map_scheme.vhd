library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;

ENTITY tb_complete_sine_map_scheme IS
END tb_complete_sine_map_scheme;

ARCHITECTURE behavior OF tb_complete_sine_map_scheme IS

	-- Component Declaration for the Unit Under Test (UUT)

	component complete_scheme is
		port (clk, rst: in std_logic;
          X : in  std_logic_vector(31 downto 0);
          Y : out  std_logic_vector(31 downto 0)
			 );
	end component;
	
	signal	A  :  std_logic_vector(31 downto 0) := (others => '0'); -- Input A
	--signal	B  :  std_logic_vector(31 downto 0) := (others => '0'); -- Input B
	signal	S  :  std_logic_vector(31 downto 0) := (others => '0'); -- Result S
	
	--signal saida_inversor : std_logic_vector(31 downto 0) := (others => '0'); 
	--signal	en1  :  std_logic; -- Enable

	signal clk : std_logic := '0';
	signal clkk : std_logic := '0';
	signal rst : std_logic;

	signal read_data_A   : std_logic:='0';
	--signal read_data_B   : std_logic:='0';
	signal flag_write    : std_logic:='0';
	--

	file   inputs_data_in1 : text open read_mode  is "input_A.txt";
	--file   inputs_data_in2 : text open read_mode  is "input_B.txt";

	file   outputs         : text open write_mode is "output_S.txt";

	-- Clock period definitions
	constant PERIOD     : time := 10 ns; -- Aproximadamente 230 MHz ---> 4.34782609 ns;
	constant DUTY_CYCLE : real := 0.5;
	constant OFFSET     : time := 5 ns;
	constant MAX_VALUE	: integer := 1009;
	constant OFFSET_TO_WRITE     : time := 1500000 ps;
	constant PERIOD_TO_WRITE     : time := 2550000 ps;

	BEGIN
		-- Instantiate the Unit Under Test (UUT) or Design Under Test (DUT)
		DUT: complete_scheme
		port map(
			clk      => clk,
			rst      => rst,
			X        => A,
			Y        => S
		);

------------------------------------------------------------------------------------
----------------- Process to generate the clock signal
------------------------------------------------------------------------------------
		PROCESS    -- clock process for clock
		BEGIN
			WAIT for OFFSET;
			CLOCK_LOOP : LOOP
				clk <= '0';
				WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
				clk <= '1';
				WAIT FOR (PERIOD * DUTY_CYCLE);
			END LOOP CLOCK_LOOP;
		END PROCESS;

------------------------------------------------------------------------------------
----------------- Process for introducing the reset stimulus
------------------------------------------------------------------------------------
sreset: process
begin
	rst <= '1';
	wait until rising_edge(clk);
	rst <= '0';
	wait;
end process sreset;


------------------------------------------------------------------------------------
----------------- Process for reading the input on input_A.txt file
------------------------------------------------------------------------------------
read_inputs_data_in1:process
		variable fileLine : line;
		variable input    : std_logic_vector(31 downto 0);
	begin
		wait until rising_edge(clk);
		while not endfile(inputs_data_in1) loop
			  if read_data_A = '1' then
				 readline(inputs_data_in1,fileLine);
				 read(fileLine,input);
				 A <= input;
			  end if;
			  wait for PERIOD;
		end loop;
		wait;
	end process read_inputs_data_in1;

------------------------------------------------------------------------------------
----------------- Process for reading the input on input_B.txt file
------------------------------------------------------------------------------------
 --read_inputs_data_in2:process
		--variable fileLine : line;
		--variable input    : std_logic_vector(31 downto 0);
	--begin
		--wait until rising_edge(clk);
		--while not endfile(inputs_data_in2) loop
			--   if read_data_B = '1' then
		--		  readline(inputs_data_in2,fileLine);
	--			  read(fileLine,input);
--				  B <= input;
--			   end if;
--			   wait for PERIOD;
--		 end loop;
--		 wait;
--	 end process read_inputs_data_in2;

------------------------------------------------------------------------------------
----------------- Process to generate the data input stimulus
------------------------------------------------------------------------------------

tb_stimulus_A : PROCESS
	BEGIN
		 WAIT FOR (OFFSET + PERIOD);
			 read_data_A <= '1';
			 for i in 1 to MAX_VALUE loop
				 wait for PERIOD;
			 end loop;
			 read_data_A <= '0';
		 WAIT;
	END PROCESS tb_stimulus_A;

--tb_stimulus_B : PROCESS
--	BEGIN
--		 WAIT FOR (OFFSET + PERIOD);
--			 read_data_B <= '1';
--			 for i in 1 to MAX_VALUE loop
--				 wait for PERIOD;
--			 end loop;
--			 read_data_B <= '0';
--		 WAIT;
--	END PROCESS tb_stimulus_B;

------------------------------------------------------------------------------------
------ Process to generate the output file
------------------------------------------------------------------------------------
write_outputs_stimulus : PROCESS
    variable fileLine  : line;
	variable output : std_logic_vector (31 downto 0);
	BEGIN
		 WAIT FOR (OFFSET_TO_WRITE);
			 output := S;
		     write(fileLine,output);
			 writeline(outputs,fileLine);
			 for i in  1 to 100000 loop
				 wait for PERIOD_TO_WRITE;
				 output := S;
		     	 write(fileLine,output);
			     writeline(outputs,fileLine);
			 end loop;
			 wait;
	END PROCESS write_outputs_stimulus;
END;
