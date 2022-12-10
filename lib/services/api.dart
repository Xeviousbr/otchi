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
    final referencia = _tarefasCollection().withConverter<Tarefa>(
      fromFirestore: (snapshots, _) => Tarefa.fromJson(
        {
          ...snapshots.data()!,
          'id': snapshots.id,
        },
      ),
      toFirestore: (tarefa, _) => tarefa.toJson(),
    )
      ..orderBy('prioridade')
      ..orderBy('tempo', descending: true).snapshots().map((event) => event.docs.map((doc) => doc.data())).map(
        (tarefas) {
          if (tarefas.isEmpty) return tarefas;
          // faz teu algoritmo aqui e retorna
          // vou colocar um exemplo

          final List<Tarefa> listaOrdenada = [];
          for (var i = 0; i < tarefas.length; i++) {
            final tarefaAtual = tarefas.elementAt(i);
            listaOrdenada.add(tarefaAtual);
          }
          return listaOrdenada;
        },
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

  static Future deleta(String id) async {
    return _tarefasCollection().doc(id).delete();
  }

  static Future<void> acaoTarefa(Tarefa tarefa, bool iniciou) {
    final tempoAtual = Timestamp.now();
    final diferenca = tempoAtual.toDate().toLocal().difference(tarefa.acao.atualizadaEm.toDate().toLocal());
    tarefa = tarefa.copyWith(
      acao: TarefaAcao(
        emAndamento: iniciou,
        atualizadaEm: tempoAtual,
      ),
      tempo: tarefa.tempo + (diferenca.inSeconds),
    );
    return _tarefasCollection().doc(tarefa.id).set(tarefa.toJson());
  }
}
