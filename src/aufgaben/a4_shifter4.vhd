library ieee;
use ieee.std_logic_1164.all;

entity a4_shifter4 is
    port (
        x : in std_logic_vector(3 downto 0);
        c : in std_logic_vector(1 downto 0);
        y : out std_logic_vector(3 downto 0)
    );
end entity;

architecture a of a4_shifter4 is
begin

    y <= x when c(1) = c(0) -- c = 00, 11
        else x(0) & x(3 downto 1) when c(1) = '1' -- c = 10
        else x(2 downto 0) & x(3); -- c = 01

end architecture;

architecture b of a4_shifter4 is
begin

    process(x, c)
    begin
        if c(1) = c(0) then -- c = 00, 11
            y <= x;
        elsif c(1) = '1' then -- c = 10
            y <= x(0) & x(3 downto 1);
        else -- c = 01
            y <= x(2 downto 0) & x(3);
        end if;
    end process;

end architecture;

architecture c of a4_shifter4 is
begin

    with c select y <=
        x(0) & x(3 downto 1) when "10",
        x(2 downto 0) & x(3) when "01",
        x when others;


end architecture;

architecture d of a4_shifter4 is
begin

    process(x, c)
    begin
        case c is
            when "10" => y <= x(0) & x(3 downto 1);
            when "01" => y <= x(2 downto 0) & x(3);
            when others => y <= x;
        end case;
    end process;

end architecture;