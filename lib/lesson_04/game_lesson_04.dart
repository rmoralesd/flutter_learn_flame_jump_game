import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_learn_flame_jump_game/lesson_04/objects/ball.dart';
import 'package:flutter_learn_flame_jump_game/lesson_04/objects/floor.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class GameLesson04 extends MyGame with TapDetector {
  final balls = [(Ball(1)), (Ball(4)), (Ball(7))];
  final speed = Vector2(0, -9);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Floor());
    addAll(balls);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    balls[0].body.applyForce(speed);
    balls[1].body.applyLinearImpulse(speed);
    balls[2].body.linearVelocity = speed;
  }
}
