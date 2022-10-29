import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static Future<int?> readId() async {
    final prefer = await SharedPreferences.getInstance();
    return prefer.getInt('ID');
  }
}
