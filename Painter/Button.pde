class Button {
    int x, y, w, h;

  public Button(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
  }

  void draw() {
    ellipse(x, y, w, h);
    noStroke();
  }
}
