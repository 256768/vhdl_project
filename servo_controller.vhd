library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity servo_controller is
    Port (
        CLK : in  STD_LOGIC;
        BTNL : in  STD_LOGIC;
        BTNR : in  STD_LOGIC;
        ENABLE : out  STD_LOGIC;
        LED : out  STD_LOGIC_VECTOR(7 downto 0);
        PWM_WIDTH : out  integer range 1000 to 2000
    );
end servo_controller;

architecture Behavioral of servo_controller is
    signal pulse_width : integer := 1500; 
    signal led_state : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
begin
    process(BTNL, BTNR)
    begin
        if BTNL = '1' then
            if pulse_width > 1000 then
                pulse_width <= pulse_width - 100;
            end if;
        elsif BTNR = '1' then
            if pulse_width < 2000 then
                pulse_width <= pulse_width + 100;
            end if;
        end if;
    end process;

    process(CLK)
    begin
        if rising_edge(CLK) then
            if BTNL = '1' or BTNR = '1' then
                ENABLE <= '1';
                led_state <= "11111111";
            else
                ENABLE <= '0';
                led_state <= "00000000";
            end if;
        end if;
    end process;

    PWM_WIDTH <= pulse_width;
    LED <= led_state;
end Behavioral;
