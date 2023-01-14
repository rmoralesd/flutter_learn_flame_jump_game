import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_flame_jump_game/lesson_08/objects/floor.dart';
import 'package:flutter_learn_flame_jump_game/lesson_08/objects/robot.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class GameLesson08 extends MyGame {
  final robot = Robot();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Floor());
    add(robot);
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set keysPressed) {
    super.onKeyEvent(event, keysPressed);
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        robot.jump();
      }
    }
    return KeyEventResult.handled;
  }
}
