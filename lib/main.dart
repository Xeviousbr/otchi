import 'package:flutter/material.dart';

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
          title: Text('OT - Organizador de Tarefas'),
        ),
        body: Column(children: const [
          Center(
            heightFactor: 2,
            child: Text('Aqui deverá ter um botão um dia',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                )),
          ),
          Text('Tarefa 1',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
              )),
          Text('Tarefa 2',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
              )),
          Text('Tarefa 3',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
              )),
          Text('Tarefa 4',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
              )),
          Text('Tarefa 5',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
              ))
        ]));
  }
}
