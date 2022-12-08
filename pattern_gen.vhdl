library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is
    port (
        valid : in std_logic;
        row : in unsigned(9 downto 0);
        col : in unsigned(9 downto 0);
        frame_data : in std_logic_vector(767 downto 0);
        RGB : out std_logic_vector(5 downto 0)
    );
end pattern_gen;

architecture synth of pattern_gen is
    -- data row that pixel is in 
    signal data_row : unsigned(5 downto 0);
    -- data column that pixel is in
    signal data_col : unsigned(5 downto 0);
    -- value of pixel in data array at that location
    signal pixel : std_logic;
    signal temp : std_logic_vector(5 downto 0);
begin
    
    data_row <= to_unsigned(0,6) when (row < 20) else
    to_unsigned(1,6) when row < 40 else
    to_unsigned(2,6) when row < 60 else
    to_unsigned(3,6) when row < 80 else
    to_unsigned(4,6) when row < 100 else
    to_unsigned(5,6) when row < 120 else
    to_unsigned(6,6) when row < 140 else
    to_unsigned(7,6) when row < 160 else
    to_unsigned(8,6) when row < 180 else
    to_unsigned(9,6) when row < 200 else
    to_unsigned(10,6) when row < 220 else
    to_unsigned(11,6) when row < 240 else
    to_unsigned(12,6) when row < 260 else
    to_unsigned(13,6) when row < 280 else
    to_unsigned(14,6) when row < 300 else
    to_unsigned(15,6) when row < 320 else
    to_unsigned(16,6) when row < 340 else
    to_unsigned(17,6) when row < 360 else
    to_unsigned(18,6) when row < 380 else
    to_unsigned(19,6) when row < 400 else
    to_unsigned(20,6) when row < 420 else
    to_unsigned(21,6) when row < 440 else
    to_unsigned(22,6) when row < 460 else
    to_unsigned(23,6);
    
    data_col <= to_unsigned(0,6) when col < 20 else
    to_unsigned(1,6) when col < 40 else
    to_unsigned(2,6) when col < 60 else
    to_unsigned(3,6) when col < 80 else
    to_unsigned(4,6) when col < 100 else
    to_unsigned(5,6) when col < 120 else
    to_unsigned(6,6) when col < 140 else
    to_unsigned(7,6) when col < 160 else
    to_unsigned(8,6) when col < 180 else
    to_unsigned(9,6) when col < 200 else
    to_unsigned(10,6) when col < 220 else
    to_unsigned(11,6) when col < 240 else
    to_unsigned(12,6) when col < 260 else
    to_unsigned(13,6) when col < 280 else
    to_unsigned(14,6) when col < 300 else
    to_unsigned(15,6) when col < 320 else
    to_unsigned(16,6) when col < 340 else
    to_unsigned(17,6) when col < 360 else
    to_unsigned(18,6) when col < 380 else
    to_unsigned(19,6) when col < 400 else
    to_unsigned(20,6) when col < 420 else
    to_unsigned(21,6) when col < 440 else
    to_unsigned(22,6) when col < 460 else
    to_unsigned(23,6) when col < 480 else
    to_unsigned(24,6) when col < 500 else
    to_unsigned(25,6) when col < 520 else
    to_unsigned(26,6) when col < 540 else
    to_unsigned(27,6) when col < 560 else
    to_unsigned(28,6) when col < 580 else
    to_unsigned(29,6) when col < 600 else
    to_unsigned(30,6) when col < 620 else
    to_unsigned(31,6);
    
    pixel <= frame_data(to_integer(to_unsigned(767,6) - ((data_row * to_unsigned(32,6)) + data_col)));
    temp <= "111111" when pixel = '1' else "000000";

    RGB <= temp when valid = '1' else "000000";
end;
