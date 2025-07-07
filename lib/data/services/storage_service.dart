import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/log_service.dart';
import '../../core/error/exceptions.dart';

class StorageService {
  static StorageService? _instance;
  static StorageService get instance => _instance ??= StorageService._();

  StorageService._();

  SharedPreferences? _prefs;

  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      LogService.i('StorageService initialized');
    } catch (e) {
      LogService.e('Failed to initialize StorageService', error: e);
      throw StorageException(
        message: 'Failed to initialize storage',
        originalError: e,
      );
    }
  }

  Future<SharedPreferences> get _preferences async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!;
  }

  // String operations
  Future<bool> saveString(String key, String value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setString(key, value);
      LogService.d('Saved string: $key');
      return result;
    } catch (e) {
      LogService.e('Failed to save string: $key', error: e);
      throw StorageException(
        message: 'Failed to save string value',
        originalError: e,
      );
    }
  }

  Future<String?> getString(String key) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getString(key);
      LogService.d('Retrieved string: $key');
      return value;
    } catch (e) {
      LogService.e('Failed to get string: $key', error: e);
      return null;
    }
  }

  // Boolean operations
  Future<bool> saveBool(String key, bool value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setBool(key, value);
      LogService.d('Saved bool: $key = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to save bool: $key', error: e);
      throw StorageException(
        message: 'Failed to save boolean value',
        originalError: e,
      );
    }
  }

  Future<bool?> getBool(String key) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getBool(key);
      LogService.d('Retrieved bool: $key = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get bool: $key', error: e);
      return null;
    }
  }

  // Integer operations
  Future<bool> saveInt(String key, int value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setInt(key, value);
      LogService.d('Saved int: $key = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to save int: $key', error: e);
      throw StorageException(
        message: 'Failed to save integer value',
        originalError: e,
      );
    }
  }

  Future<int?> getInt(String key) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getInt(key);
      LogService.d('Retrieved int: $key = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get int: $key', error: e);
      return null;
    }
  }

  // Double operations
  Future<bool> saveDouble(String key, double value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setDouble(key, value);
      LogService.d('Saved double: $key = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to save double: $key', error: e);
      throw StorageException(
        message: 'Failed to save double value',
        originalError: e,
      );
    }
  }

  Future<double?> getDouble(String key) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getDouble(key);
      LogService.d('Retrieved double: $key = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get double: $key', error: e);
      return null;
    }
  }

  // String list operations
  Future<bool> saveStringList(String key, List<String> value) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.setStringList(key, value);
      LogService.d('Saved string list: $key');
      return result;
    } catch (e) {
      LogService.e('Failed to save string list: $key', error: e);
      throw StorageException(
        message: 'Failed to save string list',
        originalError: e,
      );
    }
  }

  Future<List<String>?> getStringList(String key) async {
    try {
      final prefs = await _preferences;
      final value = prefs.getStringList(key);
      LogService.d('Retrieved string list: $key');
      return value;
    } catch (e) {
      LogService.e('Failed to get string list: $key', error: e);
      return null;
    }
  }

  // Remove operations
  Future<bool> remove(String key) async {
    try {
      final prefs = await _preferences;
      final result = await prefs.remove(key);
      LogService.d('Removed: $key');
      return result;
    } catch (e) {
      LogService.e('Failed to remove: $key', error: e);
      throw StorageException(
        message: 'Failed to remove value',
        originalError: e,
      );
    }
  }

  Future<bool> clear() async {
    try {
      final prefs = await _preferences;
      final result = await prefs.clear();
      LogService.d('Cleared all storage');
      return result;
    } catch (e) {
      LogService.e('Failed to clear storage', error: e);
      throw StorageException(
        message: 'Failed to clear storage',
        originalError: e,
      );
    }
  }

  // Check if key exists
  Future<bool> containsKey(String key) async {
    try {
      final prefs = await _preferences;
      return prefs.containsKey(key);
    } catch (e) {
      LogService.e('Failed to check key: $key', error: e);
      return false;
    }
  }

  // Get all keys
  Future<Set<String>> getAllKeys() async {
    try {
      final prefs = await _preferences;
      return prefs.getKeys();
    } catch (e) {
      LogService.e('Failed to get all keys', error: e);
      return <String>{};
    }
  }
}
