import 'package:http/http.dart' as http;

class API {
  static Future getMovie(search) async {
    String baseUrl = "https://tele-tudo.com";
    // var url = baseUrl + search;
    var url = baseUrl;
    return await http.get(Uri.parse(url));
  }
}
