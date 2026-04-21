library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch is
    port (
        clk : in std_logic;
        rst : in std_logic;
        b1_switch : in std_logic;
        b2_rst : in std_logic;
        elapsed : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of stopwatch is
    signal sw_run : std_logic;
    signal sw_rst : std_logic;
    signal counter_rst : std_logic;
begin

    ctrl: entity work.sw_ctrl
        port map(
            clk => clk,
            rst => rst,
            b1_switch => b1_switch,
            b2_rst => b2_rst,
            sw_run => sw_run,
            sw_rst => sw_rst
        );

    counter_inst: entity work.counter
        generic map (
            size => elapsed'length
        )
        port map(
            clk => clk,
            rst => counter_rst,
            en => sw_run,
            up => '1',
            count => elapsed
        );

    counter_rst <= sw_rst or not rst;

end architecture;
