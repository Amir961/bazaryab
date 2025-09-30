import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class SharedPrefService {
  final SharedPreferences _prefs;

  SharedPrefService(this._prefs);

  /// ذخیره رشته
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      log('SharedPref setString error: $e');
      return false;
    }
  }

  /// خواندن رشته
  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      log('SharedPref getString error: $e');
      return null;
    }
  }

  /// ذخیره عدد صحیح
  Future<bool> setInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      log('SharedPref setInt error: $e');
      return false;
    }
  }

  /// خواندن عدد صحیح
  int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      log('SharedPref getInt error: $e');
      return null;
    }
  }

  /// ذخیره بولین
  Future<bool> setBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      log('SharedPref setBool error: $e');
      return false;
    }
  }

  /// خواندن بولین
  bool? getBool(String key) {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      log('SharedPref getBool error: $e');
      return null;
    }
  }

  /// ذخیره لیست رشته
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      log('SharedPref setStringList error: $e');
      return false;
    }
  }

  /// خواندن لیست رشته
  List<String>? getStringList(String key) {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      log('SharedPref getStringList error: $e');
      return null;
    }
  }

  /// ذخیره Map یا Object به صورت JSON
  Future<bool> setObject(String key, dynamic value) async {
    try {
      final jsonStr = jsonEncode(value);
      return await _prefs.setString(key, jsonStr);
    } catch (e) {
      log('SharedPref setObject error: $e');
      return false;
    }
  }

  /// خواندن Map یا Object از JSON
  T? getObject<T>(String key, T Function(Map<String, dynamic>) decoder) {
    try {
      final jsonStr = _prefs.getString(key);
      if (jsonStr == null) return null;
      final Map<String, dynamic> map = jsonDecode(jsonStr);
      return decoder(map);
    } catch (e) {
      log('SharedPref getObject error: $e');
      return null;
    }
  }

  /// حذف یک کلید
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      log('SharedPref remove error: $e');
      return false;
    }
  }

  /// پاک کردن تمام داده‌ها
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      log('SharedPref clear error: $e');
      return false;
    }
  }
}
