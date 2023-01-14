import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/particles.dart';
import 'package:flutter_learn_flame_jump_game/lesson_07/objects/ball.dart';
import 'package:flutter_learn_flame_jump_game/lesson_07/objects/box.dart';
import 'package:flutter_learn_flame_jump_game/lesson_07/objects/floor.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

late SpriteAnimation explosion;

class GameLesson07 extends MyGame with TapDetector {
  Future<List<Sprite>> loadSprites() async {
    final List<Sprite> listOfsprites = [];
    for (int i = 1; i <= 19; i++) {
      listOfsprites.add(await loadSprite('explosion/explosion$i.png'));
    }
    return listOfsprites;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await loadSprite('ball.png');
    await loadSprite('box.png');

    final sprites = await loadSprites();
    explosion =
        SpriteAnimation.spriteList(sprites, stepTime: 0.05, loop: false);

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
