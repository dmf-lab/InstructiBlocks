//containts all the static elements for each page

void display() {
  //the title page
  if (pageSelected == 0) {

    //setup the style and display of the page
    titleBlock();

    //title, text set to white
    fill(white);
    textAlign(CENTER, CENTER);
    textFont(font110);
    text("tap next to get started", width/2, height/2-20);
    noFill();


    //load the next buttons
    nextButton();
    if (bangNext.button_switched_off == 1) {
      page_count++;
      //reset model number
      model = 1;
      //randomly pick rule set
      rule_order.shuffle();
      //println("rule set is: " +rule_set);
      pageSelected=5;
    }
  }

  //Practice page
  if (pageSelected == 1) {
    //setup the style and display of the page
    titleBlock();

    fill(white);
    textFont(font70);
    textAlign(CENTER, CENTER);
    text("tap next when you're ready to start the first task", width/2, 135);
    noFill();

    brickScan();

    imageMode(CENTER);
    image(instructions2, width/2, height-734/2);

    //load the back, next and record buttons
    backButton();
    if (bangBack.button_switched_off == 1) {
      page_count--;
      pageSelected=6;
    }

    nextButton();
    if (bangNext.button_switched_off == 1) {
      page_count++;
      model ++;
      pageSelected=2;
    }
  }

  //Scanning Page
  if (pageSelected == 2) {
    rule_set = rule_order.get(model-2);
    //setup the style and display of the page
    titleBlock();

    fill(white);
    textFont(font70);
    textAlign(CENTER, CENTER);
    text("build a spacehip by following the rules...", width/2, 250);
    String task = "task " + str(model-1) + " of 3";
    text(task, width/2, 135);
    noFill();
    
    imageMode(CENTER);
    if (model -1  == 1){
      image(model1, width/2, 1575);
    } else if (model - 1 == 2){
      image(model2, width/2, 1575);
    } else if (model - 1 == 3) {
      image(model3, width/2, 1575 );
    }

    brickScan();

    //load the back, next and record buttons
    backButton();
    if (bangBack.button_switched_off == 1) {
      page_count--;
      if (model == 2) {
        pageSelected = 1;
      } else {
        pageSelected = 3;
      }

      model --;
    }

    nextButton();
    if (bangNext.button_switched_off == 1) {
      page_count++;
      //if (model < 4) {
      pageSelected = 3;
      //} else {
      //pageSelected = 4;
      //}

      model ++;
    }
  }

  //Break Page
  if (pageSelected == 3) {
    //setup the style and display of the page
    titleBlock();
    fill(white);
    textFont(font90);
    textAlign(CENTER, CENTER);
    text("please wait while photos are taken of your model", width/2, height/2);
    noFill();

    //load the back, next and record buttons
    backButton();
    if (bangBack.button_switched_off == 1) {
      page_count--;
      if (model < 2) {
        pageSelected=1;
      } else {
        pageSelected=2;
      }

      model --;
    }

    nextButton();
    if (bangNext.button_switched_off == 1) {
      page_count++;
      pageSelected=7;
    }
  }

  //the credits page
  if (pageSelected == 4) {  
    //setup the style and display of the page

    titleBlock();

    //title, text set to white
    fill(white);
    textAlign(CENTER, CENTER);
    textFont(font110);
    text("thanks for taking part!", width/2, height/2);
    noFill();

    //subtitle, text set to white
    fill(white);
    textAlign(CENTER, CENTER);
    //textFont(font50);
    //text("please dismantle your model for the next person", width/2, height/2 + 160);
    textFont(font70);
    text("to start again, tap next", width/2, 135);
    noFill();

    //display the questionaire buttons
    //ratingQuestions();

    //load the back and next buttons
    nextButton();
    if (bangNext.button_switched_off == 1) {
      page_count = 1;
      //increment participant number
      logFile.recordEntry();
      participant ++;
      pageSelected=0;
    }
  }

  //intro page
  if (pageSelected == 5) {
    //setup the style and display of the page
    titleBlock();
    fill(white);
    textFont(font90);
    textAlign(CENTER, CENTER);
    text("Introduction", width/2, 145);
    noFill();
    imageMode(CENTER);
    image(intro, width/2, 1062);

    //load the back, next and record buttons
    backButton();
    if (bangBack.button_switched_off == 1) {
      page_count--;
      pageSelected=0;
    }

    nextButton();
    if (bangNext.button_switched_off == 1) {
      page_count++;
      pageSelected=6;
    }
  }

  //instructions page
  if (pageSelected == 6) {
    //setup the style and display of the page
    titleBlock();
    fill(white);
    textFont(font90);
    textAlign(CENTER, CENTER);
    text("Building Conventions", width/2, 145);
    noFill();
    imageMode(CENTER);
    image(instructions, width/2, 1062);

    //load the back, next and record buttons
    backButton();
    if (bangBack.button_switched_off == 1) {
      page_count--;
      pageSelected=5;
    }

    nextButton();
    if (bangNext.button_switched_off == 1) {
      page_count++;
      pageSelected=1;
    }
  }

  //2nd break page
  if (pageSelected == 7) {
    //setup the style and display of the page
    titleBlock();
    fill(white);
    textFont(font90);
    textAlign(CENTER, CENTER);
    text("please dismantle your model", width/2, height/2);
    fill(white);
    textFont(font70);
    textAlign(CENTER, CENTER);
    if (model ==5 ) {
      text("tap next to finish", width/2, 135);
    } else {
      text("tap next when you're ready to start the next task", width/2, 135);
    }
    noFill();

    //load the back, next and record buttons
    backButton();
    if (bangBack.button_switched_off == 1) {
      page_count--;
      pageSelected = 3;

      model --;
    }

    nextButton();
    if (bangNext.button_switched_off == 1) {
      page_count++;
      if (model == 5) {
        pageSelected = 4;
      } else {
        pageSelected=2;
      }
    }
  }
}

