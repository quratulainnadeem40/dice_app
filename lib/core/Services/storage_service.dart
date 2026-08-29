import 'dart:convert';

import 'package:get/get.dart';

import 'package:dart:convert';

class StorageService extends GetxService {
  late final GetStorage _storage;

  @override
  Future<void> onInit() async {
    super.onInit();
    await GetStorage.init();
    _storage = GetStorage();
  }

  // Generic methods
  Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  Future<void> erase() async {
    await _storage.erase();
  }

  bool hasData(String key) {
    return _storage.hasData(key);
  }

  // String methods
  Future<void> writeString(String key, String value) async {
    await _storage.write(key, value);
  }

  String? readString(String key) {
    return _storage.read<String>(key);
  }

  // Integer methods
  Future<void> writeInt(String key, int value) async {
    await _storage.write(key, value);
  }

  int? readInt(String key) {
    return _storage.read<int>(key);
  }

  // Boolean methods
  Future<void> writeBool(String key, bool value) async {
    await _storage.write(key, value);
  }

  bool? readBool(String key) {
    return _storage.read<bool>(key);
  }

  // Double methods
  Future<void> writeDouble(String key, double value) async {
    await _storage.write(key, value);
  }

  double? readDouble(String key) {
    return _storage.read<double>(key);
  }

  // List methods
  Future<void> writeList(String key, List<dynamic> value) async {
    await _storage.write(key, value);
  }

  List<dynamic>? readList(String key) {
    return _storage.read<List<dynamic>>(key);
  }

  // Map methods
  Future<void> writeMap(String key, Map<String, dynamic> value) async {
    await _storage.write(key, value);
  }

  Map<String, dynamic>? readMap(String key) {
    return _storage.read<Map<String, dynamic>>(key);
  }

  // JSON methods
  Future<void> writeJson(String key, dynamic value) async {
    await _storage.write(key, jsonEncode(value));
  }

  dynamic readJson(String key) {
    String? data = _storage.read<String>(key);
    if (data == null) return null;
    return jsonDecode(data);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.erase();
  }

  // Get all keys
  List<String> getAllKeys() {
    return _storage.getKeys().cast<String>().toList();
  }
}