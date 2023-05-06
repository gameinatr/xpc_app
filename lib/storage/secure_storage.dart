import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future writeSecData(String key, String value) async {
    final writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  Future readSecData(String key) async {
    final readData = await _storage.read(key: key);
    return readData;
  }
}