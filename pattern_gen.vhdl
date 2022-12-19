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
    --signal frame_data : std_logic_vector(767 downto 0);
    -- data row that pixel is in
    signal real_row : unsigned(9 downto 0);
    signal real_col : unsigned(9 downto 0);
    
    signal data_row : unsigned(8 downto 0);
    -- data column that pixel is in
    signal data_col : unsigned(8 downto 0);
    -- value of pixel in data array at that location
    signal pixel : std_logic;
    signal temp : std_logic_vector(5 downto 0);
begin
    real_col <= col - 144;
    real_row <= row - 35;
    
    --frame_data <= 768x"fff000fffff0007fffe000ff7f7001fffff800fffffc007ffff8007ffff4007ffff800fffff0007fffe000ffffc0007fffe0007fffc0007fff80007fff000017ff80001fffc0041fff80063f7f00041fff80061fff00041ffe00060fff000417";
    
    data_row <= to_unsigned(0,9) when real_row < 20 else
    to_unsigned(1,9) when real_row < 40 else
    to_unsigned(2,9) when real_row < 60 else
    to_unsigned(3,9) when real_row < 80 else
    to_unsigned(4,9) when real_row < 100 else
    to_unsigned(5,9) when real_row < 120 else
    to_unsigned(6,9) when real_row < 140 else
    to_unsigned(7,9) when real_row < 160 else
    to_unsigned(8,9) when real_row < 180 else
    to_unsigned(9,9) when real_row < 200 else
    to_unsigned(10,9) when real_row < 220 else
    to_unsigned(11,9) when real_row < 240 else
    to_unsigned(12,9) when real_row < 260 else
    to_unsigned(13,9) when real_row < 280 else
    to_unsigned(14,9) when real_row < 300 else
    to_unsigned(15,9) when real_row < 320 else
    to_unsigned(16,9) when real_row < 340 else
    to_unsigned(17,9) when real_row < 360 else
    to_unsigned(18,9) when real_row < 380 else
    to_unsigned(19,9) when real_row < 400 else
    to_unsigned(20,9) when real_row < 420 else
    to_unsigned(21,9) when real_row < 440 else
    to_unsigned(22,9) when real_row < 460 else
    to_unsigned(23,9);
    
    data_col <= to_unsigned(0,9) when real_col < 20 else
    to_unsigned(1,9) when real_col < 40 else
    to_unsigned(2,9) when real_col < 60 else
    to_unsigned(3,9) when real_col < 80 else
    to_unsigned(4,9) when real_col < 100 else
    to_unsigned(5,9) when real_col < 120 else
    to_unsigned(6,9) when real_col < 140 else
    to_unsigned(7,9) when real_col < 160 else
    to_unsigned(8,9) when real_col < 180 else
    to_unsigned(9,9) when real_col < 200 else
    to_unsigned(10,9) when real_col < 220 else
    to_unsigned(11,9) when real_col < 240 else
    to_unsigned(12,9) when real_col < 260 else
    to_unsigned(13,9) when real_col < 280 else
    to_unsigned(14,9) when real_col < 300 else
    to_unsigned(15,9) when real_col < 320 else
    to_unsigned(16,9) when real_col < 340 else
    to_unsigned(17,9) when real_col < 360 else
    to_unsigned(18,9) when real_col < 380 else
    to_unsigned(19,9) when real_col < 400 else
    to_unsigned(20,9) when real_col < 420 else
    to_unsigned(21,9) when real_col < 440 else
    to_unsigned(22,9) when real_col < 460 else
    to_unsigned(23,9) when real_col < 480 else
    to_unsigned(24,9) when real_col < 500 else
    to_unsigned(25,9) when real_col < 520 else
    to_unsigned(26,9) when real_col < 540 else
    to_unsigned(27,9) when real_col < 560 else
    to_unsigned(28,9) when real_col < 580 else
    to_unsigned(29,9) when real_col < 600 else
    to_unsigned(30,9) when real_col < 620 else
    to_unsigned(31,9);
    
    pixel <= frame_data(767 - ((to_integer(data_row) * 32) + to_integer(data_col)));
    
    temp <= "111111" when pixel = '1' else "000000";
    RGB <= temp when valid = '1' else "000000";
end;
