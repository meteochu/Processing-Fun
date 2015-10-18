MusicPlayer
===========

Just a (really) Basic Processing Music Player.
Using the Minim Library for music controls, playbacks, etc.

 * MusicPlayer.pde controls the UI and playback.  
 * Audio class is for individual tracks.  
 * AudioList class controls the list of Audio objects.  
 * Buttons/Toggles... I don't think I need to explain further.  
 * Progress Bar... Pretty Self Explanatory, right?


The playback is currently very wonky because Minim's AudioPlayer.length() method is returning the wrong metadata and it's breaking quite a few things.  
Most of the app works just fine. (Select Input, Play/Pause/Next/Prev, Repeat (Song), Shuffle, Audio Queue, etc.)

# To-Do
* ~~Music Queue~~
* ~~Up Next~~
* ~~Remove Song from List~~
* ~~Remove All Songs (Clear Queue)~~
* Display Album Cover (maybe)
* Visual Improvements(?)
* ...and More.


# Dependencies
* [Minim - Compartmental](http://code.compartmental.net/tools/minim/)
* [Processing Sound](https://github.com/processing/processing-sound)
