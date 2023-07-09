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
        .map((items) => items.where((item) => (FunMostra(item))))
        .map((items) => items.toList()
          ..sort((a, b) => (a.tempo * (((pow(1.08, a.prioridade)) - 1.08) + 1))
              .compareTo(b.tempo * (((pow(1.08, b.prioridade)) - 1.08) + 1))));
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

  // ignore: non_constant_identifier_names
  static bool FunMostra(Tarefa item) {
    if (item.habilitado == false) {
      return false;
    } else {
      var now = DateTime.now();
      int dia = now.weekday;
      bool ret = false;
      switch (dia) {
        case 6:
          ret = item.sabado;
          break;
        case 7:
          ret = item.domingo;
          break;
        default:
          ret = item.diaSemana;
      }
      if (ret) {
        int tH = now.hour * 60 + now.minute;
        if (item.hrIn != null) {
          if (item.hrIn! > 0) {
            int ti = item.hrIn as int;
            if (ti > tH) ret = false;
          }
        }
        if (item.hrFn != null) {
          if (item.hrFn! > 0) {
            int tf = item.hrFn as int;
            if (tf < tH) ret = false;
          }
        }
      }
      return ret;
    }
  }
}
