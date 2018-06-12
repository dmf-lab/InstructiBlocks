//containts all the static elements for each page

void display() {

  //Scanning Page
  if (pageSelected == 2) {
    rule_set = 3;
    model = 4;
    //setup the style and display of the page
    titleBlock();

    fill(white);
    textFont(font70);
    textAlign(CENTER, CENTER);
    text("build a spacehip by following the rules...", width/2, 250);
    noFill();
    
    imageMode(CENTER);
    image(model3, width/2, 1575);

    brickScan();

  }
}

  

void titleBlock() {
  //fill(b3);
  //rect(0, 0, width, height);

  //title block
  fill(b4);
  noStroke();
  rectMode(CENTER);
  rect(width/2, height/2, width, 400);
  noFill();

  //display project logos
  //imageMode(CENTER);
  //image(logos, width/2, height/2, 1870, 1052);


}


void brickScan() {

  serialHandler.run();

  if (serialHandler.timer()) { //&& serialHandler.strComp()
    opacity = opacity - 15;
    if (opacity <0) {
      opacity = 0;
      serialHandler.dataReset();
    }
  } else {
    opacity = 255;
  }

  rectMode(CENTER);
  noStroke();
  fill(b4);
  rect(width/2, height/2, width, height/2);

  fill(white, opacity);
  textFont(font90);
  textAlign(LEFT, CENTER);

  text(serialHandler.display_strings[1], width/2-20, height/2-110);
  textFont(font70);
  textAlign(CENTER, CENTER);
  text(serialHandler.display_strings[2], width/2, height/2 + 125);
  text(serialHandler.display_strings[3], width/2, height/2 + 250);

  if (serialHandler.display_strings[0].equals("null")) {
    fill(white);
    textAlign(CENTER, CENTER);
    textFont(font110);

    text("scan a brick...", width/2, height/2);
    
  }

  imageMode(CORNER);
  tint(255, opacity);
  image(display_brick, width/2-100-display_brick.width, height/2 - display_brick.height);
  noTint();
}