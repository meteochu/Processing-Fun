class ToolButtons extends Button{

  PImage img;

  public ToolButtons(int x, int y, int w, int h, PImage img){
    super(x,y,w,h);
    this.img = img;
  }

  public void draw(){
    fill(eraser);
    imageMode(CENTER);
    super.draw();
    image(img,x,y);
    

  }
}
