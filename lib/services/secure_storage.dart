import 'dart:async';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sca_app/models/storage_item.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(
        key: newItem.key,
        value: newItem.value,
        aOptions: _getAndroidOptions()
    );
    log("StorageService - writeSecureData");
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true
  );

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    log("StorageService - readSecureData: $readData");
    return readData;
  }

  Future<void> deleteSecureData(StorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: _getAndroidOptions());
    log("StorageService - deleteSecureData");
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(key: key, aOptions: _getAndroidOptions());
    log("StorageService - containsKeyInSecureData: $containsKey");
    return containsKey;
  }

  Future<List<StorageItem>> readAllSecureData() async {
    var allData = await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list = allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    log("StorageService - readAllSecureData: $list");
    return list;
  }

  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
    log("StorageService - deleteAllSecureData");
  }
}