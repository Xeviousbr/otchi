import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/tarefa.dart';

class API {
  static CollectionReference<Map<String, dynamic>> _tarefasCollection() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tarefas');
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
        .snapshots()
        .map((event) => event.docs.map((doc) => doc.data()))
        .map((items) => items.where((item) => (FunDiaSem(item.diaSemana))))
        .map((items) => items.where((item) => (FunSab(item.sabado))))
        .map((items) => items.where((item) => (FunDom(item.domingo))))
        .map((items) => items.where((item) => (item.habilitado == true)))
        .map((items) => items.toList()
          ..sort((a, b) => (a.tempo * (((pow(1.09, a.prioridade)) - 1.08) + 1))
              .compareTo(b.tempo * (((pow(1.09, b.prioridade)) - 1.08) + 1))));
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
      print("Tempo adicionado na tarefa " +
          tarefa.nome +
          " = " +
          diferenca.inSeconds.toString());
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

  static int dia = 0;
  static bool FunDiaSem(bool diasem) {
    var now = new DateTime.now();
    int dia = DateTime.now().weekday;
    if ((dia > 1) && (dia < 7)) {
      return diasem;
    }
    return false;
  }

  static bool FunSab(bool sabado) {
    if (dia == 7) {
      return sabado;
    }
    return true;
  }

  static bool FunDom(bool domingo) {
    if (dia == 1) {
      return domingo;
    }
    return true;
  }
}
