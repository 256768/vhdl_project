library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_generator is
    Port (
        CLK : in  STD_LOGIC;
        ENABLE : in  STD_LOGIC;
        PWM_WIDTH : in  integer range 1000 to 2000;
        PWM_OUT : out  STD_LOGIC
    );
end pwm_generator;

architecture Behavioral of pwm_generator is
    signal counter : integer := 0;
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if ENABLE = '1' then
                if counter < PWM_WIDTH then
                    PWM_OUT <= '1';
                    counter <= counter + 1;
                else
                    PWM_OUT <= '0';
                    if counter < 20000 then -- 20ms period for servo
                        counter <= counter + 1;
                    else
                        counter <= 0;
                    end if;
                end if;
            else
                PWM_OUT <= '0';
                counter <= 0;
            end if;
        end if;
    end process;
end Behavioral;
