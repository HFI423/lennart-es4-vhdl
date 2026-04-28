library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sw_ctrl is

    port (
        clk : in std_logic;
        rst : in std_logic;
        b1_switch : in std_logic;
        b2_rst : in std_logic;
        sw_run : out std_logic;
        sw_rst : out std_logic
    );

    type state is (zero, start, running, stop, stopped, reset);

end entity;

architecture rtl of sw_ctrl is
    signal q : state;
    signal qn : state;
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                q <= zero;
            else
                q <= qn;
            end if;
        end if;
    end process;

    -- Überführungsfunktion
    process (q, b1_switch, b2_rst)
    begin
        case q is
            when zero =>
                if b1_switch = '1' then
                    qn <= start;
                else
                    qn <= zero;
                end if;
            when start =>
                if b1_switch = '0' and b2_rst = '0' then
                    qn <= running;
                else
                    qn <= start;
                end if;
            when running =>
                if b1_switch = '1' then
                    qn <= stop;
                else
                    qn <= running;
                end if;
            when stop =>
                if b1_switch = '0' and b2_rst = '0' then
                    qn <= stopped;
                else
                    qn <= stop;
                end if;
            when stopped =>
                if b1_switch = '1' then
                    qn <= start;
                elsif b2_rst = '1' then
                    qn <= reset;
                else
                    qn <= stopped;
                end if;
            when reset =>
                if b1_switch = '0' and b2_rst = '0' then
                    qn <= zero;
                else
                    qn <= reset;
                end if;
            when others => qn <= reset;
        end case;
    end process;

    -- Ausgabefunktion
    with q select sw_run <=
        '1' when start | running,
        '0' when others;
    with q select sw_rst <=
        '1' when reset,
        '0' when others;

end architecture;