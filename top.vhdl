library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
        clk_in : in std_logic;
        RGB : out std_logic_vector (5 downto 0); --rgb value still 6 bits
        HSYNC : out std_logic;
        VSYNC : out std_logic;
        PLL_output : out std_logic
    );
end top;

architecture synth of top is
    component pll is
        port (
            clk_in : in std_logic;
            clk_out : out std_logic;
            --clk_locked : out std_logic;
            PLL_output : out std_logic
        );
    end component;
    component vga is
        port (
            clk : in std_logic;
            valid : out std_logic;
            row : out unsigned(9 downto 0);  --changed range of values
            col : out unsigned(9 downto 0);  --changed range of values
            HSYNC : out std_logic;
            VSYNC : out std_logic
        );
    end component;

    component pattern_gen is
        port (
            valid : in std_logic;
            row : in unsigned(9 downto 0);                        --changed range of values
            col : in unsigned(9 downto 0);                        --changed range of values
		frame_data : in std_logic_vector(767 downto 0);         -- sig partner gen 
            RGB : out std_logic_vector(5 downto 0)                  --rgb value still 6 bits
        );
    end component;

    component rom is
        port (
            clk : in std_logic;
            addr : in std_logic_vector(10 downto 0);
            data : out std_logic_vector(767 downto 0)
        );
    end component;

    component scale_clock is
        port (
            clk_12Mhz : in std_logic;
            rst : in std_logic;
            clk_10Hz : out std_logic
        );
    end component;

    signal rst : std_logic := '0';
    signal row : unsigned(9 downto 0);
    signal col : unsigned(9 downto 0);
    signal valid : std_logic;
    signal clk : std_logic;
    signal frame : std_logic_vector(767 downto 0);
    signal addr : std_logic_vector(10 downto 0);
    signal frame_clk : std_logic;
    
begin
    rst <= '0';
    mypll : pll port map (
        clk_in => clk_in,
        clk_out => clk,
        PLL_output => PLL_output
    );
    myvga : vga port map (
        clk => clk,
        valid => valid,
        row => row,
        col => col,
        HSYNC => HSYNC,
        VSYNC => VSYNC
    );
    

    frame_clock_gen : scale_clock port map (
        clk_12Mhz => clk_in,
        rst => rst,
        clk_10Hz => frame_clk
    );

    process (frame_clk) is
    begin
        if rising_edge(frame_clk) then
            addr <= std_logic_vector(unsigned(addr) + 1);
            if addr = 11d"1248" then
                addr <= 11b"0";
            end if;
        end if;
    end process;
    
    myrom : rom port map (
        clk => clk_in,
        addr => addr,
        data => frame
    );

    mypattern_gen : pattern_gen port map (
        valid => valid,
        row => row,
        col => col,
        frame_data => frame,
        RGB => RGB
    );
end;
