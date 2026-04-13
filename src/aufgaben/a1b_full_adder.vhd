library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity a1b_full_adder is
    port (
        a : in std_logic;
        b : in std_logic;
        c_in : in std_logic;
        s : out std_logic;
        c_out : out std_logic 
    );
end entity;

architecture rtl of a1b_full_adder is
begin

    s <= (not a and not b and c_in) or (not a and b and not c_in) or (a and not b and not c_in) or (a and b and c_in);
    c_out <= (a and b) or (a and c_in) or (b and c_in);

end architecture;