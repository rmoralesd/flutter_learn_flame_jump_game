import 'package:flutter_learn_flame_jump_game/lesson_01/objects/ball.dart';
import 'package:flutter_learn_flame_jump_game/lesson_02/objects/floor_static.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class GameLesson02 extends MyGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(FloorStatic());
  }
}
