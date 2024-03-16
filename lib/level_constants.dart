enum Level { megalovania, megalovania2, megalovania3 }

String getLevelBeatMapPath(Level level) {
  switch (level) {
    case Level.megalovania:
      return "assets/beat_maps/megalovania.json";

    case Level.megalovania2:
      return "assets/beat_maps/megalovania2.json";

    case Level.megalovania3:
      return "assets/beat_maps/megalovania3.json";
  }
}

String getLevelMP3PathMap(Level level) {
  switch (level) {
    case Level.megalovania:
      return "music/megalovania.mp3";

    case Level.megalovania2:
      return "music/Undertale.mp3";

    case Level.megalovania3:
      return "music/lostark.mp3";
  }
}
