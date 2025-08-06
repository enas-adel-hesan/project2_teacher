
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';


class PreferencesService {
  final SharedPreferences _prefs;

  // Constructor that requires SharedPreferences
  PreferencesService(this._prefs);


  // حفظ بيانات المستخدم
   Future<void> saveUserData(UserModel userModel) async {
    await Future.wait([
      _prefs.setString('token', userModel.data!.token!),
      _prefs.setInt('id', userModel.data!.user!.id!),
      _prefs.setString('name', userModel.data!.user!.name!),
    ]);
  }

  // جلب التوكن
   String? get token => _prefs.getString('token');

  // جلب معرف المستخدم
   int? get userId => _prefs.getInt('id');

  // جلب اسم المستخدم
   String? get userName => _prefs.getString('name');

  // التحقق من وجود مستخدم مسجل
   bool get isLoggedIn => _prefs.getString('token') != null;

  // حذف جميع البيانات
   Future<void> clearAllData() async {
    await _prefs.clear();
  }

  // طريقة مختصرة للحفظ
   Future<void> setValue<T>(String key, T value) async {
    switch (T) {
      case const (String):
        await _prefs.setString(key, value as String);
      case const (int):
        await _prefs.setInt(key, value as int);
      case const (bool):
        await _prefs.setBool(key, value as bool);
      case const (double):
        await _prefs.setDouble(key, value as double);
      case const (List<String>):
        await _prefs.setStringList(key, value as List<String>);
      default:
        throw Exception('Unsupported type');
    }
  }

  // طريقة مختصرة للجلب
   T? getValue<T>(String key) {
    switch (T) {
      case const (String):
        return _prefs.getString(key) as T?;
      case const (int):
        return _prefs.getInt(key) as T?;
      case const (bool):
        return _prefs.getBool(key) as T?;
      case const (double):
        return _prefs.getDouble(key) as T?;
      case const (List<String>):
        return _prefs.getStringList(key) as T?;
      default:
        throw Exception('Unsupported type');
    }
  }
}