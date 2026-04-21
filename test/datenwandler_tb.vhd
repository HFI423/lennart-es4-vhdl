LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY datenwandler_tb IS
END datenwandler_tb;
 
ARCHITECTURE behavior OF datenwandler_tb IS 
 
    COMPONENT datenwandler
    PORT(
         clk : IN  std_logic;
         ens : IN  std_logic;
         d : IN  std_logic;
         q : OUT  std_logic_vector(7 downto 0);
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ens : std_logic := '0';
   signal d : std_logic := '0';

 	--Outputs
   signal q : std_logic_vector(7 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: datenwandler PORT MAP (
          clk => clk,
          ens => ens,
          d => d,
          q => q,
          done => done
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

		ens <= '1';
      d <= '1';
		assert done = '0';
		wait for clk_period;
      d <= '0';
		assert done = '0';
		wait for clk_period;
      d <= '1';
		assert done = '0';
		wait for clk_period;
      d <= '0';
		assert done = '0';
		wait for clk_period;
      d <= '1';
		assert done = '0';
		wait for clk_period;
      d <= '0';
		assert done = '0';
		wait for clk_period;
      d <= '1';
		assert done = '0';
		wait for clk_period;
      d <= '0';
		assert done = '0';
		wait for clk_period;
		assert done = '1';
		assert q = "10101010";
		wait for clk_period;
		assert done = '0';

      wait;
   end process;

END;
