library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sw_ctrl_tb is
end entity;

architecture rtl of sw_ctrl_tb is

    -- Constants
    constant clk_period : time := 5 ns;

    -- Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal b1_switch : std_logic := '0';
    signal b2_rst : std_logic := '0';

    -- Outputs
    signal sw_run : std_logic;
    signal sw_rst : std_logic;

begin

    sw_ctrl: entity work.sw_ctrl
        port map(
            clk => clk,
            rst => rst,
            b1_switch => b1_switch,
            b2_rst => b2_rst,
            sw_run => sw_run,
            sw_rst => sw_rst
        );

    clk_process: process
    begin
        wait for clk_period/2;
        clk <= not clk;
    end process;

    process
    begin

        -- System-Reset -> Zero
        b1_switch <= '0';
        b2_rst <= '0';
        rst <= '0';
        wait for clk_period;
        assert sw_rst = '0';
        assert sw_rst = '0';

        -- Zero
        rst <= '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        b2_rst <= '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        b2_rst <= '0';
        
        -- Zero -> Start
        b1_switch <= '1';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';

        -- Start
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        b2_rst <= '1';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        b1_switch <= '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        b2_rst <= '0';
        b1_switch <= '1';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';

        -- Start -> Running
        b1_switch <= '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';

        -- Running
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        b2_rst <= '1';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        b2_rst <= '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';

        -- Running -> Stop
        b1_switch <= '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';

        -- Stop
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        b2_rst <= '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        b1_switch <= '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        b2_rst <= '0';
        b1_switch <= '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        
        -- Stop -> Stopped
        b1_switch <= '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';

        -- Stopped
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';

        -- Stopped -> Start
        b1_switch <= '1';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        
        -- Start -> Running -> Stop -> Stopped
        b1_switch <= '0';
        wait for clk_period;
        assert sw_run = '1';
        assert sw_rst = '0';
        b1_switch <= '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        b1_switch <= '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';

        -- Stopped -> Reset
        b2_rst <= '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '1';

        -- Reset
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '1';
        b1_switch <= '1';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '1';
        b2_rst <= '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '1';

        -- Reset -> Zero
        b1_switch <= '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';
        wait for clk_period;
        assert sw_run = '0';
        assert sw_rst = '0';

        report "Done";

        wait;

    end process;

end architecture;