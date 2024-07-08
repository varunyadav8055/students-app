// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class info_clg {
  
  static String clg_name = '';
  static String clg_id = '';
  static int clg_buses = 0;
  
}

class SharedPrefService {
  Future writeCache({required key, required value}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool isSaved = await pref.setString(key, value);
    if (isSaved) {
      print("Saved"+"key" +key+"value"+value);
    } else {
      print("Not Saved\n");
      print("Saved"+"key" +key+"value"+value);
    }
  }
   Future<String> readCache({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? value = pref.getString(key);
    return value ?? '';
  }
}
