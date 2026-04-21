library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter4 is
    Port ( CLK : in  STD_LOGIC;
           DIRECTION : in  STD_LOGIC;
           COUNT_OUT : out  STD_LOGIC_VECTOR (3 downto 0));
end Counter4;

architecture Behavioral of Counter4 is

signal count_int : std_logic_vector(3 downto 0) := "0000";

begin

process (CLK)
begin
   if CLK='1' and CLK'event then
      if DIRECTION ='1' then
         count_int <= count_int + 1;
      else
         count_int <= count_int - 1;
      end if;
   end if;
end process;

COUNT_OUT <= count_int;

end Behavioral;