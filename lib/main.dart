import 'package:flutter/material.dart';
import 'package:flutter_learn_flame_jump_game/routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    onGenerateRoute: Routes.routes,
  ));
}
