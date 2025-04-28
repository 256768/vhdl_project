# VHDL Servo Controller Project

## Project Authors
- Petr Křupka
- Mikuláš Kolář  
- Samuel Jánošík
- Šimon Kiripolský

## Assignment
Develop a PWM-based servo motor controller using VHDL on FPGA that:
- Generates 50Hz PWM signals (20ms period)
- Adjusts pulse width (1000-2000μs) via buttons
- Provides LED visual feedback
- Controls standard servo motors

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
4. `nexys-a7-50t.xdc`

**Key Features:**
- Button control (BTNL/BTNR)
- LED status indicators
- 100μs step adjustment
- 1000-2000μs pulse width range

## Photo Documentation

![image](https://github.com/user-attachments/assets/e4fa4023-e745-453e-9cc3-4c6979350f24)
- FPGA board - Nexys A7-50t


[![image](https://github.com/user-attachments/assets/472040ae-10aa-4354-842a-43292110a0a9)](https://www.codeproject.com/Articles/513169/Servomotor-Control-with-PWM-and-VHDL)
- Servo signal simulations


![image](https://github.com/user-attachments/assets/2afccf1b-1572-4b56-bb81-2f4438c66164)
- LED feedback and overall functionality

## Conclusion
This project successfully implements:
- Precise servo control via PWM
- Intuitive button interface
- Clear visual feedback

## References
1. Nexys A7 Reference Manual
2. IEEE Standard VHDL Language Reference Manual
3. "FPGA Prototyping by VHDL Examples" 
4. SG90 Servo Motor Datasheet
