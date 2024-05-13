// clicks_screen.dart
// Tela que vai exibir a quantidade total de clicks que foram acionados no projeto

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_example/controllers/clicks_controller.dart';

class ClicksScreen extends StatelessWidget {
  final ClicksController controller;

  const ClicksScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clicks"),
      ),
      body: Center(
        child: Observer(
          builder: (_) {
            return Text(
              "Total de clicks: ${controller.totalClicks}",
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/action");
        },
        tooltip: "Trocar de Tela",
        child: const Icon(Icons.arrow_circle_right_outlined),
      )
    );
  }
}