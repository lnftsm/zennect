import '../extensions/string_extensions.dart';

class Validators {
  Validators._();

  // Required Field Validator
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Bu alan'} gereklidir';
    }
    return null;
  }

  // Email Validators
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta adresi gereklidir';
    }
    if (!value.isEmail) {
      // This now correctly calls the extension method
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  static String? optionalEmail(String? value) {
    if (value == null || value.isEmpty) return null;
    return email(value);
  }

  // Password Validators
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Şifre gereklidir';
    }
    if (value.length < minLength) {
      return 'Şifre en az $minLength karakter olmalıdır';
    }
    return null;
  }

  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre gereklidir';
    }
    if (value.length < 8) {
      return 'Şifre en az 8 karakter olmalıdır';
    }
    if (!value.isStrongPassword) {
      // This now correctly calls the extension method
      return 'Şifre en az 1 büyük harf, 1 küçük harf, 1 rakam ve 1 özel karakter içermelidir';
    }
    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Şifre tekrarı gereklidir';
    }
    if (password != confirmPassword) {
      return 'Şifreler eşleşmiyor';
    }
    return null;
  }

  // Phone Number Validators
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefon numarası gereklidir';
    }
    if (!value.isPhone) {
      // This now correctly calls the extension method
      return 'Geçerli bir telefon numarası giriniz';
    }
    return null;
  }

  static String? turkishPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefon numarası gereklidir';
    }
    if (!value.isTurkishPhone) {
      // This now correctly calls the extension method
      return 'Geçerli bir Türkiye telefon numarası giriniz (05xxxxxxxxx)';
    }
    return null;
  }

  static String? optionalPhone(String? value) {
    if (value == null || value.isEmpty) return null;
    return phone(value);
  }

  // Name Validators
  static String? name(String? value, {int minLength = 2, int maxLength = 50}) {
    if (value == null || value.isEmpty) {
      return 'İsim gereklidir';
    }
    if (value.trim().length < minLength) {
      return 'İsim en az $minLength karakter olmalıdır';
    }
    if (value.length > maxLength) {
      return 'İsim en fazla $maxLength karakter olabilir';
    }
    if (!value.isAlphabetic) {
      // This now correctly calls the extension method
      return 'İsim sadece harf içermelidir';
    }
    return null;
  }

  static String? firstName(String? value) {
    return name(value, minLength: 2, maxLength: 30);
  }

  static String? lastName(String? value) {
    return name(value, minLength: 2, maxLength: 30);
  }

  // Numeric Validators
  static String? number(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bu alan gereklidir';
    }
    if (double.tryParse(value) == null) {
      return 'Geçerli bir sayı giriniz';
    }
    return null;
  }

  static String? positiveNumber(String? value) {
    final numberError = number(value);
    if (numberError != null) return numberError;

    final numValue = double.parse(value!);
    if (numValue <= 0) {
      return 'Pozitif bir sayı giriniz';
    }
    return null;
  }

  static String? integer(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bu alan gereklidir';
    }
    if (int.tryParse(value) == null) {
      return 'Geçerli bir tam sayı giriniz';
    }
    return null;
  }

  static String? positiveInteger(String? value) {
    final intError = integer(value);
    if (intError != null) return intError;

    final intValue = int.parse(value!);
    if (intValue <= 0) {
      return 'Pozitif bir tam sayı giriniz';
    }
    return null;
  }

  // Range Validators
  static String? numberRange(String? value, double min, double max) {
    final numberError = number(value);
    if (numberError != null) return numberError;

    final numValue = double.parse(value!);
    if (numValue < min || numValue > max) {
      return 'Değer $min ile $max arasında olmalıdır';
    }
    return null;
  }

  static String? intRange(String? value, int min, int max) {
    final intError = integer(value);
    if (intError != null) return intError;

    final intValue = int.parse(value!);
    if (intValue < min || intValue > max) {
      return 'Değer $min ile $max arasında olmalıdır';
    }
    return null;
  }

  // Length Validators
  static String? minLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Bu alan'} gereklidir';
    }
    if (value.length < minLength) {
      return '${fieldName ?? 'Bu alan'} en az $minLength karakter olmalıdır';
    }
    return null;
  }

  static String? maxLength(String? value, int maxLength, [String? fieldName]) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'Bu alan'} en fazla $maxLength karakter olabilir';
    }
    return null;
  }

  static String? lengthRange(
    String? value,
    int minLength,
    int maxLength, [
    String? fieldName,
  ]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Bu alan'} gereklidir';
    }
    if (value.length < minLength || value.length > maxLength) {
      return '${fieldName ?? 'Bu alan'} $minLength-$maxLength karakter arasında olmalıdır';
    }
    return null;
  }

  // URL Validator
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL gereklidir';
    }
    if (!value.isUrl) {
      // This now correctly calls the extension method
      return 'Geçerli bir URL giriniz';
    }
    return null;
  }

  static String? optionalUrl(String? value) {
    if (value == null || value.isEmpty) return null;
    return url(value);
  }

  // Date Validators
  static String? dateString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tarih gereklidir';
    }
    if (DateTime.tryParse(value) == null) {
      return 'Geçerli bir tarih giriniz';
    }
    return null;
  }

  static String? futureDate(String? value) {
    final dateError = dateString(value);
    if (dateError != null) return dateError;

    final date = DateTime.parse(value!);
    // Using `isAfter` for future date comparison relative to now.
    // Be mindful of exact time vs. just date. `isBefore(DateTime.now())` means any time today or before.
    // If you mean a date strictly in the future (tomorrow or later), you might need `isBefore(DateTime.now().add(Duration(days:1)).startOfDay())`
    if (date.isBefore(DateTime.now())) {
      return 'Gelecekteki bir tarih seçiniz';
    }
    return null;
  }

  static String? pastDate(String? value) {
    final dateError = dateString(value);
    if (dateError != null) return dateError;

    final date = DateTime.parse(value!);
    // Using `isAfter` for past date comparison relative to now.
    if (date.isAfter(DateTime.now())) {
      return 'Geçmişteki bir tarih seçiniz';
    }
    return null;
  }

  static String? birthDate(String? value) {
    final dateError = pastDate(value);
    if (dateError != null) return dateError;

    final date = DateTime.parse(value!);
    final age = DateTime.now().difference(date).inDays / 365;
    if (age > 120) {
      return 'Geçerli bir doğum tarihi giriniz';
    }
    if (age < 0) {
      // This check might be redundant if `pastDate` already validated it's not in the future.
      return 'Doğum tarihi gelecekte olamaz';
    }
    return null;
  }

  // Age Validator
  static String? age(String? value, {int minAge = 0, int maxAge = 120}) {
    final numberError = intRange(value, minAge, maxAge);
    if (numberError != null) return numberError;
    return null;
  }

  // Turkish Identity Number (TC Kimlik No) Validator
  static String? tcNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'TC Kimlik Numarası gereklidir';
    }
    if (value.length != 11) {
      return 'TC Kimlik Numarası 11 haneli olmalıdır';
    }
    if (!value.isNumeric) {
      // This now correctly calls the extension method
      return 'TC Kimlik Numarası sadece rakam içermelidir';
    }
    if (!value.isValidTCNumber) {
      // This now correctly calls the extension method
      return 'Geçerli bir TC Kimlik Numarası giriniz';
    }
    return null;
  }

  // Credit Card Validators
  static String? creditCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kart numarası gereklidir';
    }
    final cleaned = value
        .onlyNumbers(); // This now correctly calls the extension method
    if (cleaned.length < 13 || cleaned.length > 19) {
      return 'Geçerli bir kart numarası giriniz';
    }
    // Luhn algorithm check could be added here
    return null;
  }

  static String? creditCardExpiry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Son kullanma tarihi gereklidir';
    }
    final parts = value.split('/');
    if (parts.length != 2) {
      return 'MM/YY formatında giriniz';
    }
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);
    if (month == null || year == null) {
      return 'Geçerli bir tarih giriniz';
    }
    if (month < 1 || month > 12) {
      return 'Geçerli bir ay giriniz (01-12)';
    }
    // Correctly handle 2-digit year (e.g., 25 for 2025)
    final now = DateTime.now();
    final currentYearFull = now.year;

    // Convert 2-digit year to full year, assuming it's in the 2000s
    final fullYear =
        year +
        (year < (currentYearFull % 100) ? 2000 : 2000); // Simple heuristic

    // Create a date for comparison, usually the last day of the month for expiry
    final expiryDate = DateTime(
      fullYear,
      month + 1,
      0,
    ); // Last day of expiry month

    if (expiryDate.isBefore(now)) {
      // Compare against current moment
      return 'Kartın süresi geçmiş';
    }
    return null;
  }

  static String? creditCardCvv(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV gereklidir';
    }
    if (value.length < 3 || value.length > 4) {
      return 'CVV 3-4 haneli olmalıdır';
    }
    if (!value.isNumeric) {
      // This now correctly calls the extension method
      return 'CVV sadece rakam içermelidir';
    }
    return null;
  }

  // IBAN Validator
  static String? iban(String? value) {
    if (value == null || value.isEmpty) {
      return 'IBAN gereklidir';
    }
    final cleaned = value.replaceAll(' ', '').toUpperCase();
    if (cleaned.length != 26) {
      return 'IBAN 26 karakter olmalıdır';
    }
    if (!cleaned.startsWith('TR')) {
      return 'Türkiye IBAN\'ı TR ile başlamalıdır';
    }
    // IBAN checksum validation could be added here, often involves more complex logic
    return null;
  }

  // Price Validators
  static String? price(String? value, {double minPrice = 0}) {
    if (value == null || value.isEmpty) {
      return 'Fiyat gereklidir';
    }
    final price = double.tryParse(
      value.removeMoneyFormatting,
    ); // This now correctly calls the extension method
    if (price == null) {
      return 'Geçerli bir fiyat giriniz';
    }
    if (price < minPrice) {
      return 'Fiyat en az $minPrice olmalıdır';
    }
    return null;
  }

  // Rating Validator
  static String? rating(String? value) {
    final numberError = numberRange(value, 1, 5);
    if (numberError != null) {
      return 'Değerlendirme 1-5 arasında olmalıdır';
    }
    return null;
  }

  // Capacity Validators
  static String? capacity(
    String? value, {
    int minCapacity = 1,
    int maxCapacity = 50,
  }) {
    final intError = intRange(value, minCapacity, maxCapacity);
    if (intError != null) {
      return 'Kapasite $minCapacity-$maxCapacity arasında olmalıdır';
    }
    return null;
  }

  // Duration Validator (in minutes)
  static String? classDuration(String? value) {
    final intError = intRange(value, 15, 180);
    if (intError != null) {
      return 'Ders süresi 15-180 dakika arasında olmalıdır';
    }
    return null;
  }

  // Membership Validators
  static String? membershipDuration(String? value) {
    final intError = intRange(value, 1, 365);
    if (intError != null) {
      return 'Üyelik süresi 1-365 gün arasında olmalıdır';
    }
    return null;
  }

  static String? classCount(String? value) {
    final intError = intRange(value, 1, 100);
    if (intError != null) {
      return 'Ders sayısı 1-100 arasında olmalıdır';
    }
    return null;
  }

  // Business Hour Validators
  static String? businessHour(String? value) {
    if (value == null || value.isEmpty) {
      return 'Saat gereklidir';
    }
    final parts = value.split(':');
    if (parts.length != 2) {
      return 'HH:MM formatında giriniz';
    }
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return 'Geçerli bir saat giriniz';
    }
    if (hour < 0 || hour > 23) {
      return 'Saat 00-23 arasında olmalıdır';
    }
    if (minute < 0 || minute > 59) {
      return 'Dakika 00-59 arasında olmalıdır';
    }
    return null;
  }

  // Custom Validators
  static String? match(String? value, String pattern, String errorMessage) {
    if (value == null || value.isEmpty) {
      return 'Bu alan gereklidir';
    }
    if (!RegExp(pattern).hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

  static String? custom(
    String? value,
    bool Function(String) validator,
    String errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return 'Bu alan gereklidir';
    }
    if (!validator(value)) {
      return errorMessage;
    }
    return null;
  }

  // Combine Multiple Validators
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}

