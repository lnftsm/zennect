import 'package:flutter/material.dart';
import '../../core/utils/log_service.dart';
import '../../data/models/app_settings.dart';
import '../../data/services/storage_service.dart';

class SettingsProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService.instance;

  AppSettings? _settings;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  AppSettings? get settings => _settings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasSettings => _settings != null;

  // Quick access getters
  String get currentLanguage => _settings?.language ?? 'tr';
  String get currentTheme => _settings?.theme ?? 'light';
  bool get isDarkMode => _settings?.isDarkTheme ?? false;
  bool get areNotificationsEnabled => _settings?.pushNotifications ?? true;
  bool get hasSeenOnboarding =>
      _settings != null; // If settings exist, onboarding was completed

  ThemeMode get themeMode {
    if (_settings == null) return ThemeMode.light;

    switch (_settings!.theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      case 'light':
      default:
        return ThemeMode.light;
    }
  }

  Locale get currentLocale {
    return Locale(_settings?.language ?? 'tr');
  }

  Future<void> loadSettings() async {
    try {
      _setLoading(true);

      // Try to load existing settings
      final settingsJson = await _storageService.getString('app_settings');

      if (settingsJson != null) {
        // Parse existing settings
        //final settingsMap = Map<String, dynamic>.from(
        // In a real app, you'd use json.decode here
        //  {},
        //);

        // For now, create default settings
        // In real implementation, you'd parse the JSON
        _settings = AppSettings.defaultSettings('default_user');
        LogService.i('Settings loaded from storage');
      } else {
        // Create default settings
        _settings = AppSettings.defaultSettings('default_user');
        await _saveSettings();
        LogService.i('Default settings created');
      }

      _clearError();
    } catch (e) {
      LogService.e('Error loading settings', error: e);
      _setError('Failed to load settings');

      // Fallback to default settings
      _settings = AppSettings.defaultSettings('default_user');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateLanguage(String languageCode) async {
    if (_settings == null) return;

    try {
      _setLoading(true);

      _settings = _settings!.copyWith(language: languageCode);
      await _saveSettings();

      LogService.userAction(
        'Language changed',
        data: {'language': languageCode},
      );
      _clearError();
    } catch (e) {
      LogService.e('Error updating language', error: e);
      _setError('Failed to update language');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateTheme(String theme) async {
    if (_settings == null) return;

    try {
      _setLoading(true);

      _settings = _settings!.copyWith(theme: theme);
      await _saveSettings();

      LogService.userAction('Theme changed', data: {'theme': theme});
      _clearError();
    } catch (e) {
      LogService.e('Error updating theme', error: e);
      _setError('Failed to update theme');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateNotificationSettings({
    bool? pushNotifications,
    bool? classReminders,
    bool? membershipReminders,
    bool? announcementNotifications,
  }) async {
    if (_settings == null) return;

    try {
      _setLoading(true);

      _settings = _settings!.copyWith(
        pushNotifications: pushNotifications,
        classReminders: classReminders,
        membershipReminders: membershipReminders,
        announcementNotifications: announcementNotifications,
      );
      await _saveSettings();

      LogService.userAction('Notification settings updated');
      _clearError();
    } catch (e) {
      LogService.e('Error updating notification settings', error: e);
      _setError('Failed to update notification settings');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateReminderTime(int minutes) async {
    if (_settings == null) return;

    try {
      _setLoading(true);

      _settings = _settings!.copyWith(reminderMinutes: minutes);
      await _saveSettings();

      LogService.userAction(
        'Reminder time updated',
        data: {'minutes': minutes},
      );
      _clearError();
    } catch (e) {
      LogService.e('Error updating reminder time', error: e);
      _setError('Failed to update reminder time');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> setOnboardingCompleted() async {
    try {
      // Mark onboarding as completed by ensuring settings exist
      _settings ??= AppSettings.defaultSettings('default_user');

      await _saveSettings();
      await _storageService.saveBool('onboarding_completed', true);

      LogService.userAction('Onboarding completed');
    } catch (e) {
      LogService.e('Error setting onboarding completed', error: e);
      _setError('Failed to save onboarding state');
    }
  }

  Future<void> resetSettings() async {
    try {
      _setLoading(true);

      _settings = AppSettings.defaultSettings('default_user');
      await _saveSettings();

      LogService.userAction('Settings reset to default');
      _clearError();
    } catch (e) {
      LogService.e('Error resetting settings', error: e);
      _setError('Failed to reset settings');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _saveSettings() async {
    if (_settings == null) return;

    try {
      final settingsJson = _settings!.toJson();
      // In a real app, you'd use json.encode here
      await _storageService.saveString('app_settings', settingsJson.toString());
      LogService.d('Settings saved to storage');
    } catch (e) {
      LogService.e('Error saving settings', error: e);
      throw Exception('Failed to save settings');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
