import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled_rhythm_game/components/menu/play_button.dart';
import 'package:untitled_rhythm_game/level_constants.dart';
import 'package:untitled_rhythm_game/song_level_component.dart';
import 'package:untitled_rhythm_game/util/main_screen.dart';

class MyGame extends FlameGame with HasTappables {
  late SongLevelComponent currentLevel;

  /// TODO This is a temporary flag until this annoying onGameResize issue is fixed.
  bool isCorrectGameSizeSet = false;
  bool onLoadOccurred = false;
  bool componentsAdded = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    onLoadOccurred = true;
    if (isCorrectGameSizeSet) {
      componentsAdded = true;
      addComponents();
    }

    // Preload all songs.
    Level.values.forEach((level) {
      FlameAudio.audioCache.load(getLevelMP3PathMap(level));
    });
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    if (!componentsAdded) {
      if (!isCorrectGameSizeSet) {
        if (canvasSize.x > 0 && canvasSize.y > 0) {
          isCorrectGameSizeSet = true;
          if (onLoadOccurred) {
            componentsAdded = true;
            addComponents();
          }
        }
      }
    }
  }

  void addComponents() {
    add(TextComponent(
      priority: 0,
      text: "Ready?",
      textRenderer:
          TextPaint(style: TextStyle(color: Colors.white, fontSize: 26)),
      anchor: Anchor.center,
      position: size / 2 - Vector2(0, 150),
    ));
    add(PlayButton(
      onButtonTap: startLevel,
      anchor: Anchor.center,
      position: size / 2 - Vector2(0, 50),
    ));
    add(PlayButton(
      onButtonTap: startLevel2,
      anchor: Anchor.center,
      position: size / 2 + Vector2(0, 50),
    ));
    add(PlayButton(
      onButtonTap: startLevel3,
      anchor: Anchor.center,
      position: size / 2 + Vector2(0, 150),
    ));
  }

  void startLevel() {
    children.clear();
    currentLevel = SongLevelComponent(songLevel: Level.megalovania);
    add(currentLevel);
  }

  void startLevel2() {
    children.clear();
    currentLevel = SongLevelComponent(songLevel: Level.megalovania2);
    add(currentLevel);
  }

  void startLevel3() {
    children.clear();
    currentLevel = SongLevelComponent(songLevel: Level.megalovania3);
    add(currentLevel);
  }
}

main() {
  // 시작 부분
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    // 게임 실행.
    runApp(
      //   MaterialApp(           //에러남
      //   home: const FirstPage(),
      // )
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: GameWidget(
          game: MyGame(),
        ),
      ),
    );
  });
}
