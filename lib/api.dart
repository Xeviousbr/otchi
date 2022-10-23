import 'package:http/http.dart' as http;
import 'tarefa.dart';

class API {
  static Future Cadastra(Tarefa tar) async {
    String? dados =
        "idUsuario=${tar.idUser}&Nome=${tar.Nome}&Prioridade=${tar.Prioridade}&HoraLim=${tar.Hora}&HabDiaSem=${tar.HabDiaSem}&HabSab=${tar.HabDom}&HabDom=${tar.HabDom}&Habilitado=${tar.Habilitado}";
    String? baseUrl = "https://tele-tudo.com/ot?op=2&$dados";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future VeLogin(email, password) async {
    String baseUrl = "https://tele-tudo.com/ot?op=1&user=$email&pass=$password";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }

  static Future ListaTarefas(id) async {
    String baseUrl = "https://tele-tudo.com/ot?op=3&idUsuario=${id.toString()}";
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }
}
