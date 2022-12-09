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
        stream: ListaHome(),
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

  Stream<Iterable<Tarefa>> ListaHome() {
    // Filtro pelo horário, falta implantar
    // Filtro pelo dia, falta implantar

    // Esta consulta popula a lista como estava antes
    Stream<Iterable<Tarefa>> consPrioridade = API.listaTarefas();

    /* Esta desabilitado, porque apesar de dar certo em termos de sintaxe ao ser executao da erro
    
    // Para poder fazer um Loop a princípio pelo que sei, precisa ser assim
    Iterable<Tarefa> consPrioridadeX =
        API.listaTarefas().first as Iterable<Tarefa>;

    // Consulta ordenada pelo tempo, já esta pronta, só não tenho como usar ainda
    // Stream<Iterable<Tarefa>> consTempo = API.consTempo();

    List<Tarefa> tarefa = [];

    // Loop principal
    for (Tarefa element in consPrioridadeX) {
      // Loop secundário, vai ter ainda
      // Montagem do resultado
      Tarefa tar = Tarefa(
        id: "1",
        nome: '',
        prioridade: 1,
        diaSemana: false,
        sabado: false,
        domingo: false,
        habilitado: true,
        acao: TarefaAcao(
          emAndamento: false,
          atualizadaEm: Timestamp.now(),
        ),
        tempo: 0,
      );
      tarefa.add(tar);
    } */

    // Transformar para Future<Stream<Iterable<Tarefa>>>

    return consPrioridade;
  }
  
}
