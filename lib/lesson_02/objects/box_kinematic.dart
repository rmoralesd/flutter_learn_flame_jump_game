import 'package:flame/extensions.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';
import 'package:forge2d/src/dynamics/body.dart';

class BoxKinematic extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(worldSize.x / 2, worldSize.y / 2),
      type: BodyType.kinematic,
    );
    final shape = PolygonShape()..setAsBoxXY(0.15, 1.25);
    final fixtureDef = FixtureDef(shape);
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..angularVelocity = radians(180);
  }
}
