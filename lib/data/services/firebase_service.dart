import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../core/utils/log_service.dart';
//import 'data/services/notification_service.dart';
import '../../core/error/exceptions.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance => _instance ?? FirebaseService._();

  FirebaseService._();

  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _auth;
  late final FirebaseMessaging _messaging;

  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  FirebaseMessaging get messaging => _messaging;

  static bool _initialized = false;
  static bool get isInitialized => _initialized;

  /// Initialize Firebase services
  static Future<void> initialize() async {
    if (_initialized) {
      LogService.i('Firebase already initialized');
      return;
    }

    try {
      // Initialize Firebase
      await Firebase.initializeApp();
      LogService.i('Firebase initialized successfully');

      // Create instance
      _instance = FirebaseService._();

      // Initialize services
      await _instance!._initializeServices();

      _initialized = true;
      LogService.i('All Firebase services initialized');
    } catch (e) {
      LogService.e('Error initializing Firebase: $e');
      throw ServerException(
        message: 'Failed to initialize Firebase',
        code: 'FIREBASE_INIT_ERROR',
      );
    }
  }

  /// Initialize individual Firebase services
  Future<void> _initializeServices() async {
    try {
      // Initialize Firestore
      _firestore = FirebaseFirestore.instance;
      await _configureFirestore();

      // Initialize Auth
      _auth = FirebaseAuth.instance;
      await _configureAuth();

      // Initialize Messaging
      _messaging = FirebaseMessaging.instance;
      await _configureMessaging();

      // Initialize Notification Service
      // TODO: import import 'data/services/notification_service.dart';
      // and Uncomment when NotificationService is implemented
      //await NotificationService().initialize();
    } catch (e) {
      LogService.e('Error initializing Firebase services: $e');
      throw ServerException(
        message: 'Failed to initialize Firebase services',
        code: 'FIREBASE_SERVICES_INIT_ERROR',
      );
    }
  }

  /// Configure Firestore settings
  Future<void> _configureFirestore() async {
    try {
      // Configure Firestore settings
      _firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );

      // Enable network for Firestore
      await _firestore.enableNetwork();

      // Test Firestore connection
      await _firestore
          .collection('_test')
          .doc('test')
          .get()
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              throw Exception('Firestore connection timeout');
            },
          );

      LogService.i('Firestore configured successfully');
    } catch (e) {
      LogService.e('Error configuring Firestore: $e');
      // Don't throw here, Firestore might work offline
    }
  }

  /// Configure Auth settings
  Future<void> _configureAuth() async {
    try {
      // Set auth language
      _auth.setLanguageCode('tr');

      if (kIsWeb) {
        await _auth.setPersistence(Persistence.LOCAL);
      }

      // Listen to auth state changes
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          LogService.i('User is signed out');
        } else {
          LogService.i('User is signed in: ${user.email}');
        }
      });

      LogService.i('Auth configured successfully');
    } catch (e) {
      LogService.e('Error configuring Auth: $e');
    }
  }

  /// Configure Firebase Cloud Messaging
  Future<void> _configureMessaging() async {
    try {
      // Request permission for iOS
      final settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      LogService.i('User granted permission: ${settings.authorizationStatus}');

      // Get FCM token
      final token = await _messaging.getToken();
      LogService.i('FCM Token: $token');

      // Listen to token refresh
      _messaging.onTokenRefresh.listen((newToken) {
        LogService.i('FCM Token refreshed: $newToken');
        // Update token in Firestore for the current user
        _updateUserToken(newToken);
      });

      LogService.i('Messaging configured successfully');
    } catch (e) {
      LogService.e('Error configuring Messaging: $e');
    }
  }

  /// Update user's FCM token in Firestore
  Future<void> _updateUserToken(String token) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'fcmToken': token,
          'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      debugPrint('Error updating user token: $e');
    }
  }

  /// Clear all Firebase caches
  Future<void> clearCache() async {
    try {
      await _firestore.clearPersistence();
      LogService.i('Firebase cache cleared');
    } catch (e) {
      LogService.e('Error clearing cache: $e');
      throw CacheException(message: 'Failed to clear cache');
    }
  }

  /// Disable Firebase network (for offline mode)
  Future<void> disableNetwork() async {
    try {
      await _firestore.disableNetwork();
      LogService.i('Firebase network disabled');
    } catch (e) {
      LogService.e('Error disabling network: $e');
      throw NetworkException(message: 'Failed to disable network');
    }
  }

  /// Enable Firebase network
  Future<void> enableNetwork() async {
    try {
      await _firestore.enableNetwork();
      LogService.i('Firebase network enabled');
    } catch (e) {
      LogService.e('Error enabling network: $e');
      throw NetworkException(message: 'Failed to enable network');
    }
  }

  /// Terminate Firebase services (for testing or app reset)
  static Future<void> terminate() async {
    if (!_initialized) return;

    try {
      await _instance?._firestore.terminate();
      await _instance?._auth.signOut();
      _initialized = false;
      _instance = null;
      LogService.i('Firebase services terminated');
    } catch (e) {
      LogService.e('Error terminating Firebase: $e');
    }
  }

  /// Get server timestamp
  static FieldValue get serverTimestamp => FieldValue.serverTimestamp();

  /// Batch write helper
  Future<void> batchWrite(Function(WriteBatch batch) operations) async {
    final batch = _firestore.batch();
    operations(batch);
    await batch.commit();
  }

  /// Transaction helper
  Future<T> runTransaction<T>(
    Future<T> Function(Transaction transaction) transactionHandler,
  ) async {
    return await _firestore.runTransaction(transactionHandler);
  }

  /// Collection reference helper with converter
  CollectionReference<T> collection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String id) fromJson,
    required Map<String, dynamic> Function(T model) toJson,
  }) {
    return _firestore
        .collection(path)
        .withConverter<T>(
          fromFirestore: (snapshot, _) =>
              fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (model, _) => toJson(model),
        );
  }

  /// Document reference helper with converter
  DocumentReference<T> doc<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String id) fromJson,
    required Map<String, dynamic> Function(T model) toJson,
  }) {
    return _firestore
        .doc(path)
        .withConverter<T>(
          fromFirestore: (snapshot, _) =>
              fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (model, _) => toJson(model),
        );
  }

  /// Listen to connection state
  Stream<bool> get connectionState {
    return _firestore
        .collection('.info')
        .doc('connected')
        .snapshots()
        .map((snapshot) => snapshot.data()?['connected'] ?? false);
  }

  /// Check if device is online
  Future<bool> get isOnline async {
    try {
      final result = await _firestore
          .collection('_connection_test')
          .doc('test')
          .get(const GetOptions(source: Source.server));
      return result.metadata.isFromCache == false;
    } catch (_) {
      return false;
    }
  }
}

