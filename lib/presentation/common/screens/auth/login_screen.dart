import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/providers/auth_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../config/router/app_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/log_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      await authProvider.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        rememberMe: _rememberMe,
      );

      if (mounted) {
        final userRole =
            authProvider.currentUser?.role.toString().split('.').last ??
            'member';
        AppRouter.goToHome(context, userRole);

        context.showSuccessSnackBar(AppLocalizations.of(context)!.successLogin);
      }
    } catch (e) {
      LogService.e('LoginScreen: Login failed', error: e);
      if (mounted) {
        context.showErrorSnackBar(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),

                  // Logo and title
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: Image.asset(
                            'assets/images/zennect.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Container(
                        //   width: 120,
                        //   height: 120,
                        //   decoration: BoxDecoration(
                        //     color: const Color.fromARGB(255, 255, 255, 255),
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   // child: const Icon(
                        //   //   Icons.self_improvement,
                        //   //   color: AppColors.white,
                        //   //   size: 40,
                        //   // ),
                        //   child: Image.asset(
                        //     'assets/images/zennect.png',
                        //     fit: BoxFit.fitWidth,
                        //   ),
                        // ),
                        Text('Zennect', style: AppTextStyles.logoText),
                        const SizedBox(height: 8),
                        Text(
                          localizations.authSignInToAccount,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Email field
                  CustomTextField(
                    controller: _emailController,
                    label: localizations.authEmail,
                    keyboardType: TextInputType.emailAddress,
                    validator: context.validateEmail,
                    prefixIcon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  CustomTextField(
                    controller: _passwordController,
                    label: localizations.authPassword,
                    obscureText: _obscurePassword,
                    validator: (value) => context.validateRequired(
                      value,
                      localizations.authPassword,
                    ),
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Remember me and forgot password
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text(
                        localizations.authRememberMe,
                        style: AppTextStyles.bodyMedium,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          AppRouter.pushNamed(
                            context,
                            AppRouter.forgotPassword,
                          );
                        },
                        child: Text(
                          localizations.authForgotPassword,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Login button
                  CustomButton(
                    text: localizations.authLogin,
                    onPressed: _handleLogin,
                    isLoading: _isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations.authDontHaveYouAccount,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AppRouter.pushNamed(context, AppRouter.register);
                        },
                        child: Text(
                          localizations.authRegister,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
