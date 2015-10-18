import ddf.minim.*;
import processing.sound.*;

PApplet pa = this;
color blue = #1DBFAF;
color red = #FC3D58;
color white = color(255);
color clear = color(255, 255, 255, 0);

Toggle playButton, debugButton, repeat, shuffle;
Button openFileButton, nextButton, prevButton;
Button endSession, removeSong;
ProgressBar songProgress;

PImage play, pause, next, prev, open, reset, trash;
double playPosition;
Audio newSong;
AudioList songList;
boolean debug;

void setup() {
  size(600, 400);
  frameRate(60);
  smooth(4);
  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  //Load Assets
  next = loadImage("Assets/Next.png");
  prev = loadImage("Assets/Prev.png");
  play = loadImage("Assets/Play.png");
  pause = loadImage("Assets/Pause.png");
  open = loadImage("Assets/Open.png");
  reset = loadImage("Assets/Reset.png");
  trash = loadImage("Assets/Trash.png");

  playButton = new Toggle(width/2, height/2-20, 80, 80, true, false, red, blue, play, pause);
  repeat = new Toggle(width/2 - 30, height/2 + 60, 50, 25, false, false, red, clear);
  shuffle = new Toggle(width/2 + 30, height/2 + 60, 50, 25, false, false, red, clear);
  prevButton = new Button(width/4 + 50, height/2-20, 60, 60, true, prev);
  nextButton = new Button(width - width/4 - 50, height/2-20, 60, 60, true, next);
  openFileButton = new Button(25, 25, 50, 50, false, open);
  endSession = new Button(width/2 - 40, height - 40, 60, 60, true, reset);
  removeSong = new Button(width/2 + 40, height - 40, 60, 60, true, trash);
  debugButton = new Toggle(width-70, 15, 140, 30, false, false, red, blue);
  songList = new AudioList();

  songProgress = new ProgressBar(width/2, height/2 + 100, 350, 10, 0);

  textFont(createFont("Helvetica Neue", 50, true));
  playPosition = 1;
  debug = false;
}

void draw() {

  background(#2A3446);
  if (hasCurrentSong()) songList.currentTrack.drawWave();

  openFileButton.draw();
  debugButton.draw();
  playButton.draw();
  nextButton.draw();
  prevButton.draw();
  removeSong.draw();
  endSession.draw();
  repeat.draw();
  shuffle.draw();
  printText();
  songProgress.draw();



  if (hasCurrentSong()) {
    songProgress.increase((double)songList.currentTrack.getCurrentTime()/(double)songList.currentTrack.tTime);
    if (debugButton.state) {
      songList.debug();
    }

    if (!playButton.state) {
      songList.currentTrack.song.play();
      if (songList.currentTrack.cTime >= songList.currentTrack.tTime - 1) {
        songList.nextTrack();
      }
    } else {
      songList.currentTrack.song.pause();
    }
  } else {
    songProgress.reset(); //simluate
  }
}



void mouseReleased() {
  playButton.onClick();
  repeat.onClick();
  shuffle.onClick();
  debugButton.onClick();


  if (openFileButton.inBounds()) {
    selectInput("Please Select a Media File: ", "processFile");
  }

  if (nextButton.inBounds()) {
    songList.nextTrack();
  }

  if (prevButton.inBounds()) {
    songList.prevTrack();
  }

  if (songProgress.inBounds() && hasCurrentSong()) {
    double ratio = (double)songProgress.pressX/(double)songProgress.w;
    songProgress.increase(ratio);
    songList.currentTrack.song.cue((int)(ratio * songList.currentTrack.tTime) * 1000);
  }

  if (endSession.inBounds()) {
    if (hasCurrentSong()) songList.endSession();
  }

  if (removeSong.inBounds()) {
    if (hasCurrentSong()) songList.removeSong(songList.indexOf(songList.currentTrack));
  }
}

void processFile(File selection) {
  if (selection != null) {
    newSong = new Audio(selection.getAbsolutePath());
    songList.addSong(newSong);
  }
}

void printText() {
  fill(255);
  textSize(hasCurrentSong() && songList.currentTrack.name.length() > 30 ? (70- songList.currentTrack.name.length()) : 30);
  text(hasCurrentSong() ? (songList.currentTrack.name) : "Welcome to Playr", width/2, height/2 - 140);
  textSize(20);
  text(hasCurrentSong() ? (songList.currentTrack.author + " – " + songList.currentTrack.album) : "Open a file to play.", width/2, height/2 - 110);
  textSize(16);
  text(hasCurrentSong() ? ("Up Next: " + songList.upNext()) : "", width/2, height/2-180);
  textSize(14);
  text(hasCurrentSong() ? (String.format("%02d:%02d", songList.currentTrack.tMinutes, songList.currentTrack.tSeconds)) : "--:--", width/2 + 200, height/2 + 99);
  text(hasCurrentSong() ? (String.format("%02d:%02d", songList.currentTrack.cMinutes, songList.currentTrack.cSeconds)) : "00:00", width/2 - 200, height/2 + 99);
  text("Repeat", width/2 - 30, height/2 +58);
  text("Shuffle", width/2 + 30, height/2 + 58);
  text("Debug Mode: " + (debugButton.state ? "ON" : "OFF"), width-70, 15);
}

boolean hasCurrentSong() {
  return songList.currentTrack != null;
}
