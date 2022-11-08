import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ot/sharedPreferencePage.dart';
import 'tarefa.dart';
import 'tarLista.dart';

class API {
  static Future cadastra(Tarefa tar) async {
    final dados =
        "idUsuario=${tar.idUser}&Nome=${tar.nome}&Prioridade=${tar.prioridade}&HoraLim=${tar.hora}&HabDiaSem=${tar.habDiaSem}&HabSab=${tar.habDom}&HabDom=${tar.habDom}&Habilitado=${tar.habilitado}";
    String? baseUrl = "https://tele-tudo.com/ot?op=2&$dados";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future veLogin(String email, String password) async {
    String baseUrl = "https://tele-tudo.com/ot?op=1&user=$email&pass=$password";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future<Iterable<TarLista>> listaTarefas() async {
    final userId = await SharedPrefUtils.readId();
    if (userId == null) {
      return [];
    }
    final url = 'https://tele-tudo.com/ot?op=3&idUsuario=$userId';
    final response = await http.get(Uri.parse(url));
    final tarefas = jsonDecode(response.body) as List<dynamic>;
    return tarefas.map((data) => TarLista.fromJson(data));
    // JSon fake criado pelo Cristian
    // final url = 'https://635d4a9fcb6cf98e56b197ad.mockapi.io/tarefas';
  }

  static Future deleta(String id) async {
    String baseUrl = "https://tele-tudo.com/ot?op=4&id=$id";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future inicio(String id) async {
    String baseUrl = "https://tele-tudo.com/ot?op=5&id=$id";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }
}
