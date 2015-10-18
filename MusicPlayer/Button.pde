class Button {

  final protected int x, y, w, h;
  final private boolean round;
  final protected PImage image;
  protected boolean imgVisible;

  public Button(int x, int y, int w, int h, boolean round) {
    this.image = null;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.round = round;
    imgVisible = false;
  }

  public Button(int x, int y, int w, int h, boolean round, PImage image) {
    this.image = image;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.round = round;
     imgVisible = true;
  }


  public void draw() {
    noStroke();

    if (round) {
      ellipse(x, y, w, h);
    } else {
      rect(x, y, w, h);
    }
    
    if (imgVisible) image(image, x, y);
   
  }

  public boolean inBounds() {
    return mouseX >= x-w/2 && mouseX <= x+w/2 && mouseY >= y-h/2 && mouseY <= y+h/2;
  }
}
