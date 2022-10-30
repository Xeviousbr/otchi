import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import 'cadastrar_tarefa.dart';
import 'tarefa.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  List<Tarefa> tarefas = [];

  @override
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
      drawer: Drawer(
        child: Column(
          children: [
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                bool logOut = await logout();
                if (logOut) {
                  Navigator.of(context).pushNamed('/login');
                }
              },
              child: const Text('Deslogar'),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('OT - Organizador de Tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/cadastrar_tarefa');
        },
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: tarefas.map(
                (tarefa) {
                  return Card(
                    child: Text(tarefa.nome),
                  );
                },
              ).toList(),
            ),
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
