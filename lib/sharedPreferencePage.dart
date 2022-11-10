import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static Future<int?> readId() async {
    final prefer = await SharedPreferences.getInstance();
    return prefer.getInt('ID');
  }

  static readTarefEditID() async {
    final prefer = await SharedPreferences.getInstance();
    return prefer.getInt('TarefEditID');
  }

  /* static Future<int?> readTarefEditID() async {
    final prefer = await SharedPreferences.getInstance();
    return prefer.getInt('TarefEditID');
  } */
}
