library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch_tb is
end entity;

architecture rtl of stopwatch_tb is

    -- Constants
    constant time_size : natural := 8;
    constant clk_period : time := 5 ns;

    -- Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal b1_switch : std_logic := '0';
    signal b2_rst : std_logic := '0';

    -- Outputs
    signal elapsed : std_logic_vector(time_size-1 downto 0);

begin

    stopwatch: entity work.stopwatch
        generic map (
            time_size => time_size
        )
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

        -- Reset
        rst <= '0';
        wait for clk_period;
        assert elapsed = "00000000";

        -- Idle
        b1_switch <= '0';
        b2_rst <= '0';
        rst <= '1';
        wait for clk_period;
        assert elapsed = "00000000";
        wait for clk_period;
        assert elapsed = "00000000";
        wait for clk_period;
        assert elapsed = "00000000";

        -- Start
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000000";
        wait for clk_period;
        assert elapsed = "00000001";
        wait for clk_period;
        assert elapsed = "00000010";
        wait for clk_period;
        assert elapsed = "00000011";
        wait for clk_period;
        b1_switch <= '0';
        assert elapsed = "00000100";
        wait for clk_period;
        assert elapsed = "00000101";
        wait for clk_period;
        assert elapsed = "00000110";

        -- Pause
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000111";
        wait for clk_period;
        assert elapsed = "00000111";
        wait for clk_period;
        assert elapsed = "00000111";
        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00000111";
        wait for clk_period;
        assert elapsed = "00000111";

        -- Continue
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000111";
        wait for clk_period;
        assert elapsed = "00001000";
        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00001001";
        wait for clk_period;
        assert elapsed = "00001010";
        wait for clk_period;
        assert elapsed = "00001011";
        wait for clk_period;
        assert elapsed = "00001100";
        wait for clk_period;
        assert elapsed = "00001101";
        wait for clk_period;
        assert elapsed = "00001110";
        wait for clk_period;
        assert elapsed = "00001111";

        -- Pause
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00010000";
        wait for clk_period;
        assert elapsed = "00010000";
        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00010000";

        -- Continue
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00010000";
        wait for clk_period;
        assert elapsed = "00010001";
        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00010010";

        -- Stop
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00010011";
        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00010011";

        -- Reset
        b2_rst <= '1';
        wait for clk_period;
        assert elapsed = "00010011";
        b2_rst <= '0';
        wait for clk_period;
        assert elapsed = "00000000";
        wait for clk_period;
        assert elapsed = "00000000";

        -- Quick Run
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000000";
        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00000001";
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000010";
        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00000010";

        -- Count to Overflow
        b1_switch <= '1';
        wait for clk_period;
        assert elapsed = "00000010";
        b1_switch <= '0';
        wait for clk_period;
        assert elapsed = "00000011";
        wait for clk_period;
        assert elapsed = "00000100";

        wait until elapsed = "11111111";
        wait until clk = '0';
        wait for clk_period;
        assert elapsed = "00000000";
        wait for clk_period;
        assert elapsed = "00000001";
        wait for clk_period;
        assert elapsed = "00000010";
        
        report "Done";

        wait;

    end process;

end architecture;