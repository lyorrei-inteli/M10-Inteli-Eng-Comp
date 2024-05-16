import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {
  final String text;
  final bool isBigger;

  const CounterText({Key? key, required this.text, this.isBigger = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: isBigger ? Theme.of(context).textTheme.headline4 : Theme.of(context).textTheme.headline5,
    );
  }
}