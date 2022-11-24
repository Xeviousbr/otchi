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
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await _tarefasCollection().add(
      {
        ...data,
        'userId': userId,
      },
    );
  }

  static Future<void> edita(Tarefa tarefa) async {
    final data = tarefa.toJson();
    data.remove('id');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await _tarefasCollection().doc(tarefa.id).set(
      {
        ...data,
        'userId': userId,
      },
    );
  }

  static Stream<Iterable<Tarefa>> listaTarefas() {
    final referencia = _tarefasCollection().withConverter<Tarefa>(
      fromFirestore: (snapshots, _) => Tarefa.fromJson(
        {
          ...snapshots.data()!,
          'id': snapshots.id,
        },
      ),
      toFirestore: (tarefa, _) => tarefa.toJson(),
    );
    return referencia.snapshots().map((event) => event.docs.map((doc) => doc.data()));
  }

  static Future deleta(String id) async {
    return _tarefasCollection().doc(id).delete();
  }

  static Future<void> acaoTarefa(String id, bool iniciou) {
    return _tarefasCollection()
        .doc(id)
        .collection('historico')
        .add(TarefaHistorico(date: DateTime.now(), iniciou: iniciou).toJson());
  }
}