// Extension for easier Firestore operations
extension FirestoreExtension on FirebaseFirestore {
  /// Get typed collection reference
  CollectionReference<T> typedCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String id) fromJson,
    required Map<String, dynamic> Function(T model) toJson,
  }) {
    return collection(path).withConverter<T>(
      fromFirestore: (snapshot, _) => fromJson(snapshot.data()!, snapshot.id),
      toFirestore: (model, _) => toJson(model),
    );
  }

  /// Get typed document reference
  DocumentReference<T> typedDoc<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String id) fromJson,
    required Map<String, dynamic> Function(T model) toJson,
  }) {
    return doc(path).withConverter<T>(
      fromFirestore: (snapshot, _) => fromJson(snapshot.data()!, snapshot.id),
      toFirestore: (model, _) => toJson(model),
    );
  }
}

// Firebase Collections Constants
class FirebaseCollections {
  static const String users = 'users';
  static const String classes = 'classes';
  static const String schedules = 'schedules';
  static const String instructors = 'instructors';
  static const String studios = 'studios';
  static const String reservations = 'reservations';
  static const String memberships = 'memberships';
  static const String membershipPackages = 'membershipPackages';
  static const String payments = 'payments';
  static const String attendance = 'attendance';
  static const String announcements = 'announcements';
  static const String campaigns = 'campaigns';
  static const String faqs = 'faqs';
  static const String notifications = 'notifications';
  static const String messages = 'messages';
  static const String conversations = 'conversations';
  static const String waitlist = 'waitlist';
  static const String reviews = 'reviews';
  static const String privateClassRequests = 'privateClassRequests';
  static const String settings = 'settings';
}

// Firebase Storage Paths
class FirebaseStoragePaths {
  static String userProfile(String userId) => 'users/$userId/profile.jpg';
  static String instructorProfile(String instructorId) =>
      'instructors/$instructorId/profile.jpg';
  static String studioImage(String studioId, String imageName) =>
      'studios/$studioId/$imageName';
  static String announcementImage(String announcementId) =>
      'announcements/$announcementId/cover.jpg';
  static String classImage(String classId) => 'classes/$classId/cover.jpg';
  static String messageAttachment(
    String conversationId,
    String messageId,
    String fileName,
  ) => 'conversations/$conversationId/messages/$messageId/$fileName';
}

// Firebase Error Codes
class FirebaseErrorCodes {
  // Auth errors
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String invalidEmail = 'invalid-email';
  static const String weakPassword = 'weak-password';
  static const String tooManyRequests = 'too-many-requests';
  static const String userDisabled = 'user-disabled';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String networkRequestFailed = 'network-request-failed';

  // Firestore errors
  static const String permissionDenied = 'permission-denied';
  static const String notFound = 'not-found';
  static const String alreadyExists = 'already-exists';
  static const String resourceExhausted = 'resource-exhausted';
  static const String failedPrecondition = 'failed-precondition';
  static const String aborted = 'aborted';
  static const String outOfRange = 'out-of-range';
  static const String unimplemented = 'unimplemented';
  static const String internal = 'internal';
  static const String unavailable = 'unavailable';
  static const String dataLoss = 'data-loss';
}
