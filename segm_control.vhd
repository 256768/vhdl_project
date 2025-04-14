library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity segm_control is
    Port (
        CLK      : in STD_LOGIC; 
        RST      : in STD_LOGIC; 
        EN       : in STD_LOGIC; 

        SEGM1    : in STD_LOGIC_VECTOR (6 downto 0); -- Input segment values CG, CF, CE, CD, CC, CB, CA
        SEGM2    : in STD_LOGIC_VECTOR (6 downto 0);
        SEGM3    : in STD_LOGIC_VECTOR (6 downto 0);
        SEGM4    : in STD_LOGIC_VECTOR (6 downto 0);
        SEGM5    : in STD_LOGIC_VECTOR (6 downto 0);
        SEGM6    : in STD_LOGIC_VECTOR (6 downto 0);
        SEGM7    : in STD_LOGIC_VECTOR (6 downto 0);
        SEGM8    : in STD_LOGIC_VECTOR (6 downto 0);

        CA       : out STD_LOGIC; -- Cathodes
        CB       : out STD_LOGIC;
        CC       : out STD_LOGIC;
        CD       : out STD_LOGIC;
        CE       : out STD_LOGIC;
        CF       : out STD_LOGIC;
        CG       : out STD_LOGIC;
        DP       : out STD_LOGIC; 

        AN       : out STD_LOGIC_VECTOR (7 downto 0) -- Anodes
    );
end segm_control;

architecture Behavioral of segm_control is
    signal sig_an : std_logic_vector (7 downto 0); -- internal anodes signal
    type segm_array is array(0 to 7) of STD_LOGIC_VECTOR(6 downto 0);
    signal segm: segm_array;
begin
    -- Assign segment values to array for easy access
    segm(0) <= SEGM1;
    segm(1) <= SEGM2;
    segm(2) <= SEGM3;
    segm(3) <= SEGM4;
    segm(4) <= SEGM5;
    segm(5) <= SEGM6;
    segm(6) <= SEGM7;
    segm(7) <= SEGM8;

    -- Process for anode control
    process (CLK)
        variable last : STD_LOGIC;
    begin
        if (rising_edge(CLK)) then
            if (RST = '1') then -- on reset
                sig_an <= b"1111_1110"; -- set current displaying anode to the first one
            elsif EN = '1' then -- on enabled
                last := sig_an(7); -- extract MSB, shift the rest and put the bit as LSB (rotating buffer)
                sig_an <= sig_an(6 downto 0) & last;
            end if;
        end if;
    end process;

    -- Assign cathodes based on current anode by comparing sig_an directly
    CA <= segm(0)(6) when sig_an = "11111110" else
          segm(1)(6) when sig_an = "11111101" else
          segm(2)(6) when sig_an = "11111011" else
          segm(3)(6) when sig_an = "11110111" else
          segm(4)(6) when sig_an = "11101111" else
          segm(5)(6) when sig_an = "11011111" else
          segm(6)(6) when sig_an = "10111111" else
          segm(7)(6);

    CB <= segm(0)(5) when sig_an = "11111110" else
          segm(1)(5) when sig_an = "11111101" else
          segm(2)(5) when sig_an = "11111011" else
          segm(3)(5) when sig_an = "11110111" else
          segm(4)(5) when sig_an = "11101111" else
          segm(5)(5) when sig_an = "11011111" else
          segm(6)(5) when sig_an = "10111111" else
          segm(7)(5);

    CC <= segm(0)(4) when sig_an = "11111110" else
          segm(1)(4) when sig_an = "11111101" else
          segm(2)(4) when sig_an = "11111011" else
          segm(3)(4) when sig_an = "11110111" else
          segm(4)(4) when sig_an = "11101111" else
          segm(5)(4) when sig_an = "11011111" else
          segm(6)(4) when sig_an = "10111111" else
          segm(7)(4);

    CD <= segm(0)(3) when sig_an = "11111110" else
          segm(1)(3) when sig_an = "11111101" else
          segm(2)(3) when sig_an = "11111011" else
          segm(3)(3) when sig_an = "11110111" else
          segm(4)(3) when sig_an = "11101111" else
          segm(5)(3) when sig_an = "11011111" else
          segm(6)(3) when sig_an = "10111111" else
          segm(7)(3);

    CE <= segm(0)(2) when sig_an = "11111110" else
          segm(1)(2) when sig_an = "11111101" else
          segm(2)(2) when sig_an = "11111011" else
          segm(3)(2) when sig_an = "11110111" else
          segm(4)(2) when sig_an = "11101111" else
          segm(5)(2) when sig_an = "11011111" else
          segm(6)(2) when sig_an = "10111111" else
          segm(7)(2);

    CF <= segm(0)(1) when sig_an = "11111110" else
          segm(1)(1) when sig_an = "11111101" else
          segm(2)(1) when sig_an = "11111011" else
          segm(3)(1) when sig_an = "11110111" else
          segm(4)(1) when sig_an = "11101111" else
          segm(5)(1) when sig_an = "11011111" else
          segm(6)(1) when sig_an = "10111111" else
          segm(7)(1);

    CG <= segm(0)(0) when sig_an = "11111110" else
          segm(1)(0) when sig_an = "11111101" else
          segm(2)(0) when sig_an = "11111011" else
          segm(3)(0) when sig_an = "11110111" else
          segm(4)(0) when sig_an = "11101111" else
          segm(5)(0) when sig_an = "11011111" else
          segm(6)(0) when sig_an = "10111111" else
          segm(7)(0);

    DP <= '1'; -- turn off decimal point
    AN <= sig_an; -- push anode signal to anode
end Behavioral;
