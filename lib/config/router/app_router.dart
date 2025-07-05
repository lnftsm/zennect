import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  // Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String emailVerification = '/email-verification';

  // Member Routes
  static const String memberHome = '/member/home';
  static const String memberProfile = '/member/profile';
  static const String memberEditProfile = '/member/edit-profile';
  static const String memberSettings = '/member/settings';
  static const String memberNotifications = '/member/notifications';
  static const String memberMembership = '/member/membership';
  static const String memberClasses = '/member/classes';
  static const String memberSchedule = '/member/schedule';
  static const String memberReservations = '/member/reservations';
  static const String memberPayments = '/member/payments';
  static const String memberHistory = '/member/history';
  static const String memberSupport = '/member/support';
  static const String memberFaq = '/member/faq';
  static const String memberAnnouncements = '/member/announcements';
  static const String classDetail = '/class-detail';
  static const String instructorDetail = '/instructor-detail';
  static const String studioDetail = '/studio-detail';
  static const String bookClass = '/book-class';
  static const String privateClassRequest = '/private-class-request';
  static const String membershipPackages = '/membership-packages';
  static const String paymentMethod = '/payment-method';
  static const String paymentSuccess = '/payment-success';
  static const String paymentFailed = '/payment-failed';

  // Instructor Routes
  static const String instructorHome = '/instructor/home';
  static const String instructorProfile = '/instructor/profile';
  static const String instructorEditProfile = '/instructor/edit-profile';
  static const String instructorSettings = '/instructor/settings';
  static const String instructorNotifications = '/instructor/notifications';
  static const String instructorSchedule = '/instructor/schedule';
  static const String instructorClasses = '/instructor/classes';
  static const String instructorStudents = '/instructor/students';
  static const String instructorAttendance = '/instructor/attendance';
  static const String instructorReports = '/instructor/reports';
  static const String instructorSupport = '/instructor/support';
  static const String instructorPrivateClasses = '/instructor/private-classes';
  static const String attendanceCheck = '/attendance-check';
  static const String classReview = '/class-review';

  // Admin Routes
  static const String adminHome = '/admin/home';
  static const String adminProfile = '/admin/profile';
  static const String adminSettings = '/admin/settings';
  static const String adminNotifications = '/admin/notifications';
  static const String adminMembers = '/admin/members';
  static const String adminInstructors = '/admin/instructors';
  static const String adminClasses = '/admin/classes';
  static const String adminSchedules = '/admin/schedules';
  static const String adminStudios = '/admin/studios';
  static const String adminPayments = '/admin/payments';
  static const String adminReports = '/admin/reports';
  static const String adminAnnouncements = '/admin/announcements';
  static const String adminCampaigns = '/admin/campaigns';
  static const String adminFaq = '/admin/faq';
  static const String adminSupport = '/admin/support';
  static const String adminPrivateClasses = '/admin/private-classes';
  static const String memberDetail = '/admin/member-detail';
  static const String instructorDetailAdmin = '/admin/instructor-detail';
  static const String createMember = '/admin/create-member';
  static const String createInstructor = '/admin/create-instructor';
  static const String createClass = '/admin/create-class';
  static const String createSchedule = '/admin/create-schedule';
  static const String createStudio = '/admin/create-studio';
  static const String createAnnouncement = '/admin/create-announcement';
  static const String createCampaign = '/admin/create-campaign';
  static const String editMember = '/admin/edit-member';
  static const String editInstructor = '/admin/edit-instructor';
  static const String editClass = '/admin/edit-class';
  static const String editSchedule = '/admin/edit-schedule';
  static const String editStudio = '/admin/edit-studio';
  static const String editAnnouncement = '/admin/edit-announcement';
  static const String editCampaign = '/admin/edit-campaign';

  // Common Routes
  static const String changePassword = '/change-password';
  static const String about = '/about';
  static const String termsOfService = '/terms-of-service';
  static const String privacyPolicy = '/privacy-policy';
  static const String contactUs = '/contact-us';
  static const String language = '/language';
  static const String theme = '/theme';
  static const String webView = '/web-view';
  static const String imageViewer = '/image-viewer';
  static const String pdfViewer = '/pdf-viewer';
  static const String qrScanner = '/qr-scanner';
  static const String mapView = '/map-view';

  // Navigation Methods
  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T, TO>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T>(
    BuildContext context,
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.of(
      context,
    ).pushNamedAndRemoveUntil<T>(routeName, predicate, arguments: arguments);
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }

  static void popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.of(context).popUntil(predicate);
  }

  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  static void maybePop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).maybePop<T>(result);
  }

  // Convenient navigation methods
  static Future<void> goToLogin(BuildContext context) {
    return pushNamedAndRemoveUntil(context, login, (route) => false);
  }

  static Future<void> goToHome(BuildContext context, String userRole) {
    String homeRoute;
    switch (userRole.toLowerCase()) {
      case 'admin':
      case 'superadmin':
        homeRoute = adminHome;
        break;
      case 'trainer':
      case 'instructor':
        homeRoute = instructorHome;
        break;
      case 'member':
      default:
        homeRoute = memberHome;
        break;
    }

    return pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
  }

  static Future<void> goToOnboarding(BuildContext context) {
    return pushReplacementNamed(context, onboarding);
  }

  static Future<void> goToRegister(BuildContext context) {
    return pushNamed(context, register);
  }

  static Future<void> goToForgotPassword(BuildContext context) {
    return pushNamed(context, forgotPassword);
  }

  static Future<void> goToProfile(BuildContext context, String userRole) {
    String profileRoute;
    switch (userRole.toLowerCase()) {
      case 'admin':
      case 'superadmin':
        profileRoute = adminProfile;
        break;
      case 'trainer':
      case 'instructor':
        profileRoute = instructorProfile;
        break;
      case 'member':
      default:
        profileRoute = memberProfile;
        break;
    }

    return pushNamed(context, profileRoute);
  }

  static Future<void> goToSettings(BuildContext context, String userRole) {
    String settingsRoute;
    switch (userRole.toLowerCase()) {
      case 'admin':
      case 'superadmin':
        settingsRoute = adminSettings;
        break;
      case 'trainer':
      case 'instructor':
        settingsRoute = instructorSettings;
        break;
      case 'member':
      default:
        settingsRoute = memberSettings;
        break;
    }

    return pushNamed(context, settingsRoute);
  }

  static Future<void> goToNotifications(BuildContext context, String userRole) {
    String notificationsRoute;
    switch (userRole.toLowerCase()) {
      case 'admin':
      case 'superadmin':
        notificationsRoute = adminNotifications;
        break;
      case 'trainer':
      case 'instructor':
        notificationsRoute = instructorNotifications;
        break;
      case 'member':
      default:
        notificationsRoute = memberNotifications;
        break;
    }

    return pushNamed(context, notificationsRoute);
  }

  static Future<void> goToClassDetail(
    BuildContext context, {
    required String classId,
    String? scheduleId,
  }) {
    return pushNamed(
      context,
      classDetail,
      arguments: {
        'classId': classId,
        if (scheduleId != null) 'scheduleId': scheduleId,
      },
    );
  }

  static Future<void> goToInstructorDetail(
    BuildContext context, {
    required String instructorId,
  }) {
    return pushNamed(
      context,
      instructorDetail,
      arguments: {'instructorId': instructorId},
    );
  }

  static Future<void> goToStudioDetail(
    BuildContext context, {
    required String studioId,
  }) {
    return pushNamed(context, studioDetail, arguments: {'studioId': studioId});
  }

  static Future<void> goToBookClass(
    BuildContext context, {
    required String scheduleId,
  }) {
    return pushNamed(context, bookClass, arguments: {'scheduleId': scheduleId});
  }

  static Future<void> goToPayment(
    BuildContext context, {
    required String packageId,
    double? amount,
    String? description,
  }) {
    return pushNamed(
      context,
      paymentMethod,
      arguments: {
        'packageId': packageId,
        if (amount != null) 'amount': amount,
        if (description != null) 'description': description,
      },
    );
  }

  static Future<void> showWebView(
    BuildContext context, {
    required String url,
    String? title,
  }) {
    return pushNamed(
      context,
      webView,
      arguments: {'url': url, if (title != null) 'title': title},
    );
  }

  static Future<void> showImageViewer(
    BuildContext context, {
    required List<String> imageUrls,
    int initialIndex = 0,
    String? heroTag,
  }) {
    return pushNamed(
      context,
      imageViewer,
      arguments: {
        'imageUrls': imageUrls,
        'initialIndex': initialIndex,
        if (heroTag != null) 'heroTag': heroTag,
      },
    );
  }

  static Future<void> showMapView(
    BuildContext context, {
    required double latitude,
    required double longitude,
    String? title,
    String? address,
  }) {
    return pushNamed(
      context,
      mapView,
      arguments: {
        'latitude': latitude,
        'longitude': longitude,
        if (title != null) 'title': title,
        if (address != null) 'address': address,
      },
    );
  }

  // Helper method to get arguments
  static T? getArguments<T>(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return args is T ? args : null;
  }

  static Map<String, dynamic>? getArgumentsAsMap(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return args is Map<String, dynamic> ? args : null;
  }

  // Route predicate helpers
  static RoutePredicate untilRoute(String routeName) {
    return (route) => route.settings.name == routeName;
  }

  static RoutePredicate get untilFirst =>
      (route) => route.isFirst;

  // Custom page transitions
  static PageRouteBuilder<T> createSlideTransition<T>({
    required Widget page,
    required RouteSettings settings,
    Offset begin = const Offset(1.0, 0.0),
    Offset end = Offset.zero,
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static PageRouteBuilder<T> createFadeTransition<T>({
    required Widget page,
    required RouteSettings settings,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static PageRouteBuilder<T> createScaleTransition<T>({
    required Widget page,
    required RouteSettings settings,
    double begin = 0.0,
    double end = 1.0,
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return ScaleTransition(scale: animation.drive(tween), child: child);
      },
    );
  }
}
