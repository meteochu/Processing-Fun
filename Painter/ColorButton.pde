  class ColorButton extends Button{

    //fields:
    color c; //color & stroke


    //constructor:
    public ColorButton (int x, int y, int w, int h, color c) {
          super(x,y,w,h);
          this.c = c;
      }

      public ColorButton(int x, int y, color c) {
        
        this(x,y,50,50,c);
      }

      void draw() {
        fill(c);
        strokeWeight(1.5);
        super.draw();
        noStroke();

      }

      void checkMouse() {
        //  if (mouseX >= x-(w/2) && mouseX <= x+(w/2) && mouseY >= y-(w/2) && mouseY <= y+(w/2)) {
        float disX = x - mouseX;
        float disY = y - mouseY;
        if (sqrt(sq(disX) + sq(disY)) < w/2 ) {
            stroke(c);
            if(mousePressed){
              current = c;
              eyedropper = false;
            }
          }
          else {
            stroke(255);
          }
        }
  }
