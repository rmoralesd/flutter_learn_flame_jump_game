import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class Ball extends BodyComponent {
  @override
  Body createBody() {
    final bodyRef =
        BodyDef(position: Vector2(worldSize.x / 2, 0), type: BodyType.dynamic);

    final shape = CircleShape()..radius = 0.35;
    final fixtureDef = FixtureDef(shape);
    return world.createBody(bodyRef)..createFixture(fixtureDef);
  }
}
