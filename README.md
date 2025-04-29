# VHDL Servo Controller Project

## Project Authors
- Petr Křupka
- Mikuláš Kolář  
- Samuel Jánošík
- Šimon Kiripolský

## Assignment
- Develop a **servo motor controller** using **VHDL** on the **Nexys A7 FPGA board**
- Generate **PWM signals** to control **servo motor angles**
- Connect multiple servos using the **Pmod connectors**
- Use **buttons or switches** to adjust servo positions
- Provide **visual feedback** with LEDs to show status or position

## Theoretical Background

### Servo Motor
A servo motor is a rotary actuator that allows for precise control of angular position through pulse-width modulated (PWM) signals. It combines a DC motor, gear train, position sensor, and control circuitry in a closed-loop system.

### Pulse Width Modulation (PWM)
PWM is a modulation technique where the width of electrical pulses is varied while keeping the frequency constant, controlling power delivery to devices.

## Implementation
**VHDL Modules:**
1. `servo_controller.vhd` - Handles button inputs and pulse width adjustment
2. `pwm_generator.vhd` - Generates 50Hz PWM signal
3. `top_level.vhd` - Main entity connecting components
4. `nexys-a7-50t.xdc` - constraints file

**Key Features:**
- Button control (BTNL/BTNR)
- LED status indicators
- 100μs step adjustment
- 1000-2000μs pulse width range

## Code Review – `servo_controller.vhd`

This is part of our simple servo motor controller designed for FPGA implementation.

<img src="https://github.com/user-attachments/assets/b4e87b76-5fb4-4961-b759-d6465eeba1e5" alt="servo_controller" width="550" height="750" />


- **Inputs**:
  - `CLK`: Clock signal used to synchronize logic.
  - `BTNL`, `BTNR`: Buttons to decrease/increase the PWM width.
  
- **Outputs**:
  - `ENABLE`: Activates the servo when a button is pressed.
  - `LED`: Displays a visual pattern depending on the button pressed.
  - `PWM_WIDTH`: Integer output controlling the servo pulse width (range 1000–2000 µs).

### How it works:
- **Pulse width control**:
  - If `BTNL` is pressed, the pulse width decreases by 100 (down to a minimum of 1000).
  - If `BTNR` is pressed, the pulse width increases by 100 (up to a maximum of 2000).

- **LED feedback**:
  - Pressing `BTNL` shows `"11110000"` on LEDs.
  - Pressing `BTNR` shows `"00001111"`.
  - No buttons pressed = all LEDs off.

- **PWM width output** (`PWM_WIDTH`) reflects the current `pulse_width`, which would be used in a separate PWM generator to control the servo motor.

The design was intended to vary the servo's position based on button input but in practice the servo responds the same way to both `BTNL` and `BTNR`. 

## Photo Documentation

![image](https://github.com/user-attachments/assets/e4fa4023-e745-453e-9cc3-4c6979350f24)
- FPGA board - Nexys A7-50t


[![image](https://github.com/user-attachments/assets/472040ae-10aa-4354-842a-43292110a0a9)](https://www.codeproject.com/Articles/513169/Servomotor-Control-with-PWM-and-VHDL)
- Servo signal simulations


![image](https://github.com/user-attachments/assets/2afccf1b-1572-4b56-bb81-2f4438c66164)
- LED feedback and overall functionality

## Conclusion
Although our original goal was to control multiple servomotors using PWM signals, we encountered issues that prevented full implementation. The servo motor responded the same way to both control buttons, suggesting that the PWM signal may not have matched the servo's requirements — potentially due to timing inaccuracies or insufficient resolution.

We attempted to identify the cause, but time constraints limited our ability to fully diagnose or resolve the issue. Despite this, we successfully implemented control for a single motor and achieved functional LED feedback, with the motor able to rotate in one direction.

Throughout the project, we gained valuable technical experience, improved our problem-solving abilities, and learned how to collaborate effectively under pressure. This process also deepened our understanding of VHDL programming and gave us practical experience working on a hardware-based control system.

Overall, the project provided meaningful insights and skills that will benefit us in future engineering challenges.

## References
1. https://www.codeproject.com/Articles/513169/Servomotor-Control-with-PWM-and-VHDL
2. Nexys A7 Reference Manual 
3. IEEE Standard VHDL Language Reference Manual
4. "FPGA Prototyping by VHDL Examples" 
5. SG90 Servo Motor Datasheet
