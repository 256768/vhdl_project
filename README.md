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
- Rotary actuator for precise angular control
- Uses PWM signals for positioning:
  - 1ms pulse = 0° position
  - 1.5ms pulse = 90° position
  - 2ms pulse = 180° position
- Requires 50Hz signal frequency (20ms period)

### Pulse Width Modulation (PWM)
- Modulation technique encoding information in pulse width
- Key parameters:
  - Frequency: Fixed at 50Hz for servos
  - Duty cycle: Determines servo position
  - Resolution: 100μs steps in this implementation

## Implementation
**VHDL Modules:**
1. `servo_controller.vhd` - Handles button inputs and pulse width adjustment
2. `pwm_generator.vhd` - Generates 50Hz PWM signal
3. `top_level.vhd` - Main entity connecting components

**Key Features:**
- Button control (BTNL/BTNR)
- LED status indicators
- 100μs resolution adjustment
- 1000-2000μs pulse width range

## Photo Documentation
*(Actual photos would be inserted here showing:)*
1. FPGA board with servo connection
2. PWM signal measurements
3. Servo at different positions
4. LED feedback patterns

## Conclusion
This project successfully implements:
- Precise servo control via PWM
- Intuitive button interface
- Clear visual feedback
- Modular VHDL architecture

The system demonstrates effective FPGA-based motor control with potential for expansion to multiple servos and advanced control algorithms.

## References
1. Nexys A7 Reference Manual
2. IEEE Standard VHDL Language Reference Manual
3. "FPGA Prototyping by VHDL Examples" 
4. SG90 Servo Motor Datasheet
