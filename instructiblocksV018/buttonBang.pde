//a bang with a built in timer to turn it off after a set period
//set circula_button to true for a circular button, default is a rectangle

//data
class bang {
  //display - the style of the bang button
  color color_on;
  color color_off;
  color color_stroke;
  color color_text;
  float outline_stroke_weight;
  boolean circula_button;

  //position and shape
  float xPos;
  float yPos;
  float button_width;
  float button_height;
  float button_corner_radius;

  //label text and position
  String label;
  float label_xPos;
  float label_yPos;
  float font_label_size;

  //defaults
  boolean button_state;
  float button_timer;

  //class variables - these do not need to be set when initialising the object
  boolean over_button;
  int button_switched_off;
  int button_switched_on;
  float button_start_time;
  PFont font_label;
  PFont font_state_label;
  float button_circ_xPos;
  float button_circ_yPos;

  //constructor
  bang(
    boolean circula_button_temp

    , float xPos_temp
    , float yPos_temp
    , float button_width_temp
    , float button_height_temp
    
    , float font_label_size_temp
    )
  {
    circula_button = circula_button_temp;

    xPos = xPos_temp;
    yPos = yPos_temp;
    button_width = button_width_temp;
    button_height = button_height_temp;

    font_label_size = font_label_size_temp;
    font_label = createFont("Avenir.ttc", font_label_size, true);
    font_state_label = createFont("Avenir.ttc", button_width*0.5, true);

    //initialise bang class variables
    button_state = false;
    button_start_time = 0;
    button_circ_xPos = xPos+button_width*0.5;
    button_circ_yPos = yPos+button_width*0.5;
  }

  //test to see if the cursor is over the bang
  void rollover() {
    if (circula_button == false) {    
      //mouse and cursor with click
      if (controlModality == 0) {
        if (mouseX > xPos && mouseX < xPos+button_width &&
          mouseY > yPos && mouseY < yPos+button_height && mousePressed) {
          over_button = true;
        } else {
          over_button = false;
        }
        //windows touch screen with single touch point
      } else if (controlModality ==1) {
        if (mouseX > xPos && mouseX < xPos+button_width &&
          mouseY > yPos && mouseY < yPos+button_height && mouseMoved) {
          over_button = true;
        } else {
          over_button = false;
        }
        //linux touch screen with multilpe touch point e.g. with raspberry pi
      }
    }

    //over_button is caluated using euclidean distance and bang radius. note that square root operations are CPU intensive so left as a square for xyGap
    if (circula_button == true) {

      //mouse and cursor with click
      if (controlModality == 0) {
        float distance = dist(mouseX, mouseY, button_circ_xPos, button_circ_yPos);
        if (distance<(button_width*0.375) && mousePressed) {
          over_button = true;
        } else {
          over_button = false;
        }
        //windows touch screen with single touch point
      } else if (controlModality ==1) {
        float distance = dist(mouseX, mouseY, button_circ_xPos, button_circ_yPos);
        if (distance<(button_width*0.375) && mouseMoved) {
          over_button = true;
        } else {
          over_button = false;
        }
      }
    }
  }

  //sets up the appearance of the bang
  void display(color color_on, color color_off, color color_stroke, float outline_stroke_weight, float button_corner_radius) {
    //rectangular bang button
    if (circula_button == false) {
      if (button_state== false) {
        fill(color_off);
      } else if (button_state == true) {
        fill(color_on);
      }
      stroke(color_stroke);
      strokeWeight(outline_stroke_weight);
      rectMode(CORNER);
      rect(xPos, yPos, button_width, button_height, button_corner_radius);
      noFill();
      noStroke();
    }

    //circular bang button
    else if (circula_button == true) {
      ellipseMode(CENTER);
      stroke(color_off);
      fill(color_off);
      ellipse(button_circ_xPos, button_circ_yPos, button_width, button_height);
      noFill();
      noStroke();
      if (button_state== false) {
        fill(color_off);
      } else if (button_state == true) {
        fill(color_on);
      }
      ellipseMode(CENTER);
      stroke(color_stroke);
      strokeWeight(outline_stroke_weight);
      ellipse(button_circ_xPos, button_circ_yPos, button_width*0.75, button_width*0.75);
      noFill();
      noStroke();
    }
  }

  //add a bang label describing what it does when activated, label_xPos and label_yPos are zeroed on the top left corner of the button
  void label(color color_text, String label, float label_xPos, float label_yPos) {
    fill(color_text);
    textAlign(CENTER);
    textFont(font_label);
    text(label, xPos+label_xPos, yPos+label_yPos);
    noFill();
  }

  //records the time at which the bang was first pressed
  void timer(float button_timer_temp) {
    button_timer = button_timer_temp;
    if (button_state == false && over_button == true) {
      button_start_time = millis();
    } else if (button_state == false && over_button == true) {
      button_start_time = millis();
    }
  }

  //check to see if the mouse position has moved, if it has, enable the bang switch function
  //bang switched is true only when the button switches back to false - use to program functionality to the turning off of a bang
  public void state() {
    button_switched_off = 0;
    button_switched_on = 0;
    if (over_button == true && button_state == false && mouseMoved == true) {
      button_state = true;
      button_switched_on++;
    } else if (over_button == true && button_state == false) {
      button_state = true;
      button_switched_on++;
    } else if (button_state == true && millis()>button_start_time+(button_timer*1000)) {
      button_state = false;
      button_start_time = millis();  
      button_switched_off++;
    }
  }
}