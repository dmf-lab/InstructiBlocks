# InstructiBlocks
The Arduino code and processing sketches to run InstructiBlocks

## Hardware

For this kit, I used an Arduino Mega as I needed two serial connections, however it is possible to use an Uno but the code must be changed to use Software Serial

The RFID reader is ID-12LA 125 kHz (https://www.sparkfun.com/products/11827), with compatible glass capsules (https://www.sparkfun.com/products/9416).

Wiring: 
RFID ->  Arduino Mega

Vcc -> 5v

GND -> GND

D0  -> RX1

TIR -> digital pin 3


The tags were just blue-tacked into the LEGO bricks. The bricks must be 2x2s or larger to fit the tags in.

## Setup
### Arduino Code
1. Tag values need to be hardcoded into the arduino file. (Not great, I know, but the more flexible method threw up issues with processing)
2. Upload and you're good to go.
3. Leave the Arduino plugged into the computer's USB port and close any serial monitors.

### Processing
1. The database2.csv file needs to be updated with the relevant RFID tags (and any rules that you might want to change)
2. In Config.pde, line 131 may need to be changed to match your USB port number
3. Click run.
