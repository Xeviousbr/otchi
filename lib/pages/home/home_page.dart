import 'package:flutter/material.dart';
import 'package:ot/pages/home/tarefa_item_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/tar_lista.dart';
import '../../services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<TarLista> tarefas = [];

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
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                bool logOut = await logout();
                if (logOut) {
                  if (!mounted) return;
                  Navigator.of(context).pushNamed('/login');
                }
              },
              child: const Text('Deslogar'),
            ),
            const SizedBox(height: 40),
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
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: tarefas.map((tarefa) => TarefaItemComponent(tarefa: tarefa)).toList(),
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
