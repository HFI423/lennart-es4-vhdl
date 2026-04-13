library ieee;
use ieee.std_logic_1164.all;

entity a5_counter2_tb is

    -- Constants
    constant clk_period : time := 20 ns;

    -- Inputs
    signal clk : std_logic := '0';
    signal RESn : std_logic := '1';
    signal UD : std_logic;

    -- Outputs
    signal count : std_logic_vector(1 downto 0);

end entity;

architecture rtl of a5_counter2_tb is
begin

    counter: entity work.a5_counter2
        port map (
            clk => clk,
            RESn => RESn,
            UD => UD,
            count => count
        );

    clk_process: process
    begin
        wait for clk_period/2;
        clk <= not clk;
    end process;

    process
    begin
        RESn <= '0';
        wait for clk_period;
        RESn <= '1';
        assert count = "00";

        UD <= '1';
        wait for clk_period;
        assert count = "01";
        wait for clk_period;
        assert count = "10";
        wait for clk_period;
        assert count = "11";
        wait for clk_period;
        assert count = "00";

        UD <= '0';
        wait for clk_period;
        assert count = "11";
        wait for clk_period;
        assert count = "10";
        wait for clk_period;
        assert count = "01";
        wait for clk_period;
        assert count = "00";

    end process;

end architecture;