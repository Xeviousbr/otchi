import 'package:flutter/material.dart';

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

class Horario {
  Horario({
    required this.inicio,
    required this.duracao,
  });

  final TimeOfDay inicio;
  final int duracao;

  factory Horario.fromJson(Map<String, dynamic> data) {
    return Horario(
      inicio: data['inicio'],
      duracao: data['duracao'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'inicio': inicio.toString(),
      'duracao': duracao,
    };
  }
}

class Tarefa {
  final String id;
  final String nome;
  final int prioridade;
  final Iterable<Horario> horarios;
  final Iterable<DiasHabilitado> diasSemanaHabilitado;
  final bool habilitado;
  final int tempo;

  Tarefa({
    required this.id,
    required this.nome,
    required this.prioridade,
    required this.horarios,
    required this.habilitado,
    required this.diasSemanaHabilitado,
    required this.tempo,
  });

  factory Tarefa.fromJson(Map<String, dynamic> data) {
    final dias =
        (data['diasSemanaHabilitado'] as List<dynamic>).whereType<int>();
    final horarios =
        (data['horarios'] as List<dynamic>).whereType<Map<String, dynamic>>();
    return Tarefa(
      id: data['id'],
      nome: data['nome'],
      prioridade: data['prioridade'] as int,
      horarios: horarios.map(Horario.fromJson),
      habilitado: data['habilitado'] as bool,
      tempo: data['tempo'] as int,
      diasSemanaHabilitado: dias.map(DiasHabilitado.values.elementAt),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'prioridade': prioridade,
      'horarios': horarios,
      'habilitado': habilitado,
      'tempo': tempo,
      'diasSemanaHabilitado': diasSemanaHabilitado
          .map((dia) => DiasHabilitado.values.indexOf(dia) + 1),
    };
  }
}
