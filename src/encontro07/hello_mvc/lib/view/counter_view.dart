import 'package:flutter/material.dart';
import 'package:hello_mvc/controller/counter_controller.dart';
import 'package:hello_mvc/widgets/counter_floating_action_button.dart';
import 'package:hello_mvc/widgets/counter_text.dart';

class CounterView extends StatefulWidget {
  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CounterText(text: "Numero de Vezes que Foi Acionado"),
            CounterText(text: '${_controller.counter}', isBigger: true),
          ],
        ),
      ),
      floatingActionButton: CounterFloatingActionButton(
        action: (){
          setState(() {
            _controller.incrementCounter();
          });
        },
      )
    );
  }
}
