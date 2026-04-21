library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datenwandler is
	port (
		clk : in std_logic;
		ens : in std_logic;
		d : in std_logic;
		q : out std_logic_vector(7 downto 0);
		done : out std_logic
	);
end datenwandler;

architecture Behavioral of datenwandler is
	signal sreg : std_logic_vector(7 downto 0);
	signal sreg_next : std_logic_vector(7 downto 0);
	signal count : unsigned(2 downto 0);
begin

	sreg_next(0) <= d;
	sreg_next(7 downto 1) <= sreg(6 downto 0);
	q <= sreg;	

	process (clk)
	begin
		if rising_edge(clk) then
			if ens = '1' then
				sreg <= sreg_next;
				count <= count + 1;
				if count = "111" then
					done <= '1';
				else
					done <= '0';
				end if;
			else
				count <= (others => '0');
				done <= '0';
			end if;
		end if;
	end process;

end Behavioral;

