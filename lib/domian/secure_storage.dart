import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<void> writeSecureToken(String jwt, String value) async {
    await storage.write(key: jwt, value: value);


  }


  Future<String?> readSecureToken(String jwt) async {
    return await storage.read(key: jwt);
  }


  Future<void> deleteSecureToken(String jwt) async {
    await storage.delete(key: jwt);
  }
}
