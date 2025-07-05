import 'dart:math' as math;
import 'package:intl/intl.dart';

extension IntExtensions on int {
  // Turkish Number Formatting
  String get turkishCurrency => NumberFormat.currency(
    locale: 'tr_TR',
    symbol: '₺',
    decimalDigits: 0,
  ).format(this);

  String get turkishNumber => NumberFormat('#,##0', 'tr_TR').format(this);

  // English Number Formatting
  String get englishCurrency => NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  ).format(this);

  String get englishNumber => NumberFormat('#,##0', 'en_US').format(this);

  // Time Formatting
  String get asMinutes => '${this}dk';
  String get asHours => '${this}sa';
  String get asDays => '${this}g';

  String get minutesAsHourMinute {
    final hours = this ~/ 60;
    final minutes = this % 60;
    if (hours == 0) return '${minutes}dk';
    if (minutes == 0) return '${hours}sa';
    return '${hours}sa ${minutes}dk';
  }

  String get secondsAsMinuteSecond {
    final minutes = this ~/ 60;
    final seconds = this % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Mathematical Operations
  bool get isEven => this % 2 == 0;
  bool get isOdd => this % 2 != 0;
  bool get isPrime {
    if (this < 2) return false;
    if (this == 2) return true;
    if (isEven) return false;
    for (int i = 3; i * i <= this; i += 2) {
      if (this % i == 0) return false;
    }
    return true;
  }

  bool get isPerfectSquare {
    final sqrt = math.sqrt(this);
    return sqrt == sqrt.floor();
  }

  int get factorial {
    if (this < 0) return 0;
    if (this <= 1) return 1;
    int result = 1;
    for (int i = 2; i <= this; i++) {
      result *= i;
    }
    return result;
  }

  // Ordinal Numbers (Turkish)
  String get turkishOrdinal {
    switch (this) {
      case 1:
        return '1.';
      case 2:
        return '2.';
      case 3:
        return '3.';
      default:
        return '$this.';
    }
  }

  // Ordinal Numbers (English)
  String get englishOrdinal {
    if (this >= 11 && this <= 13) return '${this}th';
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  // Rating Stars
  String get asStars => '★' * math.min(this, 5) + '☆' * math.max(0, 5 - this);

  // Range Checks
  bool isBetween(int min, int max) => this >= min && this <= max;
  bool isInRange(int min, int max) => isBetween(min, max);

  // Clamp Operations
  int clampToRange(int min, int max) => math.max(min, math.min(max, this));

  // Age Categories
  String get ageCategory {
    if (this < 13) return 'Çocuk';
    if (this < 18) return 'Genç';
    if (this < 60) return 'Yetişkin';
    return 'Yaşlı';
  }

  // Membership Duration
  String get membershipDuration {
    if (this == 1) return '1 Ay';
    if (this < 12) return '$this Ay';
    final years = this ~/ 12;
    final months = this % 12;
    if (months == 0) return '$years Yıl';
    return '$years Yıl $months Ay';
  }

  // Class Capacity Status
  String capacityStatus(int current) {
    final percentage = (current / this * 100).round();
    if (percentage >= 90) return 'Dolu';
    if (percentage >= 70) return 'Az Yer';
    if (percentage >= 50) return 'Yarı Dolu';
    return 'Uygun';
  }

  // Progress Percentage
  double progressPercentage(int total) =>
      total > 0 ? (this / total * 100) : 0.0;

  // Loop Operations
  void times(void Function(int index) action) {
    for (int i = 0; i < this; i++) {
      action(i);
    }
  }

  List<T> generate<T>(T Function(int index) generator) {
    return List.generate(this, generator);
  }

  // Phone Number Formatting (Turkish)
  String get formatAsTurkishPhone {
    final str = toString();
    if (str.length == 10 && str.startsWith('5')) {
      return '+90 ${str.substring(0, 3)} ${str.substring(3, 6)} ${str.substring(6, 8)} ${str.substring(8, 10)}';
    }
    return str;
  }

  // Duration from minutes
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);

  // Percentage of another number
  double percentageOf(int total) => total != 0 ? (this / total * 100) : 0.0;

  // Roman Numerals (up to 3999)
  String get romanNumeral {
    if (this <= 0 || this > 3999) return toString();

    const values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    const numerals = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I',
    ];

    String result = '';
    int number = this;

    for (int i = 0; i < values.length; i++) {
      while (number >= values[i]) {
        result += numerals[i];
        number -= values[i];
      }
    }

    return result;
  }
}

