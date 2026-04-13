library ieee;
use ieee.std_logic_1164.ALL;
 
entity a3_counter4_async_tb is
end entity;
 
architecture rtl of a3_counter4_async_tb is

   -- Constants
   constant clk_period : time := 20 ns;

   -- Inputs
   signal clk : std_logic := '0';
   signal arst : std_logic := '0';

 	-- Outputs
   signal count : std_logic_vector(3 downto 0);
 
begin

   counter: entity work.a3_counter4_async
      port map (
            clk => clk,
            arst => arst,
            count => count
         );

   clk_process: process
   begin
      wait for clk_period/2;
		clk <= not clk;
   end process;
 

   process
   begin		

      wait for clk_period/20;
		arst <= '1';
      wait for clk_period/20;
      assert count = "0000";
      wait for clk_period/20;
      arst <= '0';
      wait for clk_period/20;
      assert count = "0000";

      wait for clk_period;
      assert count = "0001";
      wait for clk_period;
      assert count = "0010";
      wait for clk_period;
      assert count = "0011";
      wait for clk_period;
      assert count = "0100";
      wait for clk_period;
      assert count = "0101";
      wait for clk_period;
      assert count = "0110";
      wait for clk_period;
      assert count = "0111";
      wait for clk_period;
      wait for clk_period;
      assert count = "1001";
      wait for clk_period;
      assert count = "1010";
      wait for clk_period;
      assert count = "1011";
      wait for clk_period;
      assert count = "1100";
      wait for clk_period;
      assert count = "1101";
      wait for clk_period;
      assert count = "1110";
      wait for clk_period;
      assert count = "1111";
      wait for clk_period;
      assert count = "0000";
      wait for clk_period;
      assert count = "0001";

      wait;
   end process;

end;
