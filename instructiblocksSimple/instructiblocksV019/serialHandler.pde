class serialHandler {
  Serial port_name;
  String data_string = "";
  String prev_data = "";
  String[] display_strings = {"", "", "", ""};
  boolean debug;
  int duration;
  int start_time;
  int current_time;
  int time_diff;
  int tagCount = 0;
  int prevTagCount = 0;

  void setup(Serial _port_name, boolean _debug) {
    port_name = _port_name;
    debug = _debug;
    duration = 5000;
  }

  void run() {
    this.data(port_name);
    if (tagPresent()==true) {
      loadBrickImage();
      
    }
  }

  void data(Serial myPort) {
    
    prev_data = data_string;
    if (myPort.available()==1) {
      data_string= "";
      //for (int i=0; i<16; i++) {
      int inByte = myPort.read();
      //println(inByte);
      //if (inByte != 2 && inByte != 13 && inByte != 10 && inByte !=3) {
      data_string = str(char(inByte));
      tagCount++;
      start_time = millis();
    }
    //}
    if (debug) {
      println(data_string);
    }
    display_strings = databaseCheck();
    //println(tagCount + " - " + prevTagCount);
  }


  void dataReset() {
    display_strings[0] = "null";
    display_strings[1] = "";
    display_strings[2] = "";
    display_strings[3] = "";
    loadBrickImage();
  }

  String[] databaseCheck() {
    String [] brick_info = {"", "", "", ""};

    for (int n = 0; n < bricks.length; n++) {
      if (data_string.equals(bricks[n].rfid)) {
        brick_info[0] = bricks[n].type;
        if (model == 1) {
          brick_info[1]  = bricks[n].info;
        } else {
          if (rule_set == 1) {
            brick_info[1]  = bricks[n].name1;
            brick_info[2]  = bricks[n].rule1;
          } else if (rule_set == 2) {
            brick_info[1]  = bricks[n].name2;
            brick_info[2]  = bricks[n].rule2;
          } else if (rule_set == 3) {
            brick_info[1]  = bricks[n].name3;
            brick_info[2]  = bricks[n].rule3;
            brick_info[3]  = bricks[n].rule4;
          }
        }
        break;
      } else {
        brick_info[0] = "null";
        brick_info[1] = "";
        brick_info[2] = "";
        brick_info[3] = "";
      }
    }
    return brick_info;
  }


  boolean timer() {
    current_time = millis();
    //println(current_time + " : "+ start_time);
    time_diff = current_time - start_time;
    //println(time_diff);
    if (time_diff > duration) {
      prevTagCount = tagCount;
      return true;
    } else {
      return false;
    }
  }

  boolean tagPresent() {
    if (prevTagCount < tagCount) {
      return true;
    } else {
      return false;
    }
  }

  void loadBrickImage() {
    //println(display_strings[0]);
    if (display_strings[0].equals("yellow8x2")) {
      display_brick = yellow8x2.get();
    } else if (display_strings[0].equals("red4x2")) {
      display_brick = red4x2.get();
    } else if (display_strings[0].equals("orange4x2")) {
      display_brick = orange4x2.get();
    } else if (display_strings[0].equals("blue3x2")) {
      display_brick = blue3x2.get();
    } else if (display_strings[0].equals("white2x2")) {
      display_brick = white2x2.get();
    } else if (display_strings[0].equals("green2x2")) {
      display_brick = green2x2.get();
    } else {
      display_brick = null0x0.get();
    }
  }
}