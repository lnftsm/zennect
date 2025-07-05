import 'dart:convert';
import 'dart:math';

extension StringExtensions on String {
  // Null and Empty Checks
  bool get isNullOrEmpty => isEmpty;
  bool get isNotNullOrEmpty => isNotEmpty;
  bool get isBlank => trim().isEmpty;
  bool get isNotBlank => trim().isNotEmpty;

  // Capitalization
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  String get camelCase {
    if (isEmpty) return this;
    final words = split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return this;
    return words.first.toLowerCase() +
        words.skip(1).map((word) => word.capitalize).join('');
  }

  String get pascalCase {
    if (isEmpty) return this;
    return split(RegExp(r'[\s_-]+')).map((word) => word.capitalize).join('');
  }

  String get snakeCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceAll(RegExp(r'[\s-]+'), '_').toLowerCase();
  }

  String get kebabCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '-${match.group(0)!.toLowerCase()}',
    ).replaceAll(RegExp(r'[\s_]+'), '-').toLowerCase();
  }

  // Text Formatting
  String get removeHtmlTags {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  String get removeExtraSpaces {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  String truncateWords(int maxWords, {String suffix = '...'}) {
    final words = split(' ');
    if (words.length <= maxWords) return this;
    return '${words.take(maxWords).join(' ')}$suffix';
  }

  String get reverse {
    return split('').reversed.join('');
  }

  // Validation
  bool get isEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  bool get isPhone {
    return RegExp(r'^[+]?[0-9]{10,15}$').hasMatch(replaceAll(' ', ''));
  }

  bool get isTurkishPhone {
    final cleaned = replaceAll(RegExp(r'[\s()-]'), '');
    return RegExp(r'^(\+90|0)?[5][0-9]{9}$').hasMatch(cleaned);
  }

  bool get isUrl {
    return RegExp(
      r'^(https?|ftp)://[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
    ).hasMatch(this);
  }

  bool get isNumeric {
    return RegExp(r'^-?[0-9]+$').hasMatch(this);
  }

  bool get isAlphabetic {
    return RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ]+$').hasMatch(this);
  }

  bool get isAlphanumeric {
    return RegExp(r'^[a-zA-Z0-9ğüşıöçĞÜŞİÖÇ]+$').hasMatch(this);
  }

  bool get hasOnlyNumbers {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  bool get hasOnlyLetters {
    return RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ\s]+$').hasMatch(this);
  }

  bool get isStrongPassword {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special char
    return length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(this) &&
        RegExp(r'[a-z]').hasMatch(this) &&
        RegExp(r'[0-9]').hasMatch(this) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this);
  }

  // Turkish Text Processing
  String get toTurkishUpperCase {
    return replaceAll('i', 'İ')
        .replaceAll('ı', 'I')
        .replaceAll('ğ', 'Ğ')
        .replaceAll('ü', 'Ü')
        .replaceAll('ş', 'Ş')
        .replaceAll('ö', 'Ö')
        .replaceAll('ç', 'Ç')
        .toUpperCase();
  }

  String get toTurkishLowerCase {
    return replaceAll('İ', 'i')
        .replaceAll('I', 'ı')
        .replaceAll('Ğ', 'ğ')
        .replaceAll('Ü', 'ü')
        .replaceAll('Ş', 'ş')
        .replaceAll('Ö', 'ö')
        .replaceAll('Ç', 'ç')
        .toLowerCase();
  }

  String get removeTurkishChars {
    return replaceAll('ğ', 'g')
        .replaceAll('Ğ', 'G')
        .replaceAll('ü', 'u')
        .replaceAll('Ü', 'U')
        .replaceAll('ş', 's')
        .replaceAll('Ş', 'S')
        .replaceAll('ı', 'i')
        .replaceAll('İ', 'I')
        .replaceAll('ö', 'o')
        .replaceAll('Ö', 'O')
        .replaceAll('ç', 'c')
        .replaceAll('Ç', 'C');
  }

  // Encoding/Decoding
  String get base64Encode {
    return base64.encode(utf8.encode(this));
  }

  String get base64Decode {
    try {
      return utf8.decode(base64.decode(this));
    } catch (e) {
      return this;
    }
  }

  String get urlEncode {
    return Uri.encodeComponent(this);
  }

  String get urlDecode {
    return Uri.decodeComponent(this);
  }

  // Parsing
  int? get toInt {
    return int.tryParse(this);
  }

  double? get toDouble {
    return double.tryParse(this);
  }

  bool? get toBool {
    final lower = toLowerCase();
    if (lower == 'true' || lower == '1' || lower == 'yes') return true;
    if (lower == 'false' || lower == '0' || lower == 'no') return false;
    return null;
  }

  DateTime? get toDateTime {
    return DateTime.tryParse(this);
  }

  // File Operations
  String get fileExtension {
    final lastDot = lastIndexOf('.');
    return lastDot != -1 ? substring(lastDot + 1) : '';
  }

  String get fileName {
    final lastSlash = lastIndexOf('/');
    final withoutPath = lastSlash != -1 ? substring(lastSlash + 1) : this;
    final lastDot = withoutPath.lastIndexOf('.');
    return lastDot != -1 ? withoutPath.substring(0, lastDot) : withoutPath;
  }

  String get filePath {
    final lastSlash = lastIndexOf('/');
    return lastSlash != -1 ? substring(0, lastSlash) : '';
  }

  // Hash and Security
  String get md5Hash {
    // You'll need to add crypto package for this
    // return crypto.md5.convert(utf8.encode(this)).toString();
    return this; // Placeholder
  }

  String get sha256Hash {
    // You'll need to add crypto package for this
    // return crypto.sha256.convert(utf8.encode(this)).toString();
    return this; // Placeholder
  }

  // Random
  static String generateRandom({
    int length = 10,
    bool includeUpperCase = true,
    bool includeLowerCase = true,
    bool includeNumbers = true,
    bool includeSpecialChars = false,
  }) {
    String chars = '';
    if (includeUpperCase) chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (includeLowerCase) chars += 'abcdefghijklmnopqrstuvwxyz';
    if (includeNumbers) chars += '0123456789';
    if (includeSpecialChars) chars += '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    if (chars.isEmpty) chars = 'abcdefghijklmnopqrstuvwxyz';

    final random = Random();
    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join('');
  }

  // Count Operations
  int countWords() {
    return split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  int countCharacters({bool includeSpaces = true}) {
    return includeSpaces ? length : replaceAll(' ', '').length;
  }

  int countLines() {
    return split('\n').length;
  }

  // Search and Replace
  String replaceRange(int start, int end, String replacement) {
    return substring(0, start) + replacement + substring(end);
  }

  String insertAt(int index, String insertion) {
    return substring(0, index) + insertion + substring(index);
  }

  String removeAt(int index, [int? length]) {
    final endIndex = length != null ? index + length : index + 1;
    return substring(0, index) + substring(endIndex);
  }

  // Similarity
  double similarity(String other) {
    if (this == other) return 1.0;
    if (isEmpty || other.isEmpty) return 0.0;

    final longer = length > other.length ? this : other;
    final shorter = length > other.length ? other : this;

    final editDistance = _levenshteinDistance(longer, shorter);
    return (longer.length - editDistance) / longer.length;
  }

  int _levenshteinDistance(String s1, String s2) {
    final matrix = List.generate(
      s1.length + 1,
      (i) => List.filled(s2.length + 1, 0),
    );

    for (int i = 0; i <= s1.length; i++) {
      matrix[i][0] = i;
    }

    for (int j = 0; j <= s2.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[s1.length][s2.length];
  }

  // Text Analysis
  Map<String, int> wordFrequency() {
    final words = toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty);

    final frequency = <String, int>{};
    for (final word in words) {
      frequency[word] = (frequency[word] ?? 0) + 1;
    }
    return frequency;
  }

  // Currency and Number Formatting
  String get formatAsCurrency {
    final number = toDouble;
    if (number == null) return this;
    return '${number.toStringAsFixed(2)}₺';
  }

  String formatAsPrice({String currency = '₺', int decimals = 2}) {
    final number = toDouble;
    if (number == null) return this;
    return '${number.toStringAsFixed(decimals)}$currency';
  }

  String get formatAsPercentage {
    final number = toDouble;
    if (number == null) return this;
    return '${(number * 100).toStringAsFixed(1)}%';
  }

  // Phone Number Formatting
  String get formatTurkishPhone {
    final cleaned = replaceAll(RegExp(r'[\s()-]'), '');
    if (cleaned.length == 11 && cleaned.startsWith('0')) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} '
          '${cleaned.substring(7, 9)} ${cleaned.substring(9)}';
    }
    if (cleaned.length == 10) {
      return '0${cleaned.substring(0, 3)} ${cleaned.substring(3, 6)} '
          '${cleaned.substring(6, 8)} ${cleaned.substring(8)}';
    }
    return this;
  }

  // Masking
  String get maskEmail {
    if (!isEmail) return this;
    final parts = split('@');
    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) return this;

    final maskedUsername =
        username[0] +
        '*' * (username.length - 2) +
        username[username.length - 1];
    return '$maskedUsername@$domain';
  }

  String get maskPhone {
    if (length < 4) return this;
    return '***${substring(length - 4)}';
  }

  String maskString({
    int visibleStart = 2,
    int visibleEnd = 2,
    String mask = '*',
  }) {
    if (length <= visibleStart + visibleEnd) return this;

    final start = substring(0, visibleStart);
    final end = substring(length - visibleEnd);
    final middle = mask * (length - visibleStart - visibleEnd);

    return start + middle + end;
  }

  // Color from String
  int? get hexColorValue {
    if (length != 6 && length != 7) return null;
    final hex = startsWith('#') ? substring(1) : this;
    return int.tryParse('FF$hex', radix: 16);
  }

  // JSON Helpers
  Map<String, dynamic>? get jsonDecode {
    try {
      return json.decode(this) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Slug Generation
  String get slug {
    return toLowerCase().removeTurkishChars
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'[\s_-]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  // Extract Numbers
  List<int> get extractNumbers {
    return RegExp(
      r'\d+',
    ).allMatches(this).map((match) => int.parse(match.group(0)!)).toList();
  }

  // Social Media Username Validation
  bool get isValidUsername {
    return RegExp(r'^[a-zA-Z0-9._-]{3,20}$').hasMatch(this);
  }

  // Check if contains only Turkish characters
  bool get isTurkishText {
    return RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ\s]+$').hasMatch(this);
  }

  // Text Metrics
  double estimateReadingTime({int wordsPerMinute = 200}) {
    final wordCount = countWords();
    return wordCount / wordsPerMinute;
  }

  // String Safety
  // String get safe {
  //   if (isEmpty) return '';
  //   return replaceAll(RegExp(r'[<>"\']'), '');
  // }

  // Credit Card Formatting
  String get formatCreditCard {
    final cleaned = replaceAll(RegExp(r'\D'), '');
    if (cleaned.length >= 4) {
      final formatted = StringBuffer();
      for (int i = 0; i < cleaned.length; i += 4) {
        if (i > 0) formatted.write(' ');
        formatted.write(
          cleaned.substring(i, i + 4 > cleaned.length ? cleaned.length : i + 4),
        );
      }
      return formatted.toString();
    }
    return this;
  }

  String maskCreditCard({int unmaskedDigits = 4, String maskCharacter = '*'}) {
    final String cleanedCardNumber = replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanedCardNumber.length <= unmaskedDigits) {
      return cleanedCardNumber;
    }

    final int maskedLength = cleanedCardNumber.length - unmaskedDigits;
    final String maskedPart = maskCharacter * maskedLength;
    final String unmaskedPart = cleanedCardNumber.substring(maskedLength);

    return maskedPart + unmaskedPart;
  }

  String formatIBAN({String separator = ' '}) {
    final String cleanedIban = replaceAll(
      RegExp(r'[^a-zA-Z0-9]'),
      '',
    ).toUpperCase();

    if (cleanedIban.isEmpty) {
      return '';
    }

    final StringBuffer formatted = StringBuffer();
    for (int i = 0; i < cleanedIban.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted.write(separator);
      }
      formatted.write(cleanedIban[i]);
    }
    return formatted.toString();
  }

  bool get isValidTCNumber {
    // Sadece rakamlardan oluşan 11 haneli bir dize olmalı
    if (length != 11 || !RegExp(r'^\d{11}$').hasMatch(this)) {
      return false;
    }

    // Her basamağı int'e çevir
    final digits = split('').map(int.parse).toList();

    // İlk basamak sıfır olamaz
    if (digits[0] == 0) {
      return false;
    }

    // 1., 3., 5., 7., 9. basamakların toplamı
    final sumOdd = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
    // 2., 4., 6., 8. basamakların toplamı
    final sumEven = digits[1] + digits[3] + digits[5] + digits[7];

    // 10. basamak kontrolü
    final checkDigit10 = ((sumOdd * 7) - sumEven) % 10;
    if (checkDigit10 != digits[9]) {
      return false;
    }

    // 11. basamak kontrolü
    final sumFirst10 = digits.take(10).reduce((a, b) => a + b);
    final checkDigit11 = sumFirst10 % 10;
    if (checkDigit11 != digits[10]) {
      return false;
    }

    // Tüm kontroller geçildiyse true döner
    return true;
  }

  String addHttpsIfNeeded() {
    if (isEmpty) {
      return '';
    }
    if (startsWith('http://') || startsWith('https://')) {
      return this;
    }
    return 'https://$this';
  }

  String extractDomain() {
    if (isEmpty) {
      return '';
    }
    try {
      final Uri uri = Uri.parse(this);
      return uri.host;
    } catch (e) {
      return '';
    }
  }

  String get initials {
    final trimmedName = trim();
    if (trimmedName.isEmpty) {
      return '';
    }

    final List<String> words = trimmedName
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) {
      return '';
    }

    if (words.length == 1) {
      return words[0][0].toUpperCase();
    } else {
      final String firstInitial = words.first[0];
      final String lastInitial = words.last[0];
      return (firstInitial + lastInitial).toUpperCase();
    }
  }

  String onlyNumbers() {
    // Removes non-digit characters
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  String get removeMoneyFormatting {
    // Removes common money formatting (e.g., currency symbols, commas, spaces)
    return replaceAll(RegExp(r'[₺$,. ]'), '');
  }
}

// Nullable String Extensions
extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  bool get isBlank => this == null || this!.trim().isEmpty;
  bool get isNotBlank => this != null && this!.trim().isNotEmpty;

  String get orEmpty => this ?? '';
  String orDefault(String defaultValue) => this ?? defaultValue;

  String? get nullIfEmpty => isNullOrEmpty ? null : this;
}
