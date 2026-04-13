library ieee;
use ieee.std_logic_1164.all;

entity a1c_full_adder is
    port (
        a : in std_logic;
        b : in std_logic;
        c_in : in std_logic;
        s : out std_logic;
        c_out : out std_logic 
    );
end entity;

architecture rtl of a1c_full_adder is
    signal s1 : std_logic;
    signal c1, c2 : std_logic;
begin

    ha1: entity work.a1c_half_adder
        port map (
            a => a,
            b => b,
            s => s1,
            c_out => c1
        );
    ha2: entity work.a1c_half_adder
            port map (
                a => s1,
                b => c_in,
                s => s,
                c_out => c2
            );

    c_out <= c1 or c2;

end architecture;