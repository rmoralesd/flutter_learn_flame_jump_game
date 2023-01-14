import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

enum RobotState {
  idle,
  jump,
  fall,
}

class Robot extends BodyComponent {
  final _size = Vector2(1.80, 2.4);
  final _componentPosition = Vector2(0, -.325);
  RobotState state = RobotState.idle;

  late final SpriteComponent idleComponent;
  late final SpriteComponent jumpComponent;
  late final SpriteComponent fallComponent;

  late Component currentComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final idle = await gameRef.loadSprite('robot/robot_idle.png');
    final jump = await gameRef.loadSprite('robot/robot_jump.png');
    final fall = await gameRef.loadSprite('robot/robot_fall.png');

    idleComponent = SpriteComponent(
      sprite: idle,
      size: _size,
      position: _componentPosition,
      anchor: Anchor.center,
    );

    jumpComponent = SpriteComponent(
      sprite: jump,
      size: _size,
      position: _componentPosition,
      anchor: Anchor.center,
    );

    fallComponent = SpriteComponent(
      sprite: fall,
      size: _size,
      position: _componentPosition,
      anchor: Anchor.center,
    );

    currentComponent = idleComponent;

    add(idleComponent);
  }

  void _setComponent(PositionComponent component) {
    if (component == currentComponent) return;
    remove(currentComponent);
    currentComponent = component;
    add(component);
  }

  void jump() {
    if (state == RobotState.jump) return;
    final velocity = body.linearVelocity;
    body.linearVelocity = Vector2(velocity.x, -10);
    state = RobotState.jump;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final velocity = body.linearVelocity;
    if (velocity.y > 0.1) {
      state = RobotState.fall;
      _setComponent(fallComponent);
    } else if (velocity.y < 0.1 && state != RobotState.jump) {
      state = RobotState.idle;
      _setComponent(idleComponent);
    } else {
      _setComponent(jumpComponent);
    }

    // if (state == RobotState.jump) {
    //   _setComponent(jumpComponent);
    // } else if (state == RobotState.fall) {
    //   _setComponent(fallComponent);
    // } else {
    //   _setComponent(idleComponent);
    // }
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x / 2, worldSize.y - 3),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..setAsBoxXY(_size.x / 2, .90);

    final fixtureDef = FixtureDef(shape)
      ..density = 15
      ..friction = 0
      ..restitution = 0;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
