library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity a1_mux is
    port (
        x : in std_logic_vector(3 downto 0);
        s : in std_logic_vector(1 downto 0);
        y : out std_logic
    );
end entity;

architecture rtl of a1_mux is
begin
    y <= x(3) when s = "11"
        else x(2) when s = "10"
        else x(1) when s = "01"
        else x(0);
end architecture;