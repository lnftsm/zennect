import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/router/app_router.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../core/utils/log_service.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../../domain/providers/settings_provider.dart';
import '../../../l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    LogService.i('SplashScreen: Initializing');

    _initializeAnimations();
    _checkInitialState();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  Future<void> _checkInitialState() async {
    try {
      // Wait for animation to complete
      await Future.delayed(const Duration(milliseconds: 2500));

      if (!mounted) return;

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final settingsProvider = Provider.of<SettingsProvider>(
        context,
        listen: false,
      );

      // Initialize settings
      await settingsProvider.loadSettings();

      // Check if user is logged in
      final isLoggedIn = await authProvider.checkAuthState();

      if (!mounted) return;

      if (isLoggedIn) {
        // User is logged in, check if onboarding was shown
        final hasSeenOnboarding = settingsProvider.hasSeenOnboarding;

        if (!hasSeenOnboarding) {
          // Show onboarding first
          AppRouter.goToOnboarding(context);
        } else {
          // Navigate to appropriate home based on user role
          final userRole =
              authProvider.currentUser?.role.toString().split('.').last ??
              'member';
          AppRouter.goToHome(context, userRole);
        }
      } else {
        // Check if onboarding was shown
        final hasSeenOnboarding = settingsProvider.hasSeenOnboarding;

        if (!hasSeenOnboarding) {
          AppRouter.goToOnboarding(context);
        } else {
          AppRouter.goToLogin(context);
        }
      }
    } catch (e) {
      LogService.e('SplashScreen: Error during initialization', error: e);
      if (mounted) {
        AppRouter.goToLogin(context);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/zennect.png',
                          fit: BoxFit.cover,
                        ),

                        // child: const Icon(
                        //   Icons.self_improvement,
                        //   size: 60,
                        //   color: AppColors.primary,
                        // ),
                      ),
                      const SizedBox(height: 24),

                      // App Name
                      Text(
                        'Zennect',
                        style: AppTextStyles.logoText.copyWith(
                          color: AppColors.white,
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Tagline
                      Text(
                        localizations.onboardingSplash,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 60),

                      // Loading indicator
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.white.withValues(alpha: 0.8),
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
