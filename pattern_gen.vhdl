library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is
    port (
        valid : in std_logic;
        row : in unsigned(9 downto 0);
        col : in unsigned(9 downto 0);
        RGB : out std_logic_vector(5 downto 0)
    );
end pattern_gen;

architecture synth of pattern_gen is
    signal temp : std_logic_vector(9 downto 0);
begin

    temp <=
        std_logic_vector(unsigned(std_logic_vector(row) xor std_logic_vector(col))
        mod to_unsigned(9,10));

    
    RGB <= temp(5 downto 0) when valid = '1' else "000000";
end;
