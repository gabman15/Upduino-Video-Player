library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port(
        clk : in std_logic;
        dout : out std_logic_vector(7 downto 0);
        sda : inout STD_LOGIC;
        scl : inout STD_LOGIC
    );
end top;

architecture synth of top is
    component I2CMaster is
        generic (
            input_clk_freq : INTEGER := 12_000_000;
            bus_clk_freq   : INTEGER := 400000;
            addr_mode      : INTEGER := 17
        );
        port (
            parallel_in : in  STD_LOGIC_VECTOR(7 downto 0);
            address : in  STD_LOGIC_VECTOR(addr_mode - 1 downto 0);
            enable : in  STD_LOGIC;
            rw : in  STD_LOGIC;
            reset : in STD_LOGIC;
            clk : in STD_LOGIC;
            parallel_out : out STD_LOGIC_VECTOR(7 downto 0);
            sda : inout  STD_LOGIC;
            scl : inout  STD_LOGIC;
            read_no_ack : in STD_LOGIC
        );
    end component;

    signal data_in : STD_LOGIC_VECTOR(7 downto 0) := 8b"0";
    signal reset : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '1';
    signal addr : STD_LOGIC_VECTOR(16 downto 0) := 17x"1b0";
    signal read_no_ack : STD_LOGIC := '1';
    signal rw : STD_LOGIC := '1';

begin

    myI2C : I2CMaster port map(
        parallel_in => data_in,
        address => addr,
        enable => enable,
        rw => rw,
        reset => reset,
        clk => clk,
        parallel_out => dout,
        sda => sda,
        scl => scl,
        read_no_ack => read_no_ack
    );
    
    
end;
