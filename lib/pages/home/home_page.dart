import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:ot/pages/home/tarefa_item_component.dart';

import '../../models/tarefa.dart';
import '../../services/api.dart';
import 'home_drawer_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text('OT - Organizador de Tarefas',
            style: theme.textTheme.titleLarge),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/cadastrar_tarefa');
        },
      ),
      body: StreamBuilder<Iterable<Tarefa>>(
        stream: API.listaTarefas(),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            // return Text(snapshot.error.toString());
          }
          return SingleChildScrollView(
            child: Center(
              child: Wrap(
                children: snapshot.data!
                    .map((tarefa) => TarefaItemComponent(tarefa: tarefa))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
