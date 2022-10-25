import 'package:shared_preferences/shared_preferences.dart';
import 'package:ot/login_page/login_page.dart';
import 'api.dart';

class SharedPrefUtils {
  static readId () async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    return prefer.getInt('ID');
  }

   
}