// core/utils/storage_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../error/exceptions.dart';
import '../utils/log_service.dart';

class StorageService {
  static StorageService? _instance;
  static StorageService get instance => _instance ??= StorageService._();
  StorageService._();

  late SharedPreferences _prefs;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialize storage service
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
      LogService.i('StorageService initialized successfully');
    } catch (e) {
      LogService.e('Failed to initialize StorageService: $e');
      throw StorageException(
        message: 'Failed to initialize storage service',
        originalError: e,
      );
    }
  }

  // Ensure initialization
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StorageException(
        message: 'StorageService is not initialized. Call initialize() first.',
      );
    }
  }

  // String operations
  Future<bool> setString(String key, String value) async {
    try {
      _ensureInitialized();
      final result = await _prefs.setString(key, value);
      LogService.d('Storage: Set string [$key] = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to set string [$key]: $e');
      throw StorageException(
        message: 'Failed to save string data',
        originalError: e,
      );
    }
  }

  String? getString(String key, [String? defaultValue]) {
    try {
      _ensureInitialized();
      final value = _prefs.getString(key) ?? defaultValue;
      LogService.d('Storage: Get string [$key] = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get string [$key]: $e');
      return defaultValue;
    }
  }

  // Integer operations
  Future<bool> setInt(String key, int value) async {
    try {
      _ensureInitialized();
      final result = await _prefs.setInt(key, value);
      LogService.d('Storage: Set int [$key] = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to set int [$key]: $e');
      throw StorageException(
        message: 'Failed to save integer data',
        originalError: e,
      );
    }
  }

  int? getInt(String key, [int? defaultValue]) {
    try {
      _ensureInitialized();
      final value = _prefs.getInt(key) ?? defaultValue;
      LogService.d('Storage: Get int [$key] = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get int [$key]: $e');
      return defaultValue;
    }
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    try {
      _ensureInitialized();
      final result = await _prefs.setDouble(key, value);
      LogService.d('Storage: Set double [$key] = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to set double [$key]: $e');
      throw StorageException(
        message: 'Failed to save double data',
        originalError: e,
      );
    }
  }

  double? getDouble(String key, [double? defaultValue]) {
    try {
      _ensureInitialized();
      final value = _prefs.getDouble(key) ?? defaultValue;
      LogService.d('Storage: Get double [$key] = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get double [$key]: $e');
      return defaultValue;
    }
  }

  // Boolean operations
  Future<bool> setBool(String key, bool value) async {
    try {
      _ensureInitialized();
      final result = await _prefs.setBool(key, value);
      LogService.d('Storage: Set bool [$key] = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to set bool [$key]: $e');
      throw StorageException(
        message: 'Failed to save boolean data',
        originalError: e,
      );
    }
  }

  bool? getBool(String key, [bool? defaultValue]) {
    try {
      _ensureInitialized();
      final value = _prefs.getBool(key) ?? defaultValue;
      LogService.d('Storage: Get bool [$key] = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get bool [$key]: $e');
      return defaultValue;
    }
  }

  // String List operations
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      _ensureInitialized();
      final result = await _prefs.setStringList(key, value);
      LogService.d('Storage: Set string list [$key] = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to set string list [$key]: $e');
      throw StorageException(
        message: 'Failed to save string list data',
        originalError: e,
      );
    }
  }

  List<String>? getStringList(String key, [List<String>? defaultValue]) {
    try {
      _ensureInitialized();
      final value = _prefs.getStringList(key) ?? defaultValue;
      LogService.d('Storage: Get string list [$key] = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get string list [$key]: $e');
      return defaultValue;
    }
  }

  // JSON operations (for complex objects)
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    try {
      _ensureInitialized();
      final jsonString = jsonEncode(value);
      final result = await _prefs.setString(key, jsonString);
      LogService.d('Storage: Set JSON [$key] = $value');
      return result;
    } catch (e) {
      LogService.e('Failed to set JSON [$key]: $e');
      throw StorageException(
        message: 'Failed to save JSON data',
        originalError: e,
      );
    }
  }

  Map<String, dynamic>? getJson(
    String key, [
    Map<String, dynamic>? defaultValue,
  ]) {
    try {
      _ensureInitialized();
      final jsonString = _prefs.getString(key);
      if (jsonString == null) return defaultValue;

      final value = jsonDecode(jsonString) as Map<String, dynamic>;
      LogService.d('Storage: Get JSON [$key] = $value');
      return value;
    } catch (e) {
      LogService.e('Failed to get JSON [$key]: $e');
      return defaultValue;
    }
  }

  // Object operations (with serialization)
  Future<bool> setObject<T>(
    String key,
    T object,
    Map<String, dynamic> Function(T) toJson,
  ) async {
    try {
      _ensureInitialized();
      final jsonMap = toJson(object);
      return await setJson(key, jsonMap);
    } catch (e) {
      LogService.e('Failed to set object [$key]: $e');
      throw StorageException(
        message: 'Failed to save object data',
        originalError: e,
      );
    }
  }

  T? getObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson, [
    T? defaultValue,
  ]) {
    try {
      _ensureInitialized();
      final jsonMap = getJson(key);
      if (jsonMap == null) return defaultValue;

      final object = fromJson(jsonMap);
      LogService.d('Storage: Get object [$key] = $object');
      return object;
    } catch (e) {
      LogService.e('Failed to get object [$key]: $e');
      return defaultValue;
    }
  }

  // List of objects operations
  Future<bool> setObjectList<T>(
    String key,
    List<T> objects,
    Map<String, dynamic> Function(T) toJson,
  ) async {
    try {
      _ensureInitialized();
      final jsonList = objects.map((obj) => toJson(obj)).toList();
      final jsonString = jsonEncode(jsonList);
      final result = await _prefs.setString(key, jsonString);
      LogService.d(
        'Storage: Set object list [$key] with ${objects.length} items',
      );
      return result;
    } catch (e) {
      LogService.e('Failed to set object list [$key]: $e');
      throw StorageException(
        message: 'Failed to save object list data',
        originalError: e,
      );
    }
  }

  List<T>? getObjectList<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson, [
    List<T>? defaultValue,
  ]) {
    try {
      _ensureInitialized();
      final jsonString = _prefs.getString(key);
      if (jsonString == null) return defaultValue;

      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      final objects = jsonList
          .cast<Map<String, dynamic>>()
          .map((json) => fromJson(json))
          .toList();

      LogService.d(
        'Storage: Get object list [$key] with ${objects.length} items',
      );
      return objects;
    } catch (e) {
      LogService.e('Failed to get object list [$key]: $e');
      return defaultValue;
    }
  }

  // Check operations
  bool containsKey(String key) {
    try {
      _ensureInitialized();
      final exists = _prefs.containsKey(key);
      LogService.d('Storage: Contains key [$key] = $exists');
      return exists;
    } catch (e) {
      LogService.e('Failed to check key [$key]: $e');
      return false;
    }
  }

  // Remove operations
  Future<bool> remove(String key) async {
    try {
      _ensureInitialized();
      final result = await _prefs.remove(key);
      LogService.d('Storage: Removed key [$key]');
      return result;
    } catch (e) {
      LogService.e('Failed to remove key [$key]: $e');
      throw StorageException(
        message: 'Failed to remove data',
        originalError: e,
      );
    }
  }

  Future<bool> removeAll(List<String> keys) async {
    try {
      _ensureInitialized();
      bool allSuccess = true;
      for (final key in keys) {
        final success = await remove(key);
        if (!success) allSuccess = false;
      }
      LogService.d('Storage: Removed ${keys.length} keys');
      return allSuccess;
    } catch (e) {
      LogService.e('Failed to remove multiple keys: $e');
      throw StorageException(
        message: 'Failed to remove multiple data items',
        originalError: e,
      );
    }
  }

  // Clear all data
  Future<bool> clear() async {
    try {
      _ensureInitialized();
      final result = await _prefs.clear();
      LogService.d('Storage: Cleared all data');
      return result;
    } catch (e) {
      LogService.e('Failed to clear storage: $e');
      throw StorageException(
        message: 'Failed to clear storage',
        originalError: e,
      );
    }
  }

  // Get all keys
  Set<String> getAllKeys() {
    try {
      _ensureInitialized();
      final keys = _prefs.getKeys();
      LogService.d('Storage: Got ${keys.length} keys');
      return keys;
    } catch (e) {
      LogService.e('Failed to get all keys: $e');
      return <String>{};
    }
  }

  // Reload from disk
  Future<void> reload() async {
    try {
      _ensureInitialized();
      await _prefs.reload();
      LogService.d('Storage: Reloaded from disk');
    } catch (e) {
      LogService.e('Failed to reload storage: $e');
      throw StorageException(
        message: 'Failed to reload storage',
        originalError: e,
      );
    }
  }

  // App-specific convenience methods

  // User session
  Future<bool> setUserToken(String token) => setString('user_token', token);
  String? getUserToken() => getString('user_token');
  Future<bool> removeUserToken() => remove('user_token');

  Future<bool> setUserId(String userId) => setString('user_id', userId);
  String? getUserId() => getString('user_id');
  Future<bool> removeUserId() => remove('user_id');

  Future<bool> setUserRole(String role) => setString('user_role', role);
  String? getUserRole() => getString('user_role');
  Future<bool> removeUserRole() => remove('user_role');

  // App settings
  Future<bool> setLanguage(String language) => setString('language', language);
  String? getLanguage() => getString('language');

  Future<bool> setTheme(String theme) => setString('theme', theme);
  String? getTheme() => getString('theme');

  Future<bool> setNotificationsEnabled(bool enabled) =>
      setBool('notifications_enabled', enabled);
  bool? getNotificationsEnabled() => getBool('notifications_enabled');

  Future<bool> setBiometricEnabled(bool enabled) =>
      setBool('biometric_enabled', enabled);
  bool? getBiometricEnabled() => getBool('biometric_enabled');

  Future<bool> setAutoLogin(bool enabled) => setBool('auto_login', enabled);
  bool? getAutoLogin() => getBool('auto_login');

  Future<bool> setRememberMe(bool enabled) => setBool('remember_me', enabled);
  bool? getRememberMe() => getBool('remember_me');

  // First run
  Future<bool> setFirstRun(bool isFirstRun) => setBool('first_run', isFirstRun);
  bool? isFirstRun() => getBool('first_run', true);

  // FCM Token
  Future<bool> setFcmToken(String token) => setString('fcm_token', token);
  String? getFcmToken() => getString('fcm_token');
  Future<bool> removeFcmToken() => remove('fcm_token');

  // Cache timestamps for data invalidation
  Future<bool> setCacheTimestamp(String key, DateTime timestamp) {
    return setString('${key}_timestamp', timestamp.toIso8601String());
  }

  DateTime? getCacheTimestamp(String key) {
    final timestampString = getString('${key}_timestamp');
    if (timestampString == null) return null;
    return DateTime.tryParse(timestampString);
  }

  bool isCacheValid(String key, Duration validDuration) {
    final timestamp = getCacheTimestamp(key);
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) <= validDuration;
  }

  Future<bool> invalidateCache(String key) {
    return removeAll(['${key}_timestamp', key]);
  }

  // Search history
  Future<bool> addSearchHistory(String query) async {
    final history = getStringList('search_history', []) ?? [];
    history.remove(query); // Remove if exists to avoid duplicates
    history.insert(0, query); // Add to beginning

    // Keep only last 20 searches
    if (history.length > 20) {
      history.removeRange(20, history.length);
    }

    return setStringList('search_history', history);
  }

  List<String> getSearchHistory() {
    return getStringList('search_history', []) ?? [];
  }

  Future<bool> clearSearchHistory() => remove('search_history');

  // Onboarding
  Future<bool> setOnboardingCompleted(bool completed) =>
      setBool('onboarding_completed', completed);
  bool? isOnboardingCompleted() => getBool('onboarding_completed', false);

  // Filter preferences
  Future<bool> setFilterPreferences(Map<String, dynamic> filters) =>
      setJson('filter_preferences', filters);
  Map<String, dynamic>? getFilterPreferences() => getJson('filter_preferences');

  // Logout and clear user data
  Future<void> logout() async {
    await removeAll([
      'user_token',
      'user_id',
      'user_role',
      'fcm_token',
      'auto_login',
      'biometric_enabled',
    ]);
    LogService.i('Storage: User data cleared after logout');
  }

  // Debug methods
  void printAllData() {
    if (!_isInitialized) return;

    final keys = getAllKeys();
    LogService.d('Storage: All data (${keys.length} items):');
    for (final key in keys) {
      final value = _prefs.get(key);
      LogService.d('  $key: $value');
    }
  }

  Map<String, dynamic> getAllData() {
    if (!_isInitialized) return {};

    final keys = getAllKeys();
    final data = <String, dynamic>{};

    for (final key in keys) {
      data[key] = _prefs.get(key);
    }

    return data;
  }

  // Backup and restore (for migration purposes)
  Map<String, dynamic> exportData() {
    return getAllData();
  }

  Future<void> importData(Map<String, dynamic> data) async {
    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is String) {
        await setString(key, value);
      } else if (value is int) {
        await setInt(key, value);
      } else if (value is double) {
        await setDouble(key, value);
      } else if (value is bool) {
        await setBool(key, value);
      } else if (value is List<String>) {
        await setStringList(key, value);
      }
    }
    LogService.i('Storage: Imported ${data.length} items');
  }
}
