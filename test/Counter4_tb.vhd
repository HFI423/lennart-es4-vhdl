LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY counter4_tb IS
END counter4_tb;
 
ARCHITECTURE behavior OF counter4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Counter4
    PORT(
         CLK : IN  std_logic;
         DIRECTION : IN  std_logic;
         COUNT_OUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal DIRECTION : std_logic := '0';

 	--Outputs
   signal COUNT_OUT : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter4 PORT MAP (
          CLK => CLK,
          DIRECTION => DIRECTION,
          COUNT_OUT => COUNT_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns; -- hold reset state for 100 ns.	
      wait for CLK_period*25;
		DIRECTION <= '1';
      wait;
   end process;

END;
