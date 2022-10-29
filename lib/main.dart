import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ot/login_page/login_page.dart';
import 'package:ot/tarefa.dart';
import 'cadastrar_tarefa.dart';
import 'api.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const LoginPage(),
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
  List<Tarefa> tarefas = [];

  void initState() {
    super.initState();
    API.listaTarefas().then((items) {
      setState(() {
        tarefas = items.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OT - Organizador de Tarefas'),
      ),
      body: Column(
        children: [
          Column(
            children: <Widget>[
              Center(
                heightFactor: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CadastrarTarefa(),
                      ),
                    );
                  },
                  child: const Text(
                    'Nova Tarefa',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  bool logOut = await logout();
                  if (logOut) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Logout',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: tarefas.map(
                    (tarefa) {
                      return ListTile(
                        title: Text(tarefa.nome),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> logout() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    await prefer.clear();
    return true;
  }
}
