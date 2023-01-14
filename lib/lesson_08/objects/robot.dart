import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

enum RobotState {
  idle,
  jump,
  fall,
  walk,
  duck,
}

class Robot extends BodyComponent {
  final _size = Vector2(1.80, 2.4);
  final _componentPosition = Vector2(0, -.325);
  RobotState state = RobotState.idle;

  late final SpriteComponent idleComponent;
  late final SpriteComponent jumpComponent;
  late final SpriteComponent fallComponent;
  late final SpriteComponent duckComponent;
  late final SpriteAnimationComponent walkComponent;

  late Component currentComponent;

  int accelerationX = 0;
  bool isDucking = false;

  Future<List<Sprite>> _loadSprites(String baseName, int n) async {
    final List<Sprite> listOfsprites = [];
    for (int i = 0; i <= n; i++) {
      listOfsprites.add(await gameRef.loadSprite('robot/$baseName$i.png'));
    }
    return listOfsprites;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;

    final idle = await gameRef.loadSprite('robot/robot_idle.png');
    final jump = await gameRef.loadSprite('robot/robot_jump.png');
    final fall = await gameRef.loadSprite('robot/robot_fall.png');
    final duck = await gameRef.loadSprite('robot/robot_duck.png');
    final walk = await _loadSprites('robot_walk', 7);

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

    duckComponent = SpriteComponent(
      sprite: duck,
      size: _size,
      position: _componentPosition,
      anchor: Anchor.center,
    );

    final walkAnimation =
        SpriteAnimation.spriteList(walk, stepTime: 0.05, loop: true);

    walkComponent = SpriteAnimationComponent(
      animation: walkAnimation,
      anchor: Anchor.center,
      position: _componentPosition,
      size: _size,
      removeOnFinish: false,
    );

    currentComponent = idleComponent;

    add(idleComponent);
  }

  void _setComponent(PositionComponent component) {
    if (accelerationX < 0) {
      if (!component.isFlippedHorizontally) {
        component.flipHorizontally();
      }
    } else {
      if (component.isFlippedHorizontally) {
        component.flipHorizontally();
      }
    }
    if (component == currentComponent) return;
    remove(currentComponent);
    currentComponent = component;
    add(component);
  }

  void walkLeft() {
    accelerationX = -1;
  }

  void walkRight() {
    accelerationX = 1;
  }

  void idle() {
    accelerationX = 0;
    isDucking = false;
  }

  void duck() {
    isDucking = true;
    accelerationX = 0;
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
    velocity.x = accelerationX * 3;
    body.linearVelocity = velocity;

    if (velocity.y > 0.1) {
      state = RobotState.fall;
      _setComponent(fallComponent);
    } else if (velocity.y < 0.1 && state != RobotState.jump) {
      if (accelerationX != 0) {
        state = RobotState.walk;
        _setComponent(walkComponent);
      } else if (isDucking) {
        state = RobotState.duck;
        _setComponent(duckComponent);
      } else {
        state = RobotState.idle;
        _setComponent(idleComponent);
      }
    } else if (state == RobotState.jump) {
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
