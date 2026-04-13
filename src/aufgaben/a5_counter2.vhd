library ieee;
use ieee.std_logic_1164.all;

entity a5_counter2 is
    port (
        clk : in std_logic;
        RESn : in std_logic; -- Reset bei 0
        UD : in std_logic; -- Up bei 1, Down bei 0
        count : out std_logic_vector(1 downto 0)
    );
end entity;

architecture rtl of a5_counter2 is
    signal q : std_logic_vector(1 downto 0);
    signal qn : std_logic_vector(1 downto 0);
begin

    count <= q;
    qn(0) <= not q(0);
    qn(1) <= not q(1) when ((q(0) and UD) or (not q(0) and not UD)) = '1' else q(1);

    process(clk)
    begin
        if rising_edge(clk) then
            if RESn = '0' then
                q <= (others => '0');
            else
                q <= qn;
            end if;
        end if;
    end process;

end architecture;