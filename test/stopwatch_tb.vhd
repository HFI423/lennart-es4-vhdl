library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch_tb is
    
    -- Constants
    constant clk_period : time := 20 ns;

    -- Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal b1_switch : std_logic := '0';
    signal b2_rst : std_logic := '0';

    -- Outputs
    signal elapsed : std_logic_vector(7 downto 0);

end entity;

architecture rtl of stopwatch_tb is

begin

    stopwatch_inst: entity work.stopwatch
        port map(
            clk => clk,
            rst => rst,
            b1_switch => b1_switch,
            b2_rst => b2_rst,
            elapsed => elapsed
        );

    clk_process: process
    begin
        wait for clk_period/2;
        clk <= not clk;
    end process;

    process
    begin

        rst <= '0';
        wait for clk_period;
        assert elapsed = "00000000";

        rst <= '1';
        wait for clk_period;
        assert elapsed = "00000000";

        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000000";

        wait for clk_period;
        assert elapsed = "00000001";

        wait for clk_period;
        assert elapsed = "00000010";

        wait for clk_period;
        assert elapsed = "00000011";

        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00000100";

        wait for clk_period;
        assert elapsed = "00000101";

        wait for clk_period;
        assert elapsed = "00000110";

        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000111";

        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00000111";

        wait for clk_period;
        assert elapsed = "00000111";

        wait for clk_period;
        assert elapsed = "00000111";

        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000111";

        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00001000";

        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00001001";

        wait for clk_period;
        assert elapsed = "00001001";

        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00001001";

        b2_rst <= '1';
        wait for clk_period;
        assert elapsed = "00001001";

        b2_rst <= '0';
        wait for clk_period;
        assert elapsed = "00000000";

        wait for clk_period;
        assert elapsed = "00000000";

        wait for clk_period;
        assert elapsed = "00000000";

    end process;

end architecture;