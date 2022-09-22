// ignore_for_file: avoid_print

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
          title: const Text('OT - Organizador de Tarefas'),
        ),
        body: Column(children: [
          Center(
              heightFactor: 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastrarTarefa()),
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

class CadastrarTarefa extends StatelessWidget {
  final List<String> _locations = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  String? _selectedLocation;

  final TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;

  bool? h1 = true;
  bool? h2 = false;
  bool? h3 = false;

  String Nome = "";
  String Prioridade = "";
  String Horario = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar a tarefa",
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
            )),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome da tarefa';
                }
                return value;
              },
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Informe o nome da tarefa',
              ),
              onChanged: (newValue) {
                Nome = newValue;
              },
            ),
            DropdownButton(
              hint: const Text('Escolha a prioridade'),
              value: _selectedLocation,
              onChanged: (newValue) {
                Prioridade = newValue.toString();
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                selectTime(context);
              },
              child: const Text('Definir Horário Limite',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  )),
            ),
            CheckboxListTile(
              title: const Text('Dias de semana'),
              value: h1,
              onChanged: (bool? value) {
                h1 = value;
              },
            ),
            CheckboxListTile(
              title: const Text('Sábados'),
              value: h2,
              onChanged: (bool? value) {
                h2 = value;
              },
            ),
            CheckboxListTile(
              title: const Text('Domingos'),
              value: h3,
              onChanged: (bool? value) {
                h3 = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                print('Nome = ' + Nome + " Prioridade = " + Prioridade);
              },
              child: const Text('Salvar',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                print('Cancelar');
              },
              child: const Text('Cancelar',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
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
