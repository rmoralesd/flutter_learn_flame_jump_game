import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn_flame_jump_game/lesson_menu.dart';

class Routes {
  static const menu = '/';
  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }

    switch (settings.name) {
      case menu:
        return buildRoute(const LessonMenu());
      default:
        throw Exception('Route does not exists');
    }
  }
}