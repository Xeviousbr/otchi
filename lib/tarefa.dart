class Tarefa {
  final int? id;
  final int idUser;
  final String nome;
  final int prioridade;
  final String? hora;
  final bool habDiaSem;
  final bool hamSab;
  final bool habDom;
  final bool habilitado;

  Tarefa({
    required this.idUser,
    required this.nome,
    required this.prioridade,
    this.hora,
    this.id,
    required this.habDiaSem,
    required this.hamSab,
    required this.habDom,
    required this.habilitado,
  });

  factory Tarefa.fromJson(Map<String, dynamic> data) {
    return Tarefa(
      id: data['id'] as int,
      nome: data['nome'],
      habDiaSem: data['habDiaSem'] as bool,
      habDom: data['habDom'] as bool,
      habilitado: data['habilitado'] as bool,
      hamSab: data['hamSab'] as bool,
      idUser: data['idUser'],
      prioridade: data['prioridade'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'habDiaSem': habDiaSem,
      'habDom': habDom,
      'habilitado': habilitado,
      'hamSab': hamSab,
      'idUser': idUser,
      'prioridade': prioridade,
    };
  }
}

bool _converteParaBool(int data) {
  return data == 1 ? true : false;
}
