import 'dart:math';
import 'package:flame/events.dart';
import 'package:flutter_learn_flame_jump_game/lesson_06/objects/ball.dart';
import 'package:flutter_learn_flame_jump_game/lesson_06/objects/box.dart';
import 'package:flutter_learn_flame_jump_game/lesson_06/objects/floor.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class GameLesson06 extends MyGame with TapDetector {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    await loadSprite('ball.png');
    await loadSprite('box.png');
    add(Floor());
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (Random().nextBool()) {
      add(Ball());
    } else {
      add(Box());
    }
  }
}
