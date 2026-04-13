library ieee;
use ieee.std_logic_1164.all;

entity a2_adder4 is
    port (
        a : in std_logic_vector(3 downto 0);
        b : in std_logic_vector(3 downto 0);
        c_in : in std_logic;
        s : out std_logic_vector(3 downto 0);
        c_out : out std_logic
    );
end entity;

architecture rtl of a2_adder4 is
    signal carries : std_logic_vector(4 downto 0);
begin

    carries(0) <= c_in;
    c_out <= carries(4);

    gen_full_adders: for i in a'range generate
        full_adder: entity work.a1b_full_adder
            port map (
                a => a(i),
                b => b(i),
                c_in => carries(i),
                s => s(i),
                c_out => carries(i+1)
            );
    end generate;

end architecture;