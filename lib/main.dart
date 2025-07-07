import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/theme/app_theme.dart';
import 'config/router/app_router.dart';
import 'core/utils/log_service.dart';
import 'data/services/firebase_service.dart';
import 'data/services/storage_service.dart';
import 'domain/providers/auth_provider.dart';
import 'domain/providers/settings_provider.dart';
import 'presentation/common/screens/splash_screen.dart';
import 'presentation/common/screens/onboarding_screen.dart';
import 'presentation/common/screens/auth/login_screen.dart';
import 'presentation/common/screens/auth/register_screen.dart';
import 'presentation/common/screens/auth/forgot_password_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging
  LogService.initialize(level: Level.debug);
  LogService.i('🚀 Starting Zennect App');

  try {
    // Initialize Firebase
    await Firebase.initializeApp();
    await FirebaseService.initialize();
    LogService.i('✅ Firebase initialized');

    // Initialize Storage
    await StorageService.instance.init();
    LogService.i('✅ Storage initialized');

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(const ZennectApp());
  } catch (e, stackTrace) {
    LogService.e(
      '❌ Failed to initialize app',
      error: e,
      stackTrace: stackTrace,
    );

    // Show error screen or fallback
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Failed to initialize app',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Restart app
                    main();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ZennectApp extends StatelessWidget {
  const ZennectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: 'Zennect',
            debugShowCheckedModeBanner: false,

            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsProvider.themeMode,

            // Localization
            locale: settingsProvider.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            // Navigation
            initialRoute: AppRouter.splash,
            onGenerateRoute: _generateRoute,

            // Global settings
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(
                    1.0,
                  ), // Prevent text scaling
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    LogService.navigation(
      'Navigation',
      settings.name ?? 'unknown',
      arguments: settings.arguments is Map<String, dynamic>
          ? settings.arguments as Map<String, dynamic>
          : null,
    );

    switch (settings.name) {
      case AppRouter.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case AppRouter.onboarding:
        return AppRouter.createSlideTransition(
          page: const OnboardingScreen(),
          settings: settings,
        );

      case AppRouter.login:
        return AppRouter.createFadeTransition(
          page: const LoginScreen(),
          settings: settings,
        );

      case AppRouter.register:
        return AppRouter.createSlideTransition(
          page: const RegisterScreen(),
          settings: settings,
        );

      case AppRouter.forgotPassword:
        return AppRouter.createSlideTransition(
          page: const ForgotPasswordScreen(),
          settings: settings,
        );

      // Add more routes here as you create more screens
      // case AppRouter.memberHome:
      //   return MaterialPageRoute(
      //     builder: (_) => const MemberHomeScreen(),
      //     settings: settings,
      //   );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Route Not Found')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Route "${settings.name}" not found',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRouter.splash);
                    },
                    child: const Text('Go to Home'),
                  ),
                ],
              ),
            ),
          ),
          settings: settings,
        );
    }
  }
}
