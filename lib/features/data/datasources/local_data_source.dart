import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  FlutterSecureStorage? secureStorage;
  SharedPreferences? prefs;

  LocalDataSource(
      {FlutterSecureStorage? securePreferences,
        SharedPreferences? sharedPreferences}) {
    secureStorage = securePreferences;
    prefs = sharedPreferences;
  }

  Future<bool> getBool(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? false;
  }

  Future<bool> setBool(String key, bool value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setBool(key, value);
  }

  Future<bool> setMap(String key, Map value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(key, jsonEncode(value));
  }

  Future<bool> deleteMap(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }

  Future<Map?> getMap(String key) async {
    final pref = await SharedPreferences.getInstance();
    String? value = pref.getString(key);
    if (value == null) {
      return null;
    }
    return jsonDecode(value);
  }

  Future<void> setSecreteString(String key, String value) async {
    await secureStorage?.write(key: key, value: value);
    return;
  }

  Future<String?> getSecreteString(String key) async {
    String? value = await secureStorage?.read(key: key);
    return value;
  }

  Future<void> deleteSecreteString(String key) async {
    await secureStorage?.delete(key: key);
    return;
  }
}
