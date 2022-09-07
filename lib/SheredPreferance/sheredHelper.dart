import 'package:shared_preferences/shared_preferences.dart';

class sherdprefrence{
  static SharedPreferences? sharedpreferences;
  static init()async{
    sharedpreferences= await SharedPreferences.getInstance();
  }
  static Future<bool> setdate({
    required String key,
    required dynamic value,
  })async{
    if(value is bool)return await sharedpreferences!.setBool(key, value);
    if(value is int)return await sharedpreferences!.setInt(key, value);
    if(value is String)return await sharedpreferences!.setString(key, value);
    return await sharedpreferences!.setDouble(key, value);
  }
  static dynamic getdate({required String key}){
    return sharedpreferences!.get(key);
  }
  static Future<bool> removedate({required String key})async{
    return await sharedpreferences!.remove(key);
  }

}
