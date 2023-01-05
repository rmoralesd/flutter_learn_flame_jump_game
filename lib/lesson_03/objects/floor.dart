import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class Floor extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
        position: Vector2(
          0,
          worldSize.y - 1.95,
        ),
        type: BodyType.static);
    final shape = EdgeShape()..set(Vector2.zero(), Vector2(worldSize.x, -2));
    final fixtureDef = FixtureDef(shape)..friction = 0.1;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