void titleBlock() {
  fill(b3);
  rect(0, 0, width, height);

  //title block
  fill(b4);
  noStroke();
  rectMode(CENTER);
  if (pageSelected == 1) {
  } else if (pageSelected == 5 || pageSelected == 6) {
    rect(width/2, 150, width, 300);
  } else {
    rect(width/2, height/2, width, 400);
  }
  noFill();

  //display project logos
  imageMode(CENTER);
  //image(logos, width/2, height/2, 1870, 1052);

  String modelStr = "Model: " + str(model);
  //String pageStr = "Page: " + str(pageSelected);
  String ruleStr = "Rule Set: " + str(rule_set);
  String partStr = "participant: " + nf(participant);
  String frameStr = "FPS: " + nf(frameRate, 2, 2);
  String pageStr = str(page_count) + " of 14";

  fill(white);
  textAlign(LEFT, CENTER);
  textFont(font50);
  if (pageSelected != 1 && pageSelected != 5 && pageSelected != 6) {
    text(partStr, 100, height-50);
  }
  textAlign(RIGHT, CENTER);
  text(pageStr, width-100, height -50);
  //textFont(font20);
  //text(frameStr, width/2, height-30);
}

void nextButton() {
  bangNext.display(p4, p1, white, 15, 15);     
  bangNext.rollover();     
  bangNext.timer(0.25);     
  bangNext.state();
  bangNext.label(white, "next", bangNext.button_width*0.5, bangNext.button_height*0.60);
}

void backButton() {
  bangBack.display(p4, p1, white, 15, 15);
  bangBack.rollover();
  bangBack.timer(0.25);
  bangBack.state();    
  bangBack.label(white, "back", bangBack.button_width*0.5, bangBack.button_height*0.60);
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
  if (pageSelected == 1) {
    rect(width/2, height/2-125, width, 450);
  } else {
    rect(width/2, height/2, width, height/2);
  }

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
    if (pageSelected == 1) {
      text("have a go at scaning a brick...", width/2, height/2-150);
    } else {
      text("scan a brick...", width/2, height/2);
    }
  }

  imageMode(CORNER);
  tint(255, opacity);
  image(display_brick, width/2-100-display_brick.width, height/2 - display_brick.height);
  noTint();
}