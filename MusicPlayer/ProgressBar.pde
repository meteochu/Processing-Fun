class ProgressBar {

  int x, y, w, h;
  float c;
  int cW;
  int pressX;

  public ProgressBar(int x, int y, int w, int h, float c) {
    this.x = x; //x-point
    this.y = y; //y-point
    this.w = w; //width
    this.h = h; //height
    this.c = c; //current Position
    pressX = 0;
  }


  void draw() {

    rect(x, y, w, h); 

    fill(#FC3D58);  
    rect((x + c) - w/2, y, cW, h);
  }

  void increase(double ratio) {

    c = (float)((ratio * w)-1)/2;
    cW = (int)(ratio * w);
  }
  
  void reset(){
   c = 0;
   cW = 0;
  }

  public boolean inBounds() {
    if (mouseX >= x-w/2 && mouseX <= x+w/2 && mouseY >= y-h/2 && mouseY <= y+h/2) {
      pressX = mouseX - (x - w/2);
      println("X: " + pressX);
      return true;
    } else return false;
  }
}
