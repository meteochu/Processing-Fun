class AudioList {
  ArrayList<Audio> audioList;
  Audio currentTrack;

  public AudioList() {
    audioList = new ArrayList<Audio>();
  }

  void addSong(Audio audio) {
    audioList.add(audio);
    if (currentTrack == null) //if no tracks are in the arrayList, make the first track currentTrack
      currentTrack = audio;
  }

  int getTotalTracks() { 
    return audioList.size();
  }


  void nextTrack() {
    if (currentTrack != null) {
      currentTrack.song.pause();
      if (getTotalTracks() > 0 && !repeat.state) {
        if (shuffle.state) {
          int pTrack = audioList.indexOf(currentTrack); //check
          currentTrack = audioList.get((int)random(getTotalTracks()));
          if (!(getTotalTracks() == 1 || audioList.indexOf(currentTrack) != pTrack)) { //checks that the random track isn't the old track if there are more than 1 songs.
            nextTrack();
          }
        } else {
          if (audioList.indexOf(currentTrack) < getTotalTracks() -1) {
            currentTrack.song.pause();
            currentTrack = audioList.get(audioList.indexOf(currentTrack)+1);
          } else {
            currentTrack.song.pause();
            currentTrack = audioList.get(0);
          }
        }
      }
      currentTrack.song.rewind(); //reset song back to 0:00 before it plays
      currentTrack.song.play();
    }
  }

  void prevTrack() {
    if (currentTrack != null) {
      currentTrack.song.pause();
      if (getTotalTracks() > 0) {
        if (currentTrack.cSeconds < 5) {
          if (audioList.indexOf(currentTrack) > 0) {
            currentTrack = audioList.get(audioList.indexOf(currentTrack)-1);
          } else {
            currentTrack = audioList.get(getTotalTracks() - 1);
          }
        }
      }
      currentTrack.song.rewind(); //makes sure the songs are back at 0:00 before it plays
      currentTrack.song.play();
    }
  }

  void endSession() {
    currentTrack.song.pause();
    for (int i = 0; i < getTotalTracks(); i++){
      audioList.get(i).minim.stop();
      audioList.remove(i);
    }
    currentTrack = null;
    audioList.clear();
  }

  int indexOf(Audio audio){
   return audioList.indexOf(currentTrack);
    
  }
  void removeSong(int index) {
    currentTrack.song.pause();
    currentTrack.minim.stop();
    audioList.remove(index);
    if (getTotalTracks() == 0) currentTrack = null;
    nextTrack();
    
  }
  
  String upNext(){
   return (audioList.indexOf(currentTrack) < getTotalTracks() -1) ? 
             audioList.get(audioList.indexOf(currentTrack)+1).name 
           : audioList.get(0).name; 
    
  }
  
  void debug(){
    println("/f");
    String divider = "========================";
    println(divider);
    for (int i = 0; i < audioList.size(); i++){
      println(audioList.get(i).meta.title());
    }
    println(divider);
    println("Array has " + getTotalTracks() + " tracks.");
    println("Current Song Index: " + indexOf(currentTrack));
    
  }
}
