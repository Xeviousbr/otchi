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
  });
  final bool emAndamento;
  final Timestamp atualizadaEm;

  factory TarefaAcao.inicial() => TarefaAcao(
        emAndamento: false,
        atualizadaEm: Timestamp.now(),
      );

  factory TarefaAcao.fromJson(Map<String, dynamic> data) {
    return TarefaAcao(
      emAndamento: data['emAndamento'],
      atualizadaEm: data['atualizadaEm'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'emAndamento': emAndamento,
      'atualizadaEm': atualizadaEm,
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
    );
  }
}

class Tarefa {
  final String id;
  final String nome;
  final int prioridade;
  final bool sabado;
  final bool domingo;
  final bool diaSemana;
  final bool habilitado;
  final TarefaAcao acao;
  final int tempo;
  final bool rascunho;

  Tarefa({
    required this.id,
    required this.nome,
    required this.prioridade,
    required this.habilitado,
    required this.sabado,
    required this.domingo,
    required this.diaSemana,
    required this.acao,
    required this.tempo,
    this.rascunho = false,
  });

  factory Tarefa.fromJson(Map<String, dynamic> data) {
    final dias = (data['diasSemanaHabilitado'] as List<dynamic>?)?.whereType<int>() ?? [];
    final diaSemana = dias.map((e) => e - 1).map(DiasHabilitado.values.elementAt);
    return Tarefa(
      id: data['id'],
      nome: data['nome'],
      tempo: data['tempo'],
      prioridade: data['prioridade'] as int,
      habilitado: data['habilitado'] as bool,
      sabado: diaSemana.contains(DiasHabilitado.sab),
      domingo: diaSemana.contains(DiasHabilitado.dom),
      diaSemana: diaSemana.where(diasSemana.contains).isNotEmpty,
      acao: TarefaAcao.fromJson(data['acao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'prioridade': prioridade,
      'tempo': tempo,
      'habilitado': habilitado,
      'diasSemanaHabilitado': [
        if (sabado) 6,
        if (domingo) 7,
        if (diaSemana) ...[1, 2, 3, 4, 5],
      ],
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
    int? tempo,
    bool? sabado,
    bool? domingo,
    bool? diaSemana,
  }) {
    return Tarefa(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      prioridade: prioridade ?? this.prioridade,
      habilitado: habilitado ?? this.habilitado,
      sabado: sabado ?? this.sabado,
      domingo: domingo ?? this.domingo,
      diaSemana: diaSemana ?? this.diaSemana,
      acao: acao ?? this.acao,
      tempo: tempo ?? this.tempo,
      rascunho: rascunho,
    );
  }
}