extension StringFileSizeFormatter on int {
  String get asFileSize {
    final int? bytes = this < 0 ? null : this;
    if (bytes == null) {
      return 'Invalid size';
    }

    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

extension DoubleExtensions on double {
  // Turkish Number Formatting
  String get turkishCurrency => NumberFormat.currency(
    locale: 'tr_TR',
    symbol: '₺',
    decimalDigits: 2,
  ).format(this);

  String get turkishNumber => NumberFormat('#,##0.00', 'tr_TR').format(this);
  String get turkishNumberCompact =>
      NumberFormat.compact(locale: 'tr_TR').format(this);

  // English Number Formatting
  String get englishCurrency => NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 2,
  ).format(this);

  String get englishNumber => NumberFormat('#,##0.00', 'en_US').format(this);
  String get englishNumberCompact =>
      NumberFormat.compact(locale: 'en_US').format(this);

  // Percentage Formatting
  String get asPercentage => '${(this * 100).toStringAsFixed(1)}%';
  String get asPercentageRounded => '${(this * 100).round()}%';

  // Rating Display
  String get asRating => toStringAsFixed(1);
  String get asRatingStars {
    final fullStars = floor().toInt();
    final hasHalfStar = (this - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return '★' * fullStars + (hasHalfStar ? '☆' : '') + '☆' * emptyStars;
  }

  // BMI Categories
  String get bmiCategory {
    if (this < 18.5) return 'Zayıf';
    if (this < 25) return 'Normal';
    if (this < 30) return 'Fazla Kilolu';
    return 'Obez';
  }

  // Price Formatting
  String formatAsPrice({String currency = '₺', int decimals = 2}) {
    return '${toStringAsFixed(decimals)} $currency';
  }

  String get priceDisplay {
    if (this == truncateToDouble()) {
      return '${toInt()} ₺';
    }
    return '${toStringAsFixed(2)} ₺';
  }

  // Mathematical Operations
  double get squared => this * this;
  double get cubed => this * this * this;
  double get squareRoot => math.sqrt(this);
  double get absoluteValue => abs();

  // Range Operations
  bool isBetween(double min, double max) => this >= min && this <= max;
  double clampToRange(double min, double max) =>
      math.max(min, math.min(max, this));

  // Rounding Operations
  double roundToDecimalPlaces(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces);
    return (this * factor).round() / factor;
  }

  double get rounded1 => roundToDecimalPlaces(1);
  double get rounded2 => roundToDecimalPlaces(2);

  // Progress Operations
  double get asProgress => clampToRange(0.0, 1.0);
  int get asProgressPercentage => (asProgress * 100).round();

  // Angle Conversions
  double get degreesToRadians => this * math.pi / 180;
  double get radiansToDegrees => this * 180 / math.pi;

  // Temperature Conversions
  double get celsiusToFahrenheit => (this * 9 / 5) + 32;
  double get fahrenheitToCelsius => (this - 32) * 5 / 9;
  double get celsiusToKelvin => this + 273.15;
  double get kelvinToCelsius => this - 273.15;

  // Distance Conversions
  double get metersToKilometers => this / 1000;
  double get kilometersToMeters => this * 1000;
  double get metersToMiles => this * 0.000621371;
  double get milesToMeters => this / 0.000621371;

  // Weight Conversions
  double get gramsToKilograms => this / 1000;
  double get kilogramsToGrams => this * 1000;
  double get kilogramsToPounds => this * 2.20462;
  double get poundsToKilograms => this / 2.20462;

  // Finance Operations
  double calculateTax(double rate) => this * rate;
  double addTax(double rate) => this * (1 + rate);
  double removeTax(double rate) => this / (1 + rate);

  // Discount Operations
  double applyDiscount(double percentage) => this * (1 - percentage / 100);
  double get discount10 => applyDiscount(10);
  double get discount20 => applyDiscount(20);
  double get discount50 => applyDiscount(50);

  // Membership Price Calculations
  double monthlyToYearly({double discount = 0.15}) =>
      this * 12 * (1 - discount);
  double yearlyToMonthly() => this / 12;

  // Class Duration Formatting
  String get asClassDuration {
    final minutes = (this * 60).round();
    if (minutes < 60) return '${minutes}dk';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) return '${hours}sa';
    return '${hours}sa ${remainingMinutes}dk';
  }

  // Comparison with tolerance
  bool isEqualWithTolerance(double other, {double tolerance = 0.001}) {
    return (this - other).abs() <= tolerance;
  }

  // Safe Division
  double safeDivide(double divisor, {double defaultValue = 0.0}) {
    return divisor != 0 ? this / divisor : defaultValue;
  }

  // Linear Interpolation
  double lerp(double target, double t) => this + (target - this) * t;

  // Map to Range
  double mapToRange(
    double fromMin,
    double fromMax,
    double toMin,
    double toMax,
  ) {
    final normalized = (this - fromMin) / (fromMax - fromMin);
    return toMin + normalized * (toMax - toMin);
  }

  // Statistics
  bool get isFiniteNumber => isFinite && !isNaN;
  bool get isValidPercentage => isBetween(0.0, 100.0);
  bool get isValidRating => isBetween(0.0, 5.0);

  // Animation Values
  double get easeIn => this * this;
  double get easeOut => 1 - (1 - this) * (1 - this);
  double get easeInOut {
    if (this < 0.5) return 2 * this * this;
    return 1 - 2 * (1 - this) * (1 - this);
  }
}

extension NumExtensions on num {
  // Common Operations
  String get formatted => NumberFormat('#,##0.##').format(this);
  String formatWith(String pattern) => NumberFormat(pattern).format(this);

  // Time Operations
  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
  Duration get hours => Duration(hours: toInt());
  Duration get days => Duration(days: toInt());

  // Validation
  bool get isPositive => this > 0;
  bool get isNegative => this < 0;
  bool get isZero => this == 0;
  bool get isNonZero => this != 0;

  // Range Operations
  num clamp(num min, num max) => math.min(math.max(this, min), max);
  bool between(num min, num max) => this >= min && this <= max;

  // Mathematical
  num get sign => this > 0 ? 1 : (this < 0 ? -1 : 0);
  double get sqrt => math.sqrt(this);
  double power(num exponent) => math.pow(this, exponent).toDouble();

  // Conversion Helpers
  String toStringWithCommas() => NumberFormat('#,##0').format(this);
  String toCurrency({String symbol = '₺'}) =>
      '$symbol ${NumberFormat('#,##0.00').format(this)}';

  // Business Logic
  bool get isValidPrice => this > 0;
  bool get isValidRating => between(0, 5);
  bool get isValidPercentage => between(0, 100);

  // Nullability Helpers
  T ifZero<T>(T value) => isZero ? value : this as T;
  T ifNegative<T>(T value) => isNegative ? value : this as T;
  T ifPositive<T>(T value) => isPositive ? value : this as T;
}

// Nullable Number Extensions
extension NullableIntExtensions on int? {
  bool get isNullOrZero => this == null || this == 0;
  bool get isNotNullAndPositive => this != null && this! > 0;
  int get orZero => this ?? 0;
  String get turkishCurrencyOrEmpty => this?.turkishCurrency ?? '';
  String get formattedOrEmpty => this?.turkishNumber ?? '';
}

extension NullableDoubleExtensions on double? {
  bool get isNullOrZero => this == null || this == 0.0;
  bool get isNotNullAndPositive => this != null && this! > 0;
  double get orZero => this ?? 0.0;
  String get turkishCurrencyOrEmpty => this?.turkishCurrency ?? '';
  String get formattedOrEmpty => this?.turkishNumber ?? '';
  String get ratingOrEmpty => this?.asRating ?? '';
}

extension NullableNumExtensions on num? {
  bool get isNullOrZero => this == null || this == 0;
  bool get isNotNullAndPositive => this != null && this! > 0;
  num get orZero => this ?? 0;
  String get formattedOrEmpty => this?.formatted ?? '';
}
