import 'package:flutter/material.dart';
import 'package:flutter_learn_flame_jump_game/lesson_menu.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class Routes {
  static const menu = '/';
  static const lesson01 = '/lesson01';

  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }

    switch (settings.name) {
      case menu:
        return buildRoute(const LessonMenu());
      case lesson01:
        return buildRoute(MyGameWidget(game: MyGame()));
      default:
        throw Exception('Route does not exists');
    }
  }
}
