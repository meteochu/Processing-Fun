import controlP5.*;

int r, g, b; //ColorPicker

color blue = color(67, 162, 255);
color red = color(255, 32, 67); //Red
color peach = color(255, 211, 129); // Peach
color black = color(85, 98, 111); //Dark Grey
color picker = color(150);
color green = color(28, 184, 115);
color purple = color(118, 50, 255);
color yellow = color(25, 51, 73);
color lblue = color(96, 223, 229); // Tiffany Blue
color eraser = color(250);
color current = (blue);
color custom = (0);
int myColor = color (0, 0, 0);
ColorButton blueBtn, redBtn, greenBtn, customBtn, purpleBtn, peachBtn, yellowBtn, lblueBtn, blackBtn, eraserBtn;
ColorButton[] cBtns;

ControlP5 cPicker;
color customColor = color(0, 0, 0);
int _red, _blue, _green;
int _size;

boolean showTools;
boolean eyedropper;
boolean smartPen;

PImage newFile, saveFile, openFile, eraserImg, eyeDropperBtn, brush;
ToolButtons _open, _save, _new;


void setup() {
  smooth();
  size(950, 600);
  background(250);
  createSliders();
  r = 0;
  g = 0;
  b = 0;

  showTools = false;
  eyedropper = false;
  smartPen = false;
  textAlign(CENTER);

  newFile = loadImage("assets/New.png");
  saveFile = loadImage("assets/Save.png");
  openFile = loadImage ("assets/Open.png");
  eraserImg = loadImage("assets/Eraser.png");
  eyeDropperBtn = loadImage("assets/Eyedropper.png");
  brush = loadImage("assets/Brush.png");

  //draw Red Button
  blueBtn = new ColorButton(45, 250, blue);
  redBtn = new ColorButton(45, 310, red);
  greenBtn = new ColorButton(45, 370, green);
  customBtn = new ColorButton(100, 370, customColor);
  peachBtn = new ColorButton(100, 250, peach);
  purpleBtn = new ColorButton(100, 310, purple);
  blackBtn = new ColorButton(155, 250, black);
  yellowBtn = new ColorButton(155, 310, yellow);
  lblueBtn = new ColorButton(155, 370, lblue);

  cBtns = new ColorButton[] { blueBtn, redBtn, greenBtn, customBtn, peachBtn, purpleBtn, blackBtn, yellowBtn, lblueBtn };

  _new = new ToolButtons(40, 38, 50, 50, newFile);
  _save = new ToolButtons(100, 38, 50, 50, saveFile);
  _open = new ToolButtons(160, 38, 50, 50, openFile);
}


void draw() {
  sideBar();
  paintBrush();
  customColor();
  showPicker();
  showButtons();
}

void paintBrush() {

  float _smartPen = (abs(dist(pmouseX, pmouseY, mouseX, mouseY)))/3;

  if (mousePressed  && mouseX >= 200 && !eyedropper) {

    if (!smartPen) strokeWeight(_size);
    else if (smartPen)  strokeWeight(_smartPen);
    stroke(current);
    line(pmouseX, pmouseY, mouseX, mouseY);
    noStroke();
  }
}

