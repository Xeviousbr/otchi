import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:ot/post_detail.dart';
// import 'package:ot/post_model.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'cadastrarTarefa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OT - Organizador de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'OT - Organizador de Tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OT - Organizador de Tarefas'),
        ),
        body: Column(children: [
          Center(
              heightFactor: 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => cadastrarTarefa()),
                  );
                },
                child: const Text('Nova Tarefa',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                    )),
              )),
          const Text('Tarefa 1',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
              ))
        ]));
  }
}

class Tarefas {
  String? Nome;
  int? Prioridade;
  bool? HabDiaSem;
  bool? HamSab;
  bool? HabDom;
  bool? Habilitado;

  Tarefas(
      {this.Nome,
      this.Prioridade,
      this.HabDiaSem,
      this.HamSab,
      this.HabDom,
      this.Habilitado});
}
