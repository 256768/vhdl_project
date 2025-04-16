library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port (
        CLK100MHZ : in  STD_LOGIC;
        BTNL      : in  STD_LOGIC;
        BTNR      : in  STD_LOGIC;
        LED       : out STD_LOGIC_VECTOR(7 downto 0);
        SERVO     : out STD_LOGIC
    );
end top_level;

architecture Behavioral of top_level is
    signal pwm_signal : STD_LOGIC;
    signal enable_signal : STD_LOGIC;
    signal led_signal : STD_LOGIC_VECTOR(7 downto 0);
    signal pwm_width : integer range 1000 to 2000 := 1500;
begin
    pwm_gen : entity work.pwm_generator
        port map (
            CLK => CLK100MHZ,
            ENABLE => enable_signal,
            PWM_WIDTH => pwm_width,
            PWM_OUT => pwm_signal
        );

    servo_ctrl : entity work.servo_controller
        port map (
            CLK => CLK100MHZ,
            BTNL => BTNL,
            BTNR => BTNR,
            ENABLE => enable_signal,
            LED => led_signal,
            PWM_WIDTH => pwm_width
        );

    SERVO <= pwm_signal;
    LED <= led_signal;
end Behavioral;
