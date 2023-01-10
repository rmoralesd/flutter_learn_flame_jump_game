import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter_learn_flame_jump_game/lesson_06/objects/object_state.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class Box extends BodyComponent with ContactCallbacks {
  ObjectState state = ObjectState.normal;

  void hit() {
    if (state == ObjectState.normal) {
      state = ObjectState.explode;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sprite = Sprite(gameRef.images.fromCache('box.png'));
    add(
      SpriteComponent(
        sprite: sprite,
        size: Vector2(.5, .5),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x / 2, 0),
      type: BodyType.dynamic,
    );

    final shape = PolygonShape()..setAsBoxXY(.25, .25);
    final fixtureDef = FixtureDef(shape)
      ..density = 5
      ..friction = .5
      ..restitution = .5;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (state == ObjectState.explode) {
      world.destroyBody(body);
      gameRef.remove(this);
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Box) {
      hit();
    }
  }
}
