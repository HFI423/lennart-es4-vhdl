LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY counter_tb IS
END counter_tb;
 
ARCHITECTURE behavior OF counter_tb IS 
    
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal en : std_logic := '0';
   signal up : std_logic := '0';

 	--Outputs
   signal count : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.counter
		port map (
          clk => clk,
          reset => reset,
          en => en,
          up => up,
          count => count
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '1';
		en <= '0';
		up <= '1';
      wait for clk_period;
		
		reset <= '0';
		wait for clk_period*5;
		
		en <= '1';
		wait for clk_period;
		
		en <= '0';
		wait for clk_period;
		
		en <= '1';
		wait for clk_period*20;
		
		en <= '0';
		wait for clk_period*5;
		
		reset <= '1';
		wait for clk_period;
		
		reset <= '0';
		wait for clk_period*10;
		
		en <= '1';

      wait;
   end process;

END;
