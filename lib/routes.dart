import 'package:flutter/material.dart';
import 'package:flutter_learn_flame_jump_game/lesson_01/game_lesson_01.dart';
import 'package:flutter_learn_flame_jump_game/lesson_02/game_lesson_02.dart';
import 'package:flutter_learn_flame_jump_game/lesson_menu.dart';
import 'package:flutter_learn_flame_jump_game/my_game.dart';

class Routes {
  static const menu = '/';
  static const lesson01 = '/lesson01';
  static const lesson02 = '/lesson02';

  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }

    switch (settings.name) {
      case menu:
        return buildRoute(const LessonMenu());
      case lesson01:
        return buildRoute(MyGameWidget(game: GameLesson01()));
      case lesson02:
        return buildRoute(MyGameWidget(game: GameLesson02()));
      default:
        throw Exception('Route does not exists');
    }
  }
}
