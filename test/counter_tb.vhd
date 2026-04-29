library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity counter_tb is
end counter_tb;
 
architecture rtl of counter_tb is 
 
   -- Constants
   constant clk_period : time := 5 ns;

   -- Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   signal up : std_logic := '0';

 	-- Outputs
   signal count : std_logic_vector(7 downto 0);

begin

   counter: entity work.counter
      generic map (
         size => count'length 
      )
		port map (
         clk => clk,
         rst => rst,
         en => en,
         up => up,
         count => count
        );

   clk_process: process
   begin
      wait for clk_period/2;
      clk <= not clk;
   end process;
 
   process
   begin

		rst <= '1';
		en <= '0';
		up <= '1';
      wait for clk_period;
      assert count = "00000000";
		
		rst <= '0';
		wait for clk_period*5;
      assert count = "00000000";
		
		en <= '1';
		wait for clk_period;
      assert count = "00000001";
		
		en <= '0';
		wait for clk_period;
      assert count = "00000001";
		
		en <= '1';
		wait for clk_period*20;
      assert count = "00010101";
		
		en <= '0';
		wait for clk_period*5; 
      assert count = "00010101";
		
		rst <= '1';
		wait for clk_period;
      assert count = "00000000";
		
		rst <= '0';
		wait for clk_period*10;
      assert count = "00000000";
		
		en <= '1';
      wait until count = "11111111";
      wait until clk = '0';
      wait for clk_period;
      assert count = "00000000";

      report "Done";

      wait;
   end process;

END;
