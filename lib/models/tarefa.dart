import 'package:cloud_firestore/cloud_firestore.dart';

enum DiasHabilitado { seg, ter, qua, qui, sex, sab, dom }

final finalDeSemana = DiasHabilitado.values.reversed.take(2);
final diasSemana = DiasHabilitado.values.take(5);

class TarefaHistorico {
  TarefaHistorico({
    required this.date,
    required this.iniciou,
  });
  final DateTime date;
  final bool iniciou;

  factory TarefaHistorico.fromJson(Map<String, dynamic> data) {
    return TarefaHistorico(
      iniciou: data['iniciou'],
      date: data['date'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'iniciou': iniciou,
      'date': date,
    };
  }
}

class TarefaAcao {
  TarefaAcao({
    required this.emAndamento,
    required this.atualizadaEm,
    required this.tempo,
  });
  final bool emAndamento;
  final Timestamp atualizadaEm;
  final int tempo;

  factory TarefaAcao.fromJson(Map<String, dynamic> data) {
    return TarefaAcao(
      emAndamento: data['emAndamento'],
      atualizadaEm: data['atualizadaEm'],
      tempo: data['tempo'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'emAndamento': emAndamento,
      'atualizadaEm': atualizadaEm,
      'tempo': tempo,
    };
  }

  TarefaAcao copyWith({
    bool? emAndamento,
    Timestamp? atualizadaEm,
    int? tempo,
  }) {
    return TarefaAcao(
      emAndamento: emAndamento ?? this.emAndamento,
      atualizadaEm: atualizadaEm ?? this.atualizadaEm,
      tempo: tempo ?? this.tempo,
    );
  }
}

class Tarefa {
  final String id;
  final String nome;
  final int prioridade;
  final Iterable<DiasHabilitado> diasSemanaHabilitado;
  final bool habilitado;
  final TarefaAcao acao;

  Tarefa({
    required this.id,
    required this.nome,
    required this.prioridade,
    required this.diasSemanaHabilitado,
    required this.habilitado,
    required this.acao,
  });

  factory Tarefa.fromJson(Map<String, dynamic> data) {
    final dias = (data['diasSemanaHabilitado'] as List<dynamic>?)?.whereType<int>() ?? [];
    return Tarefa(
      id: data['id'],
      nome: data['nome'],
      prioridade: data['prioridade'] as int,
      habilitado: data['habilitado'] as bool,
      diasSemanaHabilitado: dias.map(DiasHabilitado.values.elementAt),
      acao: TarefaAcao.fromJson(data['acao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'prioridade': prioridade,
      'habilitado': habilitado,
      'diasSemanaHabilitado': diasSemanaHabilitado.map((dia) => DiasHabilitado.values.indexOf(dia) + 1),
      'acao': acao.toJson(),
    };
  }

  Tarefa copyWith({
    String? id,
    String? nome,
    int? prioridade,
    Iterable<DiasHabilitado>? diasSemanaHabilitado,
    bool? habilitado,
    TarefaAcao? acao,
  }) {
    return Tarefa(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      prioridade: prioridade ?? this.prioridade,
      diasSemanaHabilitado: diasSemanaHabilitado ?? this.diasSemanaHabilitado,
      habilitado: habilitado ?? this.habilitado,
      acao: acao ?? this.acao,
    );
  }
}
