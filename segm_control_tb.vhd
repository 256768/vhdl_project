-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 09 Apr 2025 15:04:19 GMT
-- Request id : cfwk-fed377c2-67f68c73beee2

library ieee;
use ieee.std_logic_1164.all;

entity tb_segm_control is
end tb_segm_control;

architecture tb of tb_segm_control is

    component segm_control
        port (CLK   : in std_logic;
              RST   : in std_logic;
              EN    : in std_logic;
              SEGM1 : in std_logic_vector (6 downto 0);
              SEGM2 : in std_logic_vector (6 downto 0);
              SEGM3 : in std_logic_vector (6 downto 0);
              SEGM4 : in std_logic_vector (6 downto 0);
              SEGM5 : in std_logic_vector (6 downto 0);
              SEGM6 : in std_logic_vector (6 downto 0);
              SEGM7 : in std_logic_vector (6 downto 0);
              SEGM8 : in std_logic_vector (6 downto 0);
              CA    : out std_logic;
              CB    : out std_logic;
              CC    : out std_logic;
              CD    : out std_logic;
              CE    : out std_logic;
              CF    : out std_logic;
              CG    : out std_logic;
              DP    : out std_logic;
              AN    : out std_logic_vector (7 downto 0));
    end component;

    signal CLK   : std_logic;
    signal RST   : std_logic;
    signal EN    : std_logic;
    signal SEGM1 : std_logic_vector (6 downto 0);
    signal SEGM2 : std_logic_vector (6 downto 0);
    signal SEGM3 : std_logic_vector (6 downto 0);
    signal SEGM4 : std_logic_vector (6 downto 0);
    signal SEGM5 : std_logic_vector (6 downto 0);
    signal SEGM6 : std_logic_vector (6 downto 0);
    signal SEGM7 : std_logic_vector (6 downto 0);
    signal SEGM8 : std_logic_vector (6 downto 0);
    signal CA    : std_logic;
    signal CB    : std_logic;
    signal CC    : std_logic;
    signal CD    : std_logic;
    signal CE    : std_logic;
    signal CF    : std_logic;
    signal CG    : std_logic;
    signal DP    : std_logic;
    signal AN    : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : segm_control
    port map (CLK   => CLK,
              RST   => RST,
              EN    => EN,
              SEGM1 => SEGM1,
              SEGM2 => SEGM2,
              SEGM3 => SEGM3,
              SEGM4 => SEGM4,
              SEGM5 => SEGM5,
              SEGM6 => SEGM6,
              SEGM7 => SEGM7,
              SEGM8 => SEGM8,
              CA    => CA,
              CB    => CB,
              CC    => CC,
              CD    => CD,
              CE    => CE,
              CF    => CF,
              CG    => CG,
              DP    => DP,
              AN    => AN);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that CLK is really your main clock signal
    CLK <= TbClock;

   stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        SEGM1 <= b"1010101";
        SEGM2 <= b"0101010";
        SEGM3 <= b"1010101";
        SEGM4 <= b"0101010";
        SEGM5 <= b"1010101";
        SEGM6 <= b"0101010";
        SEGM7 <= b"1010101";
        SEGM8 <= b"0101010";
        EN <= '0';

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;
        EN <= '1';
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_segm_control of tb_segm_control is
    for tb
    end for;
end cfg_tb_segm_control;