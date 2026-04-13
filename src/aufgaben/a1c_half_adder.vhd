library ieee;
use ieee.std_logic_1164.all;

entity a1c_half_adder is
    port (
        a : in std_logic;
        b : in std_logic;
        s : out std_logic;
        c_out : out std_logic 
    );
end entity;

architecture rtl of a1c_half_adder is
begin

    c_out <= a and b;
    s <= a xor b;

end architecture;