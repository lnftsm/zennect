import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ContextExtensions on BuildContext {
  // Theme Extensions
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  // Colors
  Color get primaryColor => colorScheme.primary;
  Color get secondaryColor => colorScheme.secondary;
  Color get backgroundColor => colorScheme.surface;
  Color get surfaceColor => colorScheme.surface;
  Color get errorColor => colorScheme.error;
  Color get onPrimaryColor => colorScheme.onPrimary;
  Color get onSecondaryColor => colorScheme.onSecondary;
  Color get onBackgroundColor => colorScheme.onSurface;
  Color get onSurfaceColor => colorScheme.onSurface;
  Color get onErrorColor => colorScheme.onError;

  // Screen Dimensions
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  // Safe Area
  double get topPadding => padding.top;
  double get bottomPadding => padding.bottom;
  double get leftPadding => padding.left;
  double get rightPadding => padding.right;

  // Keyboard
  double get keyboardHeight => viewInsets.bottom;
  bool get isKeyboardOpen => keyboardHeight > 0;

  // Responsive Design Helpers
  bool get isSmallScreen => screenWidth < 600;
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 1200;
  bool get isLargeScreen => screenWidth >= 1200;
  bool get isMobile => screenWidth < 768;
  bool get isTablet => screenWidth >= 768 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // Orientation
  Orientation get orientation => mediaQuery.orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // Platform
  TargetPlatform get platform => theme.platform;
  bool get isAndroid => platform == TargetPlatform.android;
  bool get isIOS => platform == TargetPlatform.iOS;
  bool get isMacOS => platform == TargetPlatform.macOS;
  bool get isWindows => platform == TargetPlatform.windows;
  bool get isLinux => platform == TargetPlatform.linux;
  bool get isFuchsia => platform == TargetPlatform.fuchsia;

  // Dark Mode
  Brightness get brightness => theme.brightness;
  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;

  // Navigation
  NavigatorState get navigator => Navigator.of(this);
  ModalRoute? get modalRoute => ModalRoute.of(this);
  RouteSettings? get routeSettings => modalRoute?.settings;
  String? get routeName => routeSettings?.name;
  Object? get routeArguments => routeSettings?.arguments;

  // Scaffold
  ScaffoldState? get scaffold => Scaffold.maybeOf(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  // Focus
  FocusNode get focusNode => Focus.of(this);
  FocusScopeNode get focusScope => FocusScope.of(this);

  // Localization (you'll need to implement this when adding localization)
  // Locale get locale => Localizations.localeOf(this);
  // String get languageCode => locale.languageCode;
  // String get countryCode => locale.countryCode ?? '';

  // Responsive Padding
  EdgeInsets get responsivePadding {
    if (isSmallScreen) {
      return const EdgeInsets.all(16.0);
    } else if (isMediumScreen) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  // Responsive Margin
  EdgeInsets get responsiveMargin {
    if (isSmallScreen) {
      return const EdgeInsets.all(8.0);
    } else if (isMediumScreen) {
      return const EdgeInsets.all(16.0);
    } else {
      return const EdgeInsets.all(24.0);
    }
  }

  // Navigation Methods
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return navigator.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return navigator.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  void pop<T extends Object?>([T? result]) {
    navigator.pop<T>(result);
  }

  void popUntil(RoutePredicate predicate) {
    navigator.popUntil(predicate);
  }

  bool canPop() {
    return navigator.canPop();
  }

  Future<bool> maybePop<T extends Object?>([T? result]) {
    return navigator.maybePop<T>(result);
  }

  // Dialog Methods
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    Duration transitionDuration = const Duration(milliseconds: 200),
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      builder: (context) => child,
    );
  }

  Future<T?> showBottomModal<T>({
    required Widget child,
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool isDismissible = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: (context) => child,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
    );
  }

  // SnackBar Methods
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
    double? elevation,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
  }) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textColor != null ? TextStyle(color: textColor) : null,
        ),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        behavior: behavior,
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: errorColor, textColor: onErrorColor);
  }

  void showWarningSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  void showInfoSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  void hideSnackBar() {
    scaffoldMessenger.hideCurrentSnackBar();
  }

  // Focus Methods
  void unfocus() {
    focusScope.unfocus();
  }

  void requestFocus(FocusNode focusNode) {
    focusScope.requestFocus(focusNode);
  }

  // Haptic Feedback
  void lightHaptic() {
    HapticFeedback.lightImpact();
  }

  void mediumHaptic() {
    HapticFeedback.mediumImpact();
  }

  void heavyHaptic() {
    HapticFeedback.heavyImpact();
  }

  void selectionHaptic() {
    HapticFeedback.selectionClick();
  }

  void vibrate() {
    HapticFeedback.vibrate();
  }

  // System UI
  void hideSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void showSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void setSystemUIStyle({
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Brightness? statusBarBrightness,
    Color? systemNavigationBarColor,
    Brightness? systemNavigationBarIconBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      ),
    );
  }

  // Form Validation Helpers
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? password, {int minLength = 6}) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^[+]?[0-9]{10,15}$').hasMatch(phone.replaceAll(' ', ''))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Responsive Values
  T responsiveValue<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) {
      return desktop;
    } else if (isTablet && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  double responsiveWidth(double percentage) {
    return screenWidth * (percentage / 100);
  }

  double responsiveHeight(double percentage) {
    return screenHeight * (percentage / 100);
  }

  // Safe Area Values
  double get safeWidth => screenWidth - leftPadding - rightPadding;
  double get safeHeight => screenHeight - topPadding - bottomPadding;

  // App Bar Height
  double get appBarHeight => kToolbarHeight;
  double get statusBarHeight => topPadding;
  double get bottomNavigationBarHeight => kBottomNavigationBarHeight;

  // Available Height (excluding app bar and bottom nav)
  double get availableHeight =>
      safeHeight - appBarHeight - bottomNavigationBarHeight;

  // Widget Size Helpers
  Size getWidgetSize(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size ?? Size.zero;
  }

  Offset getWidgetPosition(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
  }
}
