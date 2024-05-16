import 'package:flutter/material.dart';
import 'package:implementa_mvc/controllers/click_controller.dart';

class ClickView extends StatefulWidget {
  ClickView({super.key});

  @override
  State<ClickView> createState() => _ClickViewState();
}

class _ClickViewState extends State<ClickView> {
  final ClickController _clickController = ClickController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Implementa MVC'),
        ),
      body: Column(
        children: [
          Text("Clicks!"),
          Text("${_clickController.count}"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _clickController.increment();
          setState(() {});
          
        },
        child: Icon(Icons.add),
      )

    );
  }
}