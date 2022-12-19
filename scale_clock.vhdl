library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

entity scale_clock is
  port (
    clk_12Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_outHz   : out std_logic);
end scale_clock;

architecture Behavioral of scale_clock is

  signal prescaler : unsigned(23 downto 0);
  signal clk_outHz_i : std_logic;
begin

  gen_clk : process (clk_12Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_outHz_i   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_12Mhz) then   -- rising clock edge
      if prescaler = X"B71B0" then     -- 1 200 000 in hex
        prescaler   <= (others => '0');
        clk_outHz_i   <= not clk_outHz_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_outHz <= clk_outHz_i;

end Behavioral;
