import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/tar_lista.dart';
import '../models/tarefa.dart';
import 'shared_reference_page.dart';

class API {
  static Future cadastra(Tarefa tar) async {
    final dados =
        "idUsuario=${tar.idUser}&Nome=${tar.nome}&Prioridade=${tar.prioridade}&HoraLim=${tar.hora}&HabDiaSem=${tar.habDiaSem}&HabSab=${tar.habDom}&HabDom=${tar.habDom}&Habilitado=${tar.habilitado}";
    String? baseUrl = "https://tele-tudo.com/ot?op=2&$dados";
    print(baseUrl);
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future<bool> veLogin(String email, String password) async {
    String baseUrl = "https://tele-tudo.com/ot?op=1&user=$email&pass=$password";
    var url = baseUrl;
    final response = await http.get(Uri.parse(url));
    var ret = json.decode(response.body);
    final int? idUser = (ret["ID"]);
    if (ret['OK'] == 1 && idUser != null) {
      final prefer = await SharedPreferences.getInstance();
      await prefer.setInt('ID', idUser);
      return true;
    }
    return false;
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

  static Future fim(String id) async {
    String baseUrl = "https://tele-tudo.com/ot?op=6&id=$id";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future<bool> cadastraUser(String user, String pass) async {
    String baseUrl = "https://tele-tudo.com/ot?op=7&user=$user&pass=$pass";
    var url = baseUrl;

    final response = await http.get(Uri.parse(url));
    var ret = json.decode(response.body);
    if (ret['OK'] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
