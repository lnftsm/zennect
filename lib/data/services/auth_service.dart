import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils/log_service.dart';
import '../../core/error/exceptions.dart';
import '../models/user.dart' as app_user;
import '../models/user_role.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<app_user.User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      LogService.auth('Attempting sign in', email: email);

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(
          message: 'Authentication failed',
          code: 'AUTH_FAILED',
        );
      }

      // Get user data from Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw const NotFoundException(
          message: 'User data not found',
          code: 'USER_NOT_FOUND',
        );
      }

      final userData = userDoc.data()!;
      userData['id'] = userDoc.id;

      // Update last login
      await _firestore.collection('users').doc(credential.user!.uid).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      LogService.auth('Sign in successful', userId: credential.user!.uid);
      return app_user.User.fromJson(userData);
    } on FirebaseAuthException catch (e) {
      LogService.e('Firebase Auth Error: ${e.code}', error: e);
      throw AuthException(
        message: _handleAuthException(e),
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      LogService.e('Auth Service Error', error: e);
      rethrow;
    }
  }

  Future<app_user.User> createUserWithEmailAndPassword({
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
      LogService.auth('Attempting user creation', email: email);

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(
          message: 'User creation failed',
          code: 'USER_CREATION_FAILED',
        );
      }

      // Create user document in Firestore
      final now = DateTime.now();
      final userData = app_user.User(
        id: credential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        birthDate: birthDate,
        gender: gender,
        role: UserRole.member, // Default role
        kvkkConsent: kvkkConsent,
        isActive: true,
        createdAt: now,
        updatedAt: now,
        lastLoginAt: now,
      );

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(userData.toJson());

      LogService.auth(
        'User created successfully',
        userId: credential.user!.uid,
      );
      return userData;
    } on FirebaseAuthException catch (e) {
      LogService.e('Firebase Auth Error: ${e.code}', error: e);
      throw AuthException(
        message: _handleAuthException(e),
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      LogService.e('Auth Service Error', error: e);

      // Clean up auth user if Firestore operation failed
      if (_auth.currentUser != null) {
        await _auth.currentUser!.delete();
      }

      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      LogService.auth('Sending password reset email', email: email);

      await _auth.sendPasswordResetEmail(email: email);

      LogService.auth('Password reset email sent', email: email);
    } on FirebaseAuthException catch (e) {
      LogService.e('Firebase Auth Error: ${e.code}', error: e);
      throw AuthException(
        message: _handleAuthException(e),
        code: e.code,
        originalError: e,
      );
    }
  }

  Future<void> signOut() async {
    try {
      LogService.auth('Signing out', userId: _auth.currentUser?.uid);
      await _auth.signOut();
      LogService.auth('Sign out successful');
    } catch (e) {
      LogService.e('Sign out error', error: e);
      throw AuthException(
        message: 'Failed to sign out',
        code: 'SIGN_OUT_FAILED',
        originalError: e,
      );
    }
  }

  Future<app_user.User?> getCurrentUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data()!;
      userData['id'] = userDoc.id;

      return app_user.User.fromJson(userData);
    } catch (e) {
      LogService.e('Error getting current user data', error: e);
      return null;
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const AuthException(
          message: 'No user signed in',
          code: 'NO_USER',
        );
      }

      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      LogService.auth('Password updated', userId: user.uid);
    } on FirebaseAuthException catch (e) {
      LogService.e('Firebase Auth Error: ${e.code}', error: e);
      throw AuthException(
        message: _handleAuthException(e),
        code: e.code,
        originalError: e,
      );
    }
  }

  Future<void> deleteAccount({required String password}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const AuthException(
          message: 'No user signed in',
          code: 'NO_USER',
        );
      }

      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      // Delete user data from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete auth user
      await user.delete();

      LogService.auth('Account deleted', userId: user.uid);
    } on FirebaseAuthException catch (e) {
      LogService.e('Firebase Auth Error: ${e.code}', error: e);
      throw AuthException(
        message: _handleAuthException(e),
        code: e.code,
        originalError: e,
      );
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Bu e-posta adresi ile kayıtlı kullanıcı bulunamadı.';
      case 'wrong-password':
        return 'Hatalı şifre girdiniz.';
      case 'email-already-in-use':
        return 'Bu e-posta adresi zaten kullanımda.';
      case 'invalid-email':
        return 'Geçerli bir e-posta adresi girin.';
      case 'weak-password':
        return 'Şifre çok zayıf. En az 6 karakter olmalıdır.';
      case 'network-request-failed':
        return 'İnternet bağlantınızı kontrol edin.';
      case 'too-many-requests':
        return 'Çok fazla deneme yapıldı. Lütfen daha sonra tekrar deneyin.';
      case 'user-disabled':
        return 'Bu hesap devre dışı bırakılmış.';
      case 'operation-not-allowed':
        return 'Bu işlem şu anda kullanılamıyor.';
      case 'invalid-credential':
        return 'Geçersiz kimlik bilgileri.';
      case 'account-exists-with-different-credential':
        return 'Bu e-posta adresi farklı bir yöntemle kayıtlı.';
      case 'invalid-verification-code':
        return 'Geçersiz doğrulama kodu.';
      case 'invalid-verification-id':
        return 'Geçersiz doğrulama ID.';
      case 'expired-action-code':
        return 'İşlem kodu süresi dolmuş.';
      case 'invalid-action-code':
        return 'Geçersiz işlem kodu.';
      default:
        return e.message ?? 'Bir hata oluştu. Lütfen tekrar deneyin.';
    }
  }
}
