class Audio {

  Minim minim;
  AudioPlayer song;
  AudioMetaData meta;

  SoundFile audio;

  String name, album, author;
  int tMinutes, tSeconds, tTime;
  int cMinutes, cSeconds, cTime;
  PImage albumCover;

  boolean isPlaying;


  public Audio(String _filePath) { //somehow it has to inherit minim from the main class ._.
    minim = new Minim(pa); //pa is the main PApplet
    song = minim.loadFile(_filePath);
    meta = song.getMetaData();
    name = meta.title();
    album = meta.album();
    author = meta.author();

    audio = new SoundFile(pa, _filePath); //temporarily using SoundFile to grab more accurate Song Durations.
    tTime = (int)song.length() / 1000;
    tSeconds = (int)(tTime) % 60;
    tMinutes = (int)(tTime/60) % 60;
    cTime = cSeconds = cMinutes = 0;

    isPlaying = false;
  }


  void play() {
    if (!isPlaying) {
      audio.play();
      isPlaying = true;
    }
  }

  int getCurrentTime() {
    cTime = song.position() /1000;
    cSeconds = (int)(cTime) % 60;
    cMinutes = (int)(cTime/60) % 60;

    return cTime;
  }


  void drawWave() {
    for (int i = 0; i < song.bufferSize () - 1; i++) {
      stroke(255, 255, 255, 50);
      line(i, height/2 - 80 + song.left.get(i)*50, i+1, height/2 - 80 + song.left.get(i+1)*50);
      line(i, height/2 + 80  + song.right.get(i)*50, i+1, height/2 + 80 + song.right.get(i+1)*50);
    }
  }
}

