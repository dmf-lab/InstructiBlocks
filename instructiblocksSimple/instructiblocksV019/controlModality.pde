//contains all the necessary auxillary functions to make the GUI elements work

//processing doesn't handle touch events very well, this is a workaround to make the touch input work for buttons
boolean mouseMoved;
int mouse_xPos;
int mouse_yPos;

void checkMouseMoved() {
  if (mouseX==pmouseX && mouseY==pmouseY) {
    mouseMoved = false;
  } else if (mouseX!=pmouseX && mouseY!=pmouseY) {
    mouseMoved = true;
    //println(mouseMoved+"\t"+mouse_xPos+"\t"+mouse_yPos);
  }
}