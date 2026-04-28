library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic (
		size : natural := 4
	);
    port (
		clk : in std_logic;
        rst : in std_logic;
    	en : in  std_logic;
        up : in  std_logic;
        count : out  std_logic_vector(size-1 downto 0)
	);
end counter;

architecture rtl of counter is
	signal q : unsigned(size-1 downto 0);
	signal qn : unsigned(size-1 downto 0);
begin

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
	
	qn <= q when en='0'
		else q+1 when up='1'
		else q-1;
	count <= std_logic_vector(q);

end architecture;

