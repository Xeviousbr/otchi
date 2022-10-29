import 'dart:convert';

import 'package:http/http.dart' as http;
import 'tarefa.dart';

class API {
  static Future Cadastra(Tarefa tar) async {
    String? dados =
        "idUsuario=${tar.idUser}&Nome=${tar.Nome}&Prioridade=${tar.Prioridade}&HoraLim=${tar.Hora}&HabDiaSem=${tar.HabDiaSem}&HabSab=${tar.HabDom}&HabDom=${tar.HabDom}&Habilitado=${tar.Habilitado}";
    String? baseUrl = "https://tele-tudo.com/ot?op=2&" + dados;
    print(baseUrl);
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future VeLogin(email, password) async {
    String baseUrl =
        "https://tele-tudo.com/ot?op=1&user=${email}&pass=${password}";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future<Iterable<TarLista>> ListaTarefas(String id) async {
    final url = "https://tele-tudo.com/ot?op=3&idUsuario=$id";
    final response = await http.get(Uri.parse(url));
    final tarefas = jsonDecode(response.body) as List<dynamic>;
    return tarefas.map((data) => TarLista.fromJson(data));
  }
}

class TarLista {
  const TarLista({
    required this.id,
    required this.texto,
  });
  final String id;
  final String texto;

  factory TarLista.fromJson(Map<String, dynamic> data) {
    return TarLista(
      id: data['id'],
      texto: data['texto'],
    );
  }
}
