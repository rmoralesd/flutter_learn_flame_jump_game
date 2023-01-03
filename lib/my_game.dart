import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn_flame_jump_game/main.dart';
import 'package:flutter_learn_flame_jump_game/routes.dart';

final screenSize = Vector2(1280, 720);

class MyGame extends Forge2DGame with KeyboardEvents {
  MyGame() : super(zoom: 100, gravity: Vector2(0, 15));

  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(screenSize);
    add(_Background(size: screenSize)..positionType = PositionType.viewport);
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set keyPressed) {
    if (event is RawKeyDownEvent) {
      if (keyPressed.contains(LogicalKeyboardKey.escape)) {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(Routes.menu, (route) => false);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Color backgroundColor() {
    return Colors.red;
  }
}

class _Background extends PositionComponent {
  _Background({super.size});
  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x, size.y), BasicPalette.black.paint());
  }
}
