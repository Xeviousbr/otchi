import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/tarefa.dart';

class API {
  static CollectionReference<Map<String, dynamic>> _tarefasCollection() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(userId).collection('tarefas');
  }

  static Future<void> cadastra(Tarefa tarefa) async {
    final data = tarefa.toJson();
    data.remove('id');
    await _tarefasCollection().add(data);
  }

  static Future<void> edita(Tarefa tarefa) async {
    final data = tarefa.toJson();
    data.remove('id');
    await _tarefasCollection().doc(tarefa.id).set(data);
  }

  static Stream<Iterable<Tarefa>> listaTarefas() {
    return _tarefasCollection()
        .withConverter<Tarefa>(
          fromFirestore: (snapshots, _) => Tarefa.fromJson(
            {
              ...snapshots.data()!,
              'id': snapshots.id,
            },
          ),
          toFirestore: (tarefa, _) => tarefa.toJson(),
        )
        .orderBy('tempo')
        .snapshots()
        .map((event) => event.docs.map((doc) => doc.data()))
        .map((items) => items.where((item) => (item.habilitado == true)))
        .map((items) => items.toList()
          ..sort((a, b) => (a.tempo * (1 + ((a.prioridade - 1) * 1.07)))
              .compareTo(b.tempo * (1 + ((b.prioridade - 1) * 1.07)))));
  }

  static Future deleta(String id) async {
    return _tarefasCollection().doc(id).delete();
  }

  static Future<void> acaoTarefa(Tarefa tarefa, bool iniciou) {
    final tempoAtual = Timestamp.now();
    if (iniciou == false) {
      final diferenca = tempoAtual
          .toDate()
          .toLocal()
          .difference(tarefa.acao.atualizadaEm.toDate().toLocal());
      tarefa = tarefa.copyWith(
        acao: TarefaAcao(
          emAndamento: iniciou,
          atualizadaEm: tempoAtual,
        ),
        tempo: tarefa.tempo + (diferenca.inSeconds),
      );
    } else {
      tarefa = tarefa.copyWith(
        acao: TarefaAcao(
          emAndamento: iniciou,
          atualizadaEm: tempoAtual,
        ),
      );
    }
    return _tarefasCollection().doc(tarefa.id).set(tarefa.toJson());
  }
  
}
