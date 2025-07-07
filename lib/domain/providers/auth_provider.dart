import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/utils/log_service.dart';
import '../../core/error/exceptions.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user.dart' as app_user;
import '../../data/services/storage_service.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService.instance;

  AuthState _state = AuthState.initial;
  app_user.User? _currentUser;
  String? _errorMessage;
  bool _rememberMe = false;

  // Getters
  AuthState get state => _state;
  app_user.User? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated =>
      _state == AuthState.authenticated && _currentUser != null;
  bool get isLoading => _state == AuthState.loading;
  bool get hasError => _state == AuthState.error;

  AuthProvider() {
    _init();
  }

  void _init() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) async {
      if (user != null) {
        try {
          final userData = await _authService.getCurrentUserData();
          if (userData != null) {
            _currentUser = userData;
            _setState(AuthState.authenticated);
            LogService.auth(
              'Auth state changed - authenticated',
              userId: user.uid,
            );
          } else {
            _setState(AuthState.unauthenticated);
            LogService.auth('Auth state changed - user data not found');
          }
        } catch (e) {
          LogService.e(
            'Error getting user data on auth state change',
            error: e,
          );
          _setState(AuthState.unauthenticated);
        }
      } else {
        _currentUser = null;
        _setState(AuthState.unauthenticated);
        LogService.auth('Auth state changed - unauthenticated');
      }
    });
  }

  Future<bool> checkAuthState() async {
    try {
      _setState(AuthState.loading);

      final user = _authService.currentUser;
      if (user != null) {
        final userData = await _authService.getCurrentUserData();
        if (userData != null) {
          _currentUser = userData;
          _setState(AuthState.authenticated);
          return true;
        }
      }

      _setState(AuthState.unauthenticated);
      return false;
    } catch (e) {
      LogService.e('Error checking auth state', error: e);
      _setError(e.toString());
      return false;
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      _setState(AuthState.loading);
      _rememberMe = rememberMe;

      final user = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user != null) {
        _currentUser = user;

        // Save credentials if remember me is checked
        if (rememberMe) {
          await _storageService.saveString('saved_email', email);
          await _storageService.saveBool('remember_me', true);
        }

        _setState(AuthState.authenticated);
        LogService.userAction('User signed in', userId: user.id);
      } else {
        throw const AuthException(
          message: 'Sign in failed',
          code: 'SIGN_IN_FAILED',
        );
      }
    } catch (e) {
      LogService.e('Sign in error', error: e);
      _setError(e.toString());
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    DateTime? birthDate,
    String? gender,
    bool kvkkConsent = false,
  }) async {
    try {
      _setState(AuthState.loading);

      final user = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        birthDate: birthDate,
        gender: gender,
        kvkkConsent: kvkkConsent,
      );

      // Don't automatically sign in after registration
      await _authService.signOut();

      _setState(AuthState.unauthenticated);
      LogService.userAction('User registered', userId: user.id);
    } catch (e) {
      LogService.e('Sign up error', error: e);
      _setError(e.toString());
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      _setState(AuthState.loading);

      await _authService.sendPasswordResetEmail(email: email);

      _setState(
        _currentUser != null
            ? AuthState.authenticated
            : AuthState.unauthenticated,
      );
      LogService.userAction(
        'Password reset email sent',
        data: {'email': email},
      );
    } catch (e) {
      LogService.e('Password reset error', error: e);
      _setError(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      _setState(AuthState.loading);

      await _authService.signOut();

      // Clear saved credentials if not remembering
      if (!_rememberMe) {
        await _storageService.remove('saved_email');
        await _storageService.remove('remember_me');
      }

      _currentUser = null;
      _setState(AuthState.unauthenticated);
      LogService.userAction('User signed out');
    } catch (e) {
      LogService.e('Sign out error', error: e);
      _setError(e.toString());
      rethrow;
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      _setState(AuthState.loading);

      await _authService.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      _setState(AuthState.authenticated);
      LogService.userAction('Password updated', userId: _currentUser?.id);
    } catch (e) {
      LogService.e('Password update error', error: e);
      _setError(e.toString());
      rethrow;
    }
  }

  Future<void> deleteAccount({required String password}) async {
    try {
      _setState(AuthState.loading);

      await _authService.deleteAccount(password: password);

      _currentUser = null;
      _setState(AuthState.unauthenticated);
      LogService.userAction('Account deleted');
    } catch (e) {
      LogService.e('Account deletion error', error: e);
      _setError(e.toString());
      rethrow;
    }
  }

  Future<String?> getSavedEmail() async {
    try {
      final rememberMe = await _storageService.getBool('remember_me') ?? false;
      if (rememberMe) {
        return await _storageService.getString('saved_email');
      }
      return null;
    } catch (e) {
      LogService.e('Error getting saved email', error: e);
      return null;
    }
  }

  void clearError() {
    _errorMessage = null;
    if (_state == AuthState.error) {
      _setState(
        _currentUser != null
            ? AuthState.authenticated
            : AuthState.unauthenticated,
      );
    }
  }

  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    _setState(AuthState.error);
  }
}
