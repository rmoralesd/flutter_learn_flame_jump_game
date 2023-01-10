import 'package:flame_forge2d/flame_forge2d.dart';

class Box extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(7.5, 0),
      type: BodyType.dynamic,
    );

    final shape = PolygonShape()..setAsBoxXY(0.25, 0.25);
    final fixtureDef = FixtureDef(shape)
      ..density = 5
      ..friction = .25
      ..restitution = .4;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
