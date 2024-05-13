import 'package:flutter/material.dart';

class CounterFloatingActionButton extends StatelessWidget {
  final void Function() action;
  final String tooltip;
  final Icon icon;

  const CounterFloatingActionButton({Key? key, required this.action, this.tooltip = "Incremento", this.icon = const Icon(Icons.add)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: action,
      tooltip: tooltip,
      child: icon,
    );
  }
}