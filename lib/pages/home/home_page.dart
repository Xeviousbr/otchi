import 'dart:async';
import 'package:flutter/material.dart';

import 'package:ot/pages/home/tarefa_item_component.dart';

import '../../models/tarefa.dart';
import '../../services/api.dart';
import '../cadastrar_tarefa.dart';
import 'home_drawer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> shouldStopTimer = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isDataSaved = ValueNotifier<bool>(false);
  List<Tarefa> tarefas = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: Text('OT - Organizador de Tarefas',
            style: theme.textTheme.titleLarge),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          shouldStopTimer.value = false;
          isDataSaved.value = false;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CadastrarTarefa(
              shouldStopTimer: shouldStopTimer,
              isDataSaved: isDataSaved,
            ),
          ));

          Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
            if (shouldStopTimer.value) {
              timer.cancel();
              if (isDataSaved.value) {
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Dados salvos com sucesso!'),
                    ),
                  );
                });
              }
            }
          });
        },
      ),
      body: StreamBuilder<Iterable<Tarefa>>(
        stream: API.listaTarefas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            tarefas = snapshot.data!.toList();
          }
          return SingleChildScrollView(
            child: Center(
              child: Wrap(
                children: tarefas
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
