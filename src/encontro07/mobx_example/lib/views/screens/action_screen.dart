// action_screen.dart
// Tela que vai alterar o valor de totalClicks

import 'package:flutter/material.dart';
import 'package:mobx_example/controllers/click_action_controller.dart'; 

class ActionScreen extends StatelessWidget {
  final ClickActionController controller;

  const ActionScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Action"),
      ),
      body: Center(
        child: Column(children: [
          const Text(
            "Pressione o botão para incrementar o total de clicks",
            style: TextStyle(fontSize: 24),
          ),
          OutlinedButton(
              onPressed: controller.incrementClicks,
              child:
                  const Text("Incrementar Clicks", style: TextStyle(fontSize: 24))),
        ]),
      ),
    );
  }
}
