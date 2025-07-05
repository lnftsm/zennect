import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AppSettings {
  final String id;
  final String language;
  final String theme;
  final bool pushNotifications;
  final bool classReminders;
  final bool membershipReminders;
  final bool announcementNotifications;
  final int reminderMinutes;
  final DateTime updatedAt;

  AppSettings({
    required this.id,
    this.language = 'tr',
    this.theme = 'light',
    this.pushNotifications = true,
    this.classReminders = true,
    this.membershipReminders = true,
    this.announcementNotifications = true,
    this.reminderMinutes = 60,
    required this.updatedAt,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      id: json['id'],
      language: json['language'] ?? 'tr',
      theme: json['theme'] ?? 'light',
      pushNotifications: json['pushNotifications'] ?? true,
      classReminders: json['classReminders'] ?? true,
      membershipReminders: json['membershipReminders'] ?? true,
      announcementNotifications: json['announcementNotifications'] ?? true,
      reminderMinutes: json['reminderMinutes'] ?? 60,
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'language': language,
      'theme': theme,
      'pushNotifications': pushNotifications,
      'classReminders': classReminders,
      'membershipReminders': membershipReminders,
      'announcementNotifications': announcementNotifications,
      'reminderMinutes': reminderMinutes,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isDarkTheme => theme == 'dark';
  bool get isLightTheme => theme == 'light';
  bool get isSystemTheme => theme == 'system';
  bool get isTurkish => language == 'tr';
  bool get isEnglish => language == 'en';

  // --- LOCALIZED GETTERS NOW REQUIRE BuildContext ---
  String languageDisplayName(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (language) {
      case 'tr':
        return localizations.settingsLanguageTr;
      case 'en':
        return localizations.settingsLanguageEn;
      default:
        // Fallback to default language if unknown
        return localizations.settingsLanguageTr;
    }
  }

  String themeDisplayName(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (theme) {
      case 'light':
        return localizations.settingsThemeLight;
      case 'dark':
        return localizations.settingsThemeDark;
      case 'system':
        return localizations.settingsThemeSystem;
      default:
        // Fallback to default theme if unknown
        return localizations.settingsThemeLight;
    }
  }

  String reminderDisplayText(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (reminderMinutes) {
      case 15:
        return localizations.settingsReminder15min;
      case 30:
        return localizations.settingsReminder30min;
      case 60:
        return localizations.settingsReminder1hour;
      case 120:
        return localizations.settingsReminder2hours;
      case 1440:
        return localizations.settingsReminder1day;
      default:
        // Use the plural/parameterized version
        return localizations.settingsReminder1hour;
    }
  }

  AppSettings copyWith({
    String? id,
    String? language,
    String? theme,
    bool? pushNotifications,
    bool? classReminders,
    bool? membershipReminders,
    bool? announcementNotifications,
    int? reminderMinutes,
    DateTime? updatedAt,
  }) {
    return AppSettings(
      id: id ?? this.id,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      classReminders: classReminders ?? this.classReminders,
      membershipReminders: membershipReminders ?? this.membershipReminders,
      announcementNotifications:
          announcementNotifications ?? this.announcementNotifications,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  // Factory method for default settings
  factory AppSettings.defaultSettings(String userId) {
    return AppSettings(
      id: userId,
      language: 'tr', // Default values are usually hardcoded for the model
      theme: 'light', // or pulled from a constants file.
      pushNotifications: true,
      classReminders: true,
      membershipReminders: true,
      announcementNotifications: true,
      reminderMinutes: 60,
      updatedAt: DateTime.now(),
    );
  }

  // Helper method to check if any notifications are enabled
  bool get hasAnyNotificationsEnabled {
    return pushNotifications &&
        (classReminders || membershipReminders || announcementNotifications);
  }

  // // Helper method to get supported languages
  // // These lists can remain as they are, as they define data codes, not display names.
  // // Display names are retrieved using AppLocalizations.
  // static List<Map<String, String>> get supportedLanguages {
  //   return [
  //     {
  //       'code': 'tr',
  //       'name': 'Türkçe',
  //       'englishName': 'Turkish',
  //     }, // name/englishName can be for internal/dev use
  //     {'code': 'en', 'name': 'English', 'englishName': 'English'},
  //   ];
  // }

  // // Helper method to get supported themes
  // static List<Map<String, String>> get supportedThemes {
  //   return [
  //     {
  //       'code': 'light',
  //       'nameTr': 'Açık Tema',
  //       'nameEn': 'Light Theme',
  //     }, // Can also be just code if you always localize names
  //     {'code': 'dark', 'nameTr': 'Koyu Tema', 'nameEn': 'Dark Theme'},
  //     {'code': 'system', 'nameTr': 'Sistem Teması', 'nameEn': 'System Theme'},
  //   ];
  // }

  // // Helper method to get reminder options
  // static List<Map<String, dynamic>> get reminderOptions {
  //   return [
  //     {
  //       'minutes': 15,
  //       'nameTr': '15 dakika önce',
  //       'nameEn': '15 minutes before',
  //     },
  //     {
  //       'minutes': 30,
  //       'nameTr': '30 dakika önce',
  //       'nameEn': '30 minutes before',
  //     },
  //     {'minutes': 60, 'nameTr': '1 saat önce', 'nameEn': '1 hour before'},
  //     {'minutes': 120, 'nameTr': '2 saat önce', 'nameEn': '2 hours before'},
  //     {'minutes': 1440, 'nameTr': '1 gün önce', 'nameEn': '1 day before'},
  //   ];
  // }

  static List<Map<String, String>> get supportedLanguages {
    return [
      {'code': 'tr'}, // Only store the code
      {'code': 'en'},
    ];
  }

  // Helper method to get supported themes
  static List<Map<String, String>> get supportedThemes {
    return [
      {'code': 'light'}, // Only store the code
      {'code': 'dark'},
      {'code': 'system'},
    ];
  }

  // Helper method to get reminder options
  static List<Map<String, int>> get reminderOptions {
    // Change value type to int as minutes is int
    return [
      {'minutes': 15},
      {'minutes': 30},
      {'minutes': 60},
      {'minutes': 120},
      {'minutes': 1440},
    ];
  }

  // Validation methods
  bool isValidLanguage(String lang) {
    return supportedLanguages.any((l) => l['code'] == lang);
  }

  bool isValidTheme(String themeCode) {
    return supportedThemes.any((t) => t['code'] == themeCode);
  }

  bool isValidReminderTime(int minutes) {
    return reminderOptions.any((r) => r['minutes'] == minutes);
  }
}
