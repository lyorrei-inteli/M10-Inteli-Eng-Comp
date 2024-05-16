import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MinhaSegundaTela extends StatefulWidget {
  const MinhaSegundaTela({super.key});

  @override
  State<MinhaSegundaTela> createState() => _MinhaSegundaTelaState();
}

class _MinhaSegundaTelaState extends State<MinhaSegundaTela> {
  TextEditingController _controller = TextEditingController();
  String _saida = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha segunda tela'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite seu nome',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var resposta = await http.get(Uri.parse('https://viacep.com.br/ws/${_controller.text}/json/'));
              // Para trabalhar com a saída como JSON/Map
              // var resposta_processada = jsonDecode(resposta.body);
              setState(() {
                _saida = resposta.body;
              });
            },
            child: const Text("Consultar"),
          ),
          Text(_saida),
        ],
      ),
    );
  }
}