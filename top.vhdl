library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
        clk : std_logic;
    );
end top;

architecture synth of top is
    process(clk) is
    begin
        if rising_edge(clk) then
            case addr is
                when "00" => data <= 16x"0000"; -- Assumes 2-bit address and 16-bit data
                when "01" => data <= 16x"1234"; -- You can make these any size you want
                when "10" => data <= 16x"5678";
                when "11" => data <= 16x"9ABC";
                when others => data <= 16x"0000"; -- Don't forget the "others" case!
            end case;
        end if;
    end process;
end;
