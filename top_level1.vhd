-------------------------------------------------
--! @brief Top level implementation for binary counter(s) with servo control
--! @version 1.2
--! @copyright (c) 2019-2025 Tomas Fryza, MIT license
--!
--! This VHDL file implements a top-level design with servo control.
--! BTNC is used as reset, BTND controls the servo position.
--! The servo signal is output on PMOD pin JA1 (can be changed as needed).
--!
--! Developed using TerosHDL, Vivado 2023.2, and EDA Playground.
--! Tested on Nexys A7-50T board and xc7a50ticsg324-1L FPGA.
-------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

-------------------------------------------------

entity top_level is
  port (
    CLK100MHZ : in    std_logic;                     --! Main clock
    LED       : out   std_logic_vector(15 downto 0); --! Show 16-bit counter value
    CA        : out   std_logic;                     --! Cathode of segment A
    CB        : out   std_logic;                     --! Cathode of segment B
    CC        : out   std_logic;                     --! Cathode of segment C
    CD        : out   std_logic;                     --! Cathode of segment D
    CE        : out   std_logic;                     --! Cathode of segment E
    CF        : out   std_logic;                     --! Cathode of segment F
    CG        : out   std_logic;                     --! Cathode of segment G
    DP        : out   std_logic;                     --! Decimal point
    AN        : out   std_logic_vector(7 downto 0);  --! Common anodes of all on-board displays
    BTNC      : in    std_logic;                     --! Synchronous reset
    BTND      : in    std_logic;                     --! Servo control button
    JA        : out   std_logic_vector(7 downto 0)   --! PMOD connector (servo on JA1)
  );
end entity top_level;

-------------------------------------------------

architecture behavioral of top_level is

  -- Component declaration for clock enable
  component clock_en is
    generic (
      n_periods : integer
    );
    port (
      clk   : in    std_logic;
      rst   : in    std_logic;
      pulse : out   std_logic
    );
  end component clock_en;

  -- Component declaration for simple counter
  component counter is
    generic (
      n_bits : integer
    );
    port (
      clk   : in    std_logic;
      rst   : in    std_logic;
      en    : in    std_logic;
      count : out   std_logic_vector(n_bits - 1 downto 0)
    );
  end component counter;

  -- Component declaration for bin2seg
  component bin2seg is
    port (
      clear : in    std_logic;
      bin   : in    std_logic_vector(3 downto 0);
      seg   : out   std_logic_vector(6 downto 0)
    );
  end component bin2seg;

  -- Local signals for first counter: 4-bit @ 250 ms
  signal sig_en_250ms   : std_logic;                    --! Clock enable signal for 4-bit counter
  signal sig_count_4bit : std_logic_vector(3 downto 0); --! 4-bit counter value

  -- Local signal for second counter: 16-bit @ 2 ms
  signal sig_en_2ms : std_logic; --! Clock enable signal for 16-bit counter

  -- Servo control signals
  signal sig_servo_pos   : integer range 0 to 2 := 0; --! Servo position (0-2)
  signal sig_servo_pwm   : std_logic;                 --! Servo PWM signal
  signal sig_servo_count : integer range 0 to 1000000 := 0; --! Servo PWM counter

  -- Constants for servo control (20ms period = 2,000,000 cycles at 100MHz)
  constant C_SERVO_PERIOD   : integer := 2_000_000; -- 20ms
  constant C_SERVO_MIN      : integer := 50_000;    -- 1ms pulse (0 degrees)
  constant C_SERVO_MID      : integer := 100_000;   -- 1.5ms pulse (90 degrees)
  constant C_SERVO_MAX      : integer := 150_000;   -- 2ms pulse (180 degrees)

begin

  -- Component instantiation of clock enable for 250 ms
  clk_en0 : component clock_en
    generic map (
      n_periods => 25_000_000
    )
    port map (
      clk   => CLK100MHZ,
      rst   => BTNC,
      pulse => sig_en_250ms
    );

  -- Component instantiation of 4-bit simple counter
  counter0 : component counter
    generic map (
      n_bits => 4
    )
    port map (
      clk   => CLK100MHZ,
      rst   => BTNC,
      en    => sig_en_250ms,
      count => sig_count_4bit
    );

  -- Component instantiation of bin2seg
  display : component bin2seg
    port map (
      clear  => BTNC,
      bin    => sig_count_4bit,
      seg(6) => CA,
      seg(5) => CB,
      seg(4) => CC,
      seg(3) => CD,
      seg(2) => CE,
      seg(1) => CF,
      seg(0) => CG
    );

  -- Turn off decimal point
  DP <= '1';

  -- Set display position
  AN <= b"1111_1110";

  -- Component instantiation of clock enable for 2 ms
  clk_en1 : component clock_en
    generic map (
      n_periods => 200_000
    )
    port map (
      clk   => CLK100MHZ,
      rst   => BTNC,
      pulse => sig_en_2ms
    );

  -- Component instantiation of 16-bit simple counter
  counter1 : component counter
    generic map (
      n_bits => 16
    )
    port map (
      clk   => CLK100MHZ,
      rst   => BTNC,
      en    => sig_en_2ms,
      count => LED
    );

  -- Servo position control with BTND
  p_servo_control : process (CLK100MHZ) is
  begin
    if rising_edge(CLK100MHZ) then
      if BTNC = '1' then
        -- Reset servo position to middle
        sig_servo_pos <= 1;
      elsif BTND'event and BTND = '1' then
        -- Cycle through positions on button press
        if sig_servo_pos = 2 then
          sig_servo_pos <= 0;
        else
          sig_servo_pos <= sig_servo_pos + 1;
        end if;
      end if;
    end if;
  end process p_servo_control;

  -- Servo PWM generation
  p_servo_pwm : process (CLK100MHZ) is
  begin
    if rising_edge(CLK100MHZ) then
      if BTNC = '1' then
        sig_servo_count <= 0;
        sig_servo_pwm <= '0';
      else
        if sig_servo_count < C_SERVO_PERIOD then
          sig_servo_count <= sig_servo_count + 1;
        else
          sig_servo_count <= 0;
        end if;

        -- Generate PWM pulse based on position
        case sig_servo_pos is
          when 0 => -- 0 degrees
            if sig_servo_count < C_SERVO_MIN then
              sig_servo_pwm <= '1';
            else
              sig_servo_pwm <= '0';
            end if;
          when 1 => -- 90 degrees
            if sig_servo_count < C_SERVO_MID then
              sig_servo_pwm <= '1';
            else
              sig_servo_pwm <= '0';
            end if;
          when others => -- 180 degrees
            if sig_servo_count < C_SERVO_MAX then
              sig_servo_pwm <= '1';
            else
              sig_servo_pwm <= '0';
            end if;
        end case;
      end if;
    end if;
  end process p_servo_pwm;

  -- Output servo signal to PMOD JA1 (can be changed to any output)
  JA(0) <= sig_servo_pwm;
  JA(7 downto 1) <= (others => '0'); -- Set other PMOD pins to 0

end architecture behavioral;