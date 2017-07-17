/*
 ----------------------------------------------------------
 -- Maker Faire - InstructiBlocks Design Study --
 ----------------------------------------------------------
 
 Part of the PhysiCAD Project
 www.physicad.com
 
 Original code by Duncan Boa and David Mathias
 20/03/2017
 
 -----------------------------------------------------------
 -- A simple program for people to take photos and record --
 -- their thoughts about LEGO models that they've built   --
 -- as part of the event                                  --
 -----------------------------------------------------------
 
 
 -----------------------------------------------------------
 --                       libraries                       --
 -----------------------------------------------------------
 1. Processing video library           [processing.video.*;]
 2. Raspberry pi video library         [gohai.glvideo.*;]
 3. Linux touch screen library         [gohai.simpletouch.*;]
 -----------------------------------------------------------
 --                          bugs                         --
 -----------------------------------------------------------
 1. bang_switched_off remains active for multiple draw cycles and causes pages to skip, need a check that it increments only once [6/2/17 fixed with int counter so button acts on switched off status]
 */


//indicates if the interface being used has a mouse input or a touch input
// 0 = mouse
// 1 = windows touchScreen
// 2 = linux touchScreen e.g. Raspberry Pi
int controlModality = 1;


void setup() {
  init();
  fullScreen();
  //size(1920, 1080);
  //smooth(2);
  //frameRate(60);
  //argument changes which page to start on, zero is home page
  pageSelected = 0; 

  //indicates if the interface being used has a mouse input or a touch input
  // 0 = mouse
  // 1 = windows touchScreen
  // 2 = linux touchScreen e.g. Raspberry Pi
  if (controlModality != 0) {
    noCursor();
  }
}

void draw() {
  
  if (controlModality == 1) {
    checkMouseMoved();
  }

  display();
  //logFile.recordEntry();
}

void exit() {
  logFile.endLog();
  super.exit();
}