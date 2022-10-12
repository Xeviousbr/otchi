import 'package:http/http.dart' as http;
import 'tarefa.dart';

class API {
  static Future Cadastra(Tarefa tar) async {
    // NÃO TESTEI DEPOIS QUE PASSOU A DAR AQUELE ERRO Error: XMLHttpRequest error.
    print("Entrou em Cadastra");
    String? dados =
        "idUsuario=1&Nome=${tar.Nome}&Prioridade=${tar.Prioridade}&HoraLim=${tar.Hora}&HabDiaSem=${tar.HabDiaSem}&HabSab=${tar.HabDom}&HabDom=${tar.HabDom}&Habilitado=${tar.Habilitado}";
    String? baseUrl = "https://tele-tudo.com?op=2&" + dados;
    print(baseUrl);
    var url = baseUrl;
    print("Antes de return await http.get(Uri.parse(url))");
    return await http.get(Uri.parse(url));
  }

  static Future VeLogin(email, password) async {
    String baseUrl =
        "https://tele-tudo.com/ot?op=1&user=" + email + "&pass=" + password;
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }
}
