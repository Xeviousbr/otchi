import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ot/pages/home/card_item.dart';
import 'package:ot/pages/home/plugins/card_plugin.dart';
import 'package:ot/pages/home/tarefa_item_component.dart';
import 'package:ot/services/auth_service.dart';
import 'package:uuid/uuid.dart';

import '../../models/tarefa.dart';
import '../../services/api.dart';
import 'plugins/card_plugin_factory.dart';

class HomePage extends StatefulWidget {
  // const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Tarefa? _tarefaRascunho;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await AuthService.logout();
              },
              child: Text(
                'Deslogar',
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('OT - Organizador de Tarefas', style: theme.textTheme.titleLarge),
      ),
      floatingActionButton: _tarefaRascunho == null
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                setState(() {
                  _tarefaRascunho = Tarefa(
                    id: const Uuid().v1(),
                    nome: '',
                    prioridade: 1,
                    diaSemana: false,
                    sabado: false,
                    domingo: false,
                    habilitado: true,
                    rascunho: true,
                    acao: TarefaAcao(
                      emAndamento: false,
                      atualizadaEm: Timestamp.now(),
                    ),
                    tempo: 0,
                  );
                });
              },
            )
          : null,
      body: StreamBuilder<Iterable<Tarefa>>(
        stream: API.listaTarefas(),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Wrap(
              spacing: 4,
              runSpacing: 12,
              children: [
                CardItemViewModel(
                  content: 'Bla bla bla',
                  id: '1',
                  plugins: [CardPluginType.text],
                ),
                CardItemViewModel(
                  content: 'Foo Foo Foo',
                  id: '2',
                  plugins: [
                    CardPluginType.text,
                    CardPluginType.timer,
                    CardPluginType.notifier,
                  ],
                ),
                CardItemViewModel(
                  content: 'Bar Bar Bar',
                  id: '3',
                  plugins: [
                    CardPluginType.timer,
                  ],
                ),
              ].map((item) => CardItem(item: item, buildPlugin: buildPlugin)).toList(),
            ),
          );

          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            if (snapshot.data?.where((element) => element.id == _tarefaRascunho?.id).isNotEmpty ?? false) {
              setState(() {
                _tarefaRascunho = null;
              });
            }
          });
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            // return Text(snapshot.error.toString());
          }
          return SingleChildScrollView(
            child: Center(
              child: Wrap(
                children: [
                  if (_tarefaRascunho != null)
                    TarefaItemComponent(
                      tarefa: _tarefaRascunho!,
                      onCancel: () {
                        setState(() {
                          _tarefaRascunho = null;
                        });
                      },
                    ),
                  ...snapshot.data!.map((tarefa) => TarefaItemComponent(tarefa: tarefa)).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
