// main.dart
// Arquivo principal da aplicação

import 'package:flutter/material.dart';
import 'package:mobx_example/controllers/click_action_controller.dart';
import 'package:mobx_example/controllers/clicks_controller.dart';
import 'package:mobx_example/views/screens/action_screen.dart';
import 'package:mobx_example/views/screens/clicks_screen.dart';

void main() {
  final ClicksController clicksController = ClicksController();
  final ClickActionController actionController = ClickActionController(clicksController);

  runApp(MyApp(clicksController: clicksController, actionController: actionController));
}

class MyApp extends StatelessWidget {
  final ClicksController clicksController;
  final ClickActionController actionController;

  const MyApp({Key? key, required this.clicksController, required this.actionController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Example',
      initialRoute: "/clicks",
      routes: {
        "/clicks": (context) => ClicksScreen(controller: clicksController),
        "/action": (context) => ActionScreen(controller: actionController),
      },
    );
  }
}