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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  bool _agreeToPrivacy = false;
  bool _kvkkConsent = false;
  bool _isLoading = false;
  String _selectedGender = 'female';
  DateTime? _birthDate;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 6570),
      ), // 18 years ago
      firstDate: DateTime.now().subtract(
        const Duration(days: 36500),
      ), // 100 years ago
      lastDate: DateTime.now().subtract(
        const Duration(days: 6570),
      ), // 18 years ago
    );

    if (date != null) {
      setState(() {
        _birthDate = date;
      });
    }
  }

  String? _validateConfirmPassword(String? value) {
    final localizations = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return localizations.authRegister;
    }

    if (value != _passwordController.text) {
      return localizations.errorPasswordsDoNotMatch;
    }

    return null;
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final localizations = AppLocalizations.of(context)!;

    if (!_agreeToTerms) {
      context.showErrorSnackBar(localizations.authAgreeTerms);
      return;
    }

    if (!_agreeToPrivacy) {
      context.showErrorSnackBar(localizations.authAgreePrivacy);
      return;
    }

    if (!_kvkkConsent) {
      context.showErrorSnackBar(localizations.authAgreeKvkk);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      await authProvider.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        birthDate: _birthDate,
        gender: _selectedGender,
        kvkkConsent: _kvkkConsent,
      );

      if (mounted) {
        AppRouter.goToLogin(context);
        context.showSuccessSnackBar(localizations.successRegister);
      }
    } catch (e) {
      LogService.e('RegisterScreen: Registration failed', error: e);
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
      appBar: AppBar(title: Text(localizations.authRegister)),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Text(
                  localizations.authCreateNewAccount,
                  style: AppTextStyles.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  localizations.authFillInBelowInformation,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 32),

                // First Name
                CustomTextField(
                  controller: _firstNameController,
                  label: localizations.authFirstName,
                  validator: (value) => context.validateRequired(
                    value,
                    localizations.authFirstName,
                  ),
                  prefixIcon: Icons.person_outline,
                ),

                const SizedBox(height: 16),

                // Last Name
                CustomTextField(
                  controller: _lastNameController,
                  label: localizations.authLastName,
                  validator: (value) => context.validateRequired(
                    value,
                    localizations.authLastName,
                  ),
                  prefixIcon: Icons.person_outline,
                ),

                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  controller: _emailController,
                  label: localizations.authEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: context.validateEmail,
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: 16),

                // Phone
                CustomTextField(
                  controller: _phoneController,
                  label: localizations.authPhone,
                  keyboardType: TextInputType.phone,
                  validator: context.validatePhone,
                  prefixIcon: Icons.phone_outlined,
                ),

                const SizedBox(height: 16),

                // Birth Date
                GestureDetector(
                  onTap: _selectBirthDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _birthDate != null
                              ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                              : localizations.authBirthDate,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: _birthDate != null
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Gender
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.authGender,
                      style: AppTextStyles.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(localizations.authFemale),
                            value: 'female',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(localizations.authMale),
                            value: 'male',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  controller: _passwordController,
                  label: localizations.authPassword,
                  obscureText: _obscurePassword,
                  validator: context.validatePassword,
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

                // Confirm Password
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: localizations.authConfirmPassword,
                  obscureText: _obscureConfirmPassword,
                  validator: _validateConfirmPassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Terms and conditions
                CheckboxListTile(
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                  title: Text(
                    localizations.authAgreeTerms,
                    style: AppTextStyles.bodyMedium,
                  ),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                // Privacy policy
                CheckboxListTile(
                  value: _agreeToPrivacy,
                  onChanged: (value) {
                    setState(() {
                      _agreeToPrivacy = value ?? false;
                    });
                  },
                  title: Text(
                    localizations.authAgreePrivacy,
                    style: AppTextStyles.bodyMedium,
                  ),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                // KVKK consent
                CheckboxListTile(
                  value: _kvkkConsent,
                  onChanged: (value) {
                    setState(() {
                      _kvkkConsent = value ?? false;
                    });
                  },
                  title: Text(
                    localizations.authAgreeKvkk,
                    style: AppTextStyles.bodyMedium,
                  ),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                const SizedBox(height: 32),

                // Register button
                CustomButton(
                  text: localizations.authRegister,
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 24),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.authAlreadyHaveAnAccount,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        AppRouter.pop(context);
                      },
                      child: Text(
                        localizations.authLogin,
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
    );
  }
}
