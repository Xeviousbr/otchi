import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ot/login_page/login_page.dart';
import 'cadastrar_tarefa.dart';
import 'tarefa.dart';
import 'api.dart';

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
      home: LoginPage(),
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
  List<String> list = ["Tarefa 1", "Tarefa 2", "Tarefa 3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OT - Organizador de Tarefas'),
        ),
        body: Column(children: [
          Column(children: <Widget>[
            Center(
                heightFactor: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastrarTarefa()),
                    );
                  },
                  child: const Text('Nova Tarefa',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                      )),
                )),
            Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: {},
                children: [
                  for (var item in list)
                    TableRow(children: [
                      Text(item,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                          ))
                    ])
                ])
          ])
        ]));
  }
}
