library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity vga is
    port (
        clk : in std_logic;
        valid : out std_logic;
        row : out unsigned(9 downto 0);
        col : out unsigned(9 downto 0);
        HSYNC : out std_logic;
        VSYNC : out std_logic
    );
end vga;

architecture synth of vga is
constant col_max : unsigned(9 downto 0) := to_unsigned(800,10);
constant row_max : unsigned(9 downto 0) := to_unsigned(525,10);

begin
    process (clk) is
    begin
        if rising_edge(clk) then
            if (col = col_max - 1) then
                col <= to_unsigned(0,10);
                if (row = row_max - 1) then
                    row <= to_unsigned(0,10);
                else
                    row <= row + 1;
                end if;
            else
                col <= col + 1;    
            end if;
        end if;
    end process;
    valid <= '1' when col > 143 and col < 784 and row > 34 and row < 515 else
             '0';
    HSYNC <= '0' when col < 96 else '1';
    VSYNC <= '0' when row < 2 else '1';
end;