// English Validators
class EnglishValidators {
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required';
    }
    if (!value.isEmail) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!value.isPhone) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? name(String? value, {int minLength = 2, int maxLength = 50}) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < minLength) {
      return 'Name must be at least $minLength characters';
    }
    if (value.length > maxLength) {
      return 'Name cannot exceed $maxLength characters';
    }
    if (!value.isAlphabetic) {
      return 'Name can only contain letters';
    }
    return null;
  }

  static String? positiveNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final numValue = double.tryParse(value);
    if (numValue == null) {
      return 'Please enter a valid number';
    }
    if (numValue <= 0) {
      return 'Please enter a positive number';
    }
    return null;
  }
}

// Validator Function Type
typedef ValidatorFunction = String? Function(String?);

// Validator Builder Class
class ValidatorBuilder {
  final List<ValidatorFunction> _validators = [];

  ValidatorBuilder required([String? fieldName]) {
    _validators.add((value) => Validators.required(value, fieldName));
    return this;
  }

  ValidatorBuilder email() {
    _validators.add(Validators.email);
    return this;
  }

  ValidatorBuilder password({int minLength = 6}) {
    _validators.add(
      (value) => Validators.password(value, minLength: minLength),
    );
    return this;
  }

  ValidatorBuilder phone() {
    _validators.add(Validators.phone);
    return this;
  }

  ValidatorBuilder minLength(int length, [String? fieldName]) {
    _validators.add((value) => Validators.minLength(value, length, fieldName));
    return this;
  }

  ValidatorBuilder maxLength(int length, [String? fieldName]) {
    _validators.add((value) => Validators.maxLength(value, length, fieldName));
    return this;
  }

  ValidatorBuilder custom(
    bool Function(String) validator,
    String errorMessage,
  ) {
    _validators.add(
      (value) => Validators.custom(value, validator, errorMessage),
    );
    return this;
  }

  ValidatorFunction build() {
    return Validators.combine(_validators);
  }
}
