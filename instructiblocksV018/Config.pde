//config file containing all global variables and initialisation of objects
//void init() needs to be called in setup
//void display() needs to be called in draw

//libraries
import processing.serial.*;
//import processing.io.*;

// serial data handling
/*
GPIO pins for ID-12LA RFID Reader
 RFID ->  GPIO FUNC (PHYSICAL PIN No.)
 VCC  ->  3.3v    (1)
 GND  ->  GND     (6)
 D0   ->  GPIO 15 (10) N.B. GPIO UART serial must be enabled.
 TIR  ->  GPIO 18 (12)
 */
//Serial GPIO_serial;
Serial USB_serial;
serialHandler serialHandler;

// tag info data
brick[] bricks;
Table csv_table;

//bang button objects
bang bangBack, bangNext;

//log file
logFile logFile;

//colours
color black  = color(0);               //black
color grey = color(180);
color white  = color(255);   //white
color t  = color(255, 0);    //transparent
color y1 = color(253, 230, 0);     //lightest yellow
color y2 = color(250, 217, 1);
color y3 = color(231, 193, 31);
color y4 = color(209, 169, 42);    //darkest yellow
color g1 = color(200, 220, 94);    //lightest green
color g2 = color(182, 199, 59);
color g3 = color(156, 178, 58);
color g4 = color(131, 157, 60);    //darkest green
color b1 = color(123, 203, 190);   //lightest blue
color b2 = color(66, 181, 192);
color b3 = color(5, 152, 183);
color b4 = color(3, 126, 162);     //darkest blue
color p1 = color(240, 90, 115);    //lightest pink
color p2 = color(216, 26, 92);
color p3 = color(159, 32, 99);
color p4 = color(112, 42, 130);    //darkest pink
float opacity = 255; // used for fading out bricks

//fonts
PFont font10, font20, font30, font40, font50, font70, font90, font110;

//logo images
PImage logos;

PImage intro;
PImage instructions;
PImage instructions2;

PImage model1;
PImage model2;
PImage model3;

// Brick image to display
PImage display_brick;
PImage yellow8x2;
PImage red4x2;
PImage orange4x2;
PImage blue3x2;
PImage white2x2;
PImage green2x2;
PImage null0x0;

//keeps track of the current page to display based on incremeting a counter using the back and next buttons
int pageSelected;
int final_page = 4;
int page_count=1;

//tallies participant numbers and rule set used
int participant = 1;
String participant_string;
int model;
int rule_set;
IntList rule_order;

//initialise variables during setup
void init() {

  //fonts
  font10 = createFont("Avenir.ttc", 10, true);
  font20 = createFont("Avenir.ttc", 20, true);
  font30 = createFont("Avenir.ttc", 30, true);
  font40 = createFont("Avenir.ttc", 40, true);
  font50 = createFont("Avenir.ttc", 50, true);
  font70 = createFont("Avenir.ttc", 70, true);
  font90 = createFont("Avenir.ttc", 90, true);
  font110 = createFont("Avenir.ttc", 110, true);

  //images
  logos = loadImage("logos.png");
  yellow8x2 = loadImage("data/bricks_yellow8x2.png");
  red4x2 = loadImage("data/bricks_red4x2.png");
  orange4x2 = loadImage("data/bricks_orange4x2.png");
  blue3x2 = loadImage("data/bricks_blue3x2.png");
  white2x2 = loadImage("data/bricks_white2x2.png");
  green2x2 = loadImage("data/bricks_green2x2.png");
  null0x0 = loadImage("data/bricks_null.png");
  intro = loadImage("data/bricks_introduction.png");
  instructions = loadImage("data/bricks_instructions.png");
  instructions2 = loadImage("data/bricks_instructions2.png");
  
  model1 = loadImage("data/bricks_model1.png");
  model2 = loadImage("data/bricks_model2.png");
  model3 = loadImage("data/bricks_model3.png");


  //bang buttons

  //bangExample = new bang(false, 100, 128, 100, 100, 30);
  bangBack = new bang(false, 30, 30, 360, 240, 70);
  bangNext = new bang(false, width-390, 30, 360, 240, 70);  


  //Serial data
  //printArray(Serial.list());
  USB_serial = new Serial(this, Serial.list()[0], 9600);
  serialHandler = new serialHandler();
  serialHandler.setup(USB_serial, false);

  // load csv data
  loadDatabase("database2.csv");
  display_brick = loadImage("bricks_null.png");

  logFile = new logFile();
  logFile.init();

  participant_string = "P"+ nf(participant, 3);
  rule_set = floor(random(1, 4));
  rule_order = new IntList();
  rule_order.append(1);
  rule_order.append(2);
  rule_order.append(3);
  rule_order.shuffle();

  model = 1;
}