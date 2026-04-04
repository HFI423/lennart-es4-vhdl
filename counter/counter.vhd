library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           en : in  STD_LOGIC;
           up : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (7 downto 0));
end counter;

architecture Behavioral of counter is
	signal q : std_logic_vector (7 downto 0);
	signal qn : std_logic_vector (7 downto 0);
begin

	process (clk)
	begin
		if rising_edge(clk) then
			q <= qn;
		end if;
	end process;
	
	qn <= (others => '0') when reset='1'
		else q when en='0'
		else std_logic_vector(unsigned(q) + 1) when up='1'
		else std_logic_vector(unsigned(q) - 1);
	count <= q;

end Behavioral;

