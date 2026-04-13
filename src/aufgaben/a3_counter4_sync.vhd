library ieee;
use ieee.std_logic_1164.all;

entity a3_counter4_sync is
    port (
        clk : in std_logic;
        rst : in std_logic;
        count : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of a3_counter4_sync is
    signal q : std_logic_vector(3 downto 0);
    signal qn : std_logic_vector(3 downto 0);
begin

    count <= q;

    adder: entity work.a2_adder4
        port map(
            a => q,
            b => (others => '0'),
            c_in => '1',
            s => qn,
            c_out => open
        );

    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                q <= (others => '0');
            else
                q <= qn;
            end if;
        end if;
    end process;

end architecture;