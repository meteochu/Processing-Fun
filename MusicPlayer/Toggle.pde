class Toggle extends Button {

  private boolean state;
  final private color onColor, offColor;
  final private PImage imageOff;

  public Toggle(int x, int y, int w, int h, boolean round, boolean state, color onColor, color offColor) {
    super(x, y, w, h, round);
    this.imageOff = null;
    this.state = state;
    this.onColor = onColor;
    this.offColor = offColor;
  }

  public Toggle(int x, int y, int w, int h, boolean round, boolean state, color onColor, color offColor, PImage image) {
    super(x, y, w, h, round, image);
    this.imageOff = null;
    this.state = state;
    this.onColor = onColor;
    this.offColor = offColor;
  }

  public Toggle(int x, int y, int w, int h, boolean round, boolean state, color onColor, color offColor, PImage image, PImage imageOff) {
    super(x, y, w, h, round, image);
    this.imageOff = imageOff;
    this.state = state;
    this.onColor = onColor;
    this.offColor = offColor;
  }

  public void draw() {
    fill((state) ? onColor : offColor);
    super.draw();

  if (image != null && imageOff != null){
    imgVisible = false;
     image(state ? image : imageOff, x, y);
  }
   
  }

  public void onClick() {
    if (inBounds())
      state = !state;
  }
}
