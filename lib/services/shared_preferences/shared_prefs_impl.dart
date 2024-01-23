import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_app/services/shared_preferences/shared_prefs.dart';

class SharedPrefsImpl implements SharedPrefs {
    final SharedPreferences sharedPreferences;


  SharedPrefsImpl({required this.sharedPreferences});

  @override
  setData(String data) async {
    
    await sharedPreferences.setString('data', data);
  }

  @override
  String getData() {
    return sharedPreferences.getString('data') ?? '[]';
  }
}