void showButtons() {
  _new.draw();
  _open.draw();
  _save.draw();
  //draw Custom Button
  eraserBtn = new ColorButton(100, 117, 50, 50, eraser);
  eraserBtn.checkMouse();
  eraserBtn.draw();
  image(eraserImg, 102, 117);

  colorPicker();

  //Smart Pen (BETA)
  fill(eraser);
  ellipse(160, 117, 50, 50);
  image(brush, 160, 117);

  if (smartPen) {

    fill(#007bff);
    ellipse(160, 137, 10, 5);
  }
}

void sideBar() {
  noStroke();
  fill(150);
  rect(0, 0, 200, 650);
  fill(150);
  rect(201, 0, 2, 650);
  fill(current);
  rect(0, 0, 200, 410);
  fill(150);
  rect(0, 155, 200, 55);
  //create CustomColor Rect
  fill(20);
  rect(15, 420, 170, 120, 15);
  triangle(80, 420, 120, 420, 100, 402);
  noFill();


  //Branding
  fill(black);
  rect(30, 550, 145, 20, 5);
  fill(250);
  text("Made by @meteochu", 100, 565);
}

void showPicker() {

  tint(255, 0);

  for (ColorButton cb: cBtns) {
   
    cb.checkMouse();
    cb.draw();
  }

  noTint();
}

void colorPicker() {
  fill(eraser);
  ellipse (40, 117, 50, 50);
  image(eyeDropperBtn, 40, 117);

  if (eyedropper) {
    fill(#007bff);
    ellipse(40, 137, 10, 5);
    if (mouseX > 200) {
      picker = get(mouseX, mouseY);
      if (mousePressed) {
        current = get(mouseX, mouseY);
        eyedropper = false;
      }
    }
  }
}


void mouseReleased() {
  //opening a file
  if (overCircle(160, 38, 50)) {
    selectInput("Open Select Image:", "fileSelected");
  }

  //Save File.
  if (overCircle(100, 38, 50)) {
    selectOutput("Save Image As:", "saveFile");
  }

  //New/Clear Page Button
  if (overCircle(40, 38, 50)) {
    fill(250);
    rect(200, 0, 750, 600);
    fill(150);
    rect(201, 0, 2, 650);
    noFill();
  }

  //select Eyedropper
  if (overCircle(40, 117, 50)) {
    if (!eyedropper) eyedropper = true;
    else if (eyedropper) eyedropper = false;
  }

  //activate S.M.A.R.T. P.E.N.
  if (overCircle(160, 117, 50)) {
    if (smartPen) smartPen = false;
    else smartPen = true;
  }

  //Link to Twitter when Pressing the @meteochu link.
  if (overRect(30, 550, 145, 20)) {
    open("http://twitter.com/meteochu");
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  }
  else {
    return false;
  }
}

boolean overRect(int x, int y, int w, int h) {
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y+h) {
    return true;
  }
  else return false;
}
void fileSelected(File selection) {
  if (selection!=null) {
    PImage file = loadImage(selection.getAbsolutePath());
    imageMode(CENTER);
    if (file.width > 750 || file.height > 600) {

      if (file.width > file.height) file.resize(750, 0);
      else if (file.width < file.height) file.resize(0, 600);
    }
    image(file, (width/2)+100, height/2);
  }
}

void saveFile(File selection) {
  if (selection != null) {
    PImage newImg = get(205, 0, width-205, height);

    /* Creates an extention List so that it will check if the user has included an extension or not.
     If an extension was already added, no extra extension will be added.
     If no extension was detected, the file will be saved as a .png file instead of a .tif
     */

    String[] extensionList = {
      ".png", ".jpg", ".tif", ".tga", ".gif", "jpeg"
    };

    String filePath = selection.getAbsolutePath();
    String extension = "";
    String comparedExtension = filePath.substring(filePath.length()-4, filePath.length());
    boolean hasSaved = false;
    for (int i = 0; i < extensionList.length; i++) {
      if (extensionList[i].contains(comparedExtension)) {
        extension = "";
        newImg.save(filePath + extension);
        hasSaved = true;
      }
    }
    //If the file hadn't been saved (Extension not given) .PNG will be given and the file will be saved
    if (!hasSaved) {
      extension = ".png";
      newImg.save(filePath + extension);
      hasSaved = true;
    }
  }
}

//Custom Color
void customColor() {
  customColor = color (_red, _green, _blue);
}

//Custom Color Setters
void Red(int redColor) {
  _red = redColor;
}

void Green(int greenColor) {
  _green = greenColor;
}

void Blue(int blueColor) {
  _blue = blueColor;
}

//Set Pen Size
void PenSize(int penSize) {
  _size = penSize;
}

void createSliders() {
  cPicker = new ControlP5(this);
  // Create Sliders for Custom Color Selector
  cPicker.addSlider("Red")
    .setPosition(25, 430)
      .setSize(150, 20)
        .setRange(0, 255)
          .setValue(186)
            .setColorBackground(color(255, 0, 64))
              ;

  cPicker.getController("Red").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cPicker.getController("Red").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);


  cPicker.addSlider("Green")
    .setPosition(25, 465)
      .setSize(150, 20)
        .setRange(0, 255)
          .setValue(164)
            .setColorBackground(color(64, 255, 0))
              ;
  cPicker.getController("Green").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cPicker.getController("Green").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);


  cPicker.addSlider("Blue")
    .setPosition(25, 500)
      .setSize(150, 20)
        .setRange(0, 255)
          .setValue(129)
            .setColorBackground(color(0, 64, 255))
              ;
  cPicker.getController("Blue").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cPicker.getController("Blue").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

  cPicker.addSlider("PenSize")
    .setPosition(25, 170)
      .setSize(150, 20)
        .setRange(0, 25)
          .setValue(2)
            ;
  cPicker.getController("PenSize").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cPicker.getController("PenSize").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}
