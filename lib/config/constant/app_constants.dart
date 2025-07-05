class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'Zennect';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appDescription = 'Pilates, Yoga & Wellness App';

  // Company Information
  static const String companyName = 'Zennect';
  static const String companyEmail = 'info@zennectapp.io';
  static const String companyPhone = '+90 312 123 45 67';
  static const String companyWebsite = 'https://www.zennect.io';

  // Social Media
  static const String instagramUrl = 'https://instagram.com/zennectio';
  static const String facebookUrl = 'https://facebook.com/zennectio';
  static const String youtubeUrl = 'https://youtube.com/zennectio';
  static const String linkedinUrl = 'https://linkedin.com/company/zennectio';

  // API Configuration
  static const String baseUrl = 'https://api.zennectio.com';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Firebase Configuration
  static const String firebaseProjectId = 'zennect-app';
  static const String firebaseApiKey = 'your-firebase-api-key';
  static const String firebaseAuthDomain = 'zennect-app.firebaseapp.com';
  static const String firebaseStorageBucket = 'zennect-app.appspot.com';

  // Storage Keys
  static const String keyLanguage = 'language';
  static const String keyTheme = 'theme';
  static const String keyFirstRun = 'first_run';
  static const String keyUserToken = 'user_token';
  static const String keyUserId = 'user_id';
  static const String keyUserRole = 'user_role';
  static const String keyFcmToken = 'fcm_token';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyAutoLogin = 'auto_login';
  static const String keyRememberMe = 'remember_me';

  // Supported Languages
  static const List<String> supportedLanguages = ['tr', 'en'];
  static const String defaultLanguage = 'tr';

  // Supported Themes
  static const List<String> supportedThemes = ['light', 'dark', 'system'];
  static const String defaultTheme = 'light';

  // Image Constants
  static const String logoPath = 'assets/images/logo.png';
  static const String logoWithTextPath = 'assets/images/logo_with_text.png';
  static const String splashImagePath = 'assets/images/splash.png';
  static const String defaultProfileImagePath =
      'assets/images/default_profile.png';
  static const String defaultStudioImagePath =
      'assets/images/default_studio.jpg';
  static const String emptyStatePath = 'assets/images/empty_state.png';
  static const String errorImagePath = 'assets/images/error.png';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 3);

  // Dimensions
  static const double borderRadius = 8.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;
  static const double bottomSheetBorderRadius = 16.0;
  static const double dialogBorderRadius = 16.0;

  // Padding & Margins
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Icon Sizes
  static const double iconXS = 12.0;
  static const double iconSM = 16.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;

  // Avatar Sizes
  static const double avatarSM = 32.0;
  static const double avatarMD = 48.0;
  static const double avatarLG = 64.0;
  static const double avatarXL = 96.0;

  // Button Heights
  static const double buttonHeightSM = 32.0;
  static const double buttonHeightMD = 48.0;
  static const double buttonHeightLG = 56.0;

  // App Bar Heights
  static const double appBarHeight = 56.0;
  static const double toolbarHeight = 56.0;

  // Bottom Navigation Heights
  static const double bottomNavHeight = 80.0;
  static const double tabBarHeight = 48.0;

  // Card Dimensions
  static const double cardElevation = 2.0;
  static const double cardMaxElevation = 8.0;

  // Input Field Heights
  static const double inputFieldHeight = 56.0;
  static const double textAreaMinHeight = 120.0;

  // List Item Heights
  static const double listTileHeight = 72.0;
  static const double listTileMinHeight = 56.0;

  // Image Constraints
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1920;
  static const int thumbnailSize = 150;
  static const int profileImageSize = 300;

  // Validation Constants
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int maxBioLength = 500;
  static const int maxMessageLength = 1000;
  static const int maxAnnouncementLength = 2000;

  // Phone Number Validation
  static const String phoneNumberPattern = r'^[+]?[0-9]{10,15}$';
  static const String turkishPhonePattern = r'^[+]?90[0-9]{10}$';

  // Email Validation
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  // Business Rules
  static const int maxReservationsPerUser = 10;
  static const int maxWaitlistPosition = 20;
  static const int classBookingLimitHours = 168; // 7 days
  static const int classCancellationLimitHours = 2;
  static const int privateClassBookingLimitDays = 30;
  static const int membershipExpiryWarningDays = 7;
  static const int lowClassCountWarning = 2;

  // Notification Constants
  static const String notificationChannelId = 'zennect_notifications';
  static const String notificationChannelName = 'Zennect Notifications';
  static const String notificationChannelDescription =
      'General notifications for Zennect app';

  // Reminder Times (minutes before class)
  static const List<int> reminderOptions = [
    15,
    30,
    60,
    120,
    1440,
  ]; // 15min, 30min, 1hr, 2hr, 1day
  static const int defaultReminderTime = 60; // 1 hour

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int smallPageSize = 10;
  static const int largePageSize = 50;

  // Currency
  static const String defaultCurrency = 'TRY';
  static const String currencySymbol = '₺';
  static const List<String> supportedCurrencies = ['TRY', 'USD', 'EUR'];

  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String apiDateFormat = 'yyyy-MM-dd';
  static const String apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ';

  // Geographic Constants
  static const String defaultCountry = 'Turkey';
  static const String defaultCountryCode = 'TR';
  static const String defaultCity = 'Istanbul';
  static const double istanbulLatitude = 41.0082;
  static const double istanbulLongitude = 28.9784;

  // Map Constants
  static const double defaultZoom = 15.0;
  static const double minZoom = 5.0;
  static const double maxZoom = 20.0;
  static const double mapMarkerSize = 40.0;

  // Cache Constants
  static const Duration cacheValidityDuration = Duration(hours: 24);
  static const Duration shortCacheDuration = Duration(minutes: 15);
  static const Duration longCacheDuration = Duration(days: 7);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB

  // Network Constants
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  static const Duration refreshThreshold = Duration(minutes: 5);

  // File Upload Constants
  static const List<String> allowedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];
  static const List<String> allowedDocumentExtensions = ['pdf', 'doc', 'docx'];
  static const int maxFileUploadSize = 10 * 1024 * 1024; // 10MB

  // Rating Constants
  static const int minRating = 1;
  static const int maxRating = 5;
  static const double defaultRating = 0.0;

  // Membership Constants
  static const int maxMembershipsPerUser =
      1; // Only one active membership per user
  static const int membershipGracePeriodDays = 3;
  static const int membershipFreezeMaxDays = 30;
  static const int membershipFreezeMaxTimes = 2; // per year

  // Class Constants
  static const int minClassDuration = 15; // minutes
  static const int maxClassDuration = 180; // minutes
  static const int defaultClassDuration = 60; // minutes
  static const int minClassCapacity = 1;
  static const int maxClassCapacity = 50;
  static const int defaultClassCapacity = 12;

  // Payment Constants
  static const double minPaymentAmount = 1.0;
  static const double maxPaymentAmount = 10000.0;
  static const int paymentTimeoutMinutes = 15;

  // Error Messages Keys (for localization)
  static const String errorGeneral = 'error_general';
  static const String errorNetwork = 'error_network';
  static const String errorTimeout = 'error_timeout';
  static const String errorUnauthorized = 'error_unauthorized';
  static const String errorForbidden = 'error_forbidden';
  static const String errorNotFound = 'error_not_found';
  static const String errorServerError = 'error_server_error';
  static const String errorValidation = 'error_validation';

  // Success Messages Keys
  static const String successGeneral = 'success_general';
  static const String successSaved = 'success_saved';
  static const String successDeleted = 'success_deleted';
  static const String successUpdated = 'success_updated';
  static const String successSent = 'success_sent';

  // Regular Expressions
  static const String nameRegex = r'^[a-zA-ZğüşıöçĞÜŞİÖÇ\s]+$';
  static const String numericRegex = r'^[0-9]+$';
  static const String alphanumericRegex = r'^[a-zA-Z0-9]+$';
  static const String priceRegex = r'^\d+(\.\d{1,2})?$';

  // Feature Flags (for enabling/disabling features)
  static const bool enableBiometric = true;
  static const bool enablePushNotifications = true;
  static const bool enableLocationServices = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableDeepLinking = true;
  static const bool enableOfflineMode = true;
  static const bool enableDarkTheme = true;

  // Development Flags
  static const bool isDebugMode = true;
  static const bool enableLogging = true;
  static const bool enableMockData = false;
  static const bool enablePerformanceMonitoring = true;

  // URLs for terms, privacy etc.
  static const String termsOfServiceUrl = 'https://zennect.io/terms';
  static const String privacyPolicyUrl = 'https://zennect.io/privacy';
  static const String supportUrl = 'https://zennect.io/support';
  static const String faqUrl = 'https://zennect.io/faq';

  // App Store URLs
  static const String appStoreUrl = 'https://apps.apple.com/app/zennect';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.zennect.app';

  // Default Values
  static const String defaultProfileImage =
      'https://via.placeholder.com/300x300.png?text=Profile';
  static const String defaultStudioImage =
      'https://via.placeholder.com/800x600.png?text=Studio';
  static const String defaultClassImage =
      'https://via.placeholder.com/600x400.png?text=Class';
}
