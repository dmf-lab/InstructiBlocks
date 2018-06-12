/*
  ------------------------------------
          InstructiBlocks
  ------------------------------------
    Part of the PhysiCAD Project
         www.physicad.com

  Original code by David Mathias
  23/5/2017
*/

// RFID tag serial data pass through to processing

// ID-12LA Breakout board to Arduino Mega
// Vcc -> 5v
// GND -> GND
// D0  -> RX1
// TIR -> digital pin 3

int pinPresent = 3; // Pin for tag present

const int tagLen = 16;
const int idLen = 13;
const int numTags = 30;

// Empty array to hold a freshly scanned tag
char newTag[idLen];

char knownTags[numTags][idLen] = {"04199691A5BF",  //green
                                  "041996A3EAC2",  //green
                                  "041996421AD3",  //green
                                  "041996977B67",  //green
                                  "041601CEC71A",  //white
                                  "041996A9DBF9",  //white
                                  "041996DE095C",  //white
                                  "041996CDE7A1",  //white
                                  "041996C7D19D",  //white
                                  "041996DB5303",  //white
                                  "04199697435F",  //blue
                                  "04178798F9F5",  //blue
                                  "0419968E4D48",  //blue
                                  "041996BCE7D0",  //blue
                                  "041996481EDD",  //blue
                                  "041996A65D70",  //blue
                                  "041996D26831",  //blue
                                  "0418AC73F231",  //blue
                                  "041996C6E1AC",  //orange
                                  "041996A2BE97",  //orange
                                  "04199692263F",  //orange
                                  "0418AC98DDF5",  //orange
                                  "0419968AECED",  //orange
                                  "041996B7CAF6",  //orange
                                  "041787A09BAF",  //red
                                  "041996A00B20",  //red
                                  "041996A63815",  //red
                                  "041996ADB593",  //red
                                  "0418AC9F1A35",  //yellow
                                  "041996A80E2D"
                                 }; //yellow


bool check = false;
int match;
char sendByte;

void setup() {
  // initialize both serial ports:
  Serial.begin(9600);
  Serial1.begin(9600);

  pinMode(pinPresent, INPUT_PULLUP);
}

void loop() {

  int i = 0;
  int readByte;
  boolean tag = false;
  if (Serial1.available() == tagLen) {
    tag = true;
  }

  if (tag == true) {
    while (Serial1.available()) {
      readByte = Serial1.read();
      if (readByte != 2 && readByte != 13 && readByte != 10 && readByte != 3) {
        newTag[i] = readByte;
        i++;
      }
      // If we see ASCII 3, ETX, the tag is over
      if (readByte == 3) {
        tag = false;
      }

    }
  } else {
    for (int j = 0; j < numTags; j++) {
      check = checkTag(newTag, knownTags[j]);
      if (check) {
        match = j;
        break;
      }
    }
    if (check) {

      if (match < 4) {
        //green
        sendByte = 'g';
      } else if (match >= 4 && match < 10) {
        //white
        sendByte = 'w';
      } else if (match >= 10 && match < 18) {
        //blue
        sendByte = 'b';
      } else if (match >= 18 && match < 23) {
        //orange
        sendByte = 'o';
      } else if (match >= 23 && match < 28) {
        //red
        sendByte = 'r';
      } else if (match >= 28 && match < 30) {
        //yellow
        sendByte = 'y';
      } else {
        sendByte = 'E';
      }
      Serial.write(sendByte);
    }
    for (int c = 0; c < idLen; c++) {
      newTag[c] = 0;
    }
  }

//  int tagPresent = digitalRead(pinPresent);
//  //Serial.write(tagPresent);
//  if (tagPresent == 0) {
//    Serial.write('N');
//  } else {
//    Serial.write(sendByte);
//  }
}

bool checkTag(char nTag[], char oTag[]) {
  for (int i = 0; i < idLen; i++) {
    if (nTag[i] != oTag[i]) {
      return false;
    }
  }
  return true;
}
