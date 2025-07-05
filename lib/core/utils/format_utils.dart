// core/utils/format_utils.dart
import 'package:intl/intl.dart';
import '../extensions/datetime_extensions.dart';
import '../extensions/string_extensions.dart';
import '../extensions/number_extensions.dart';

class FormatUtils {
  FormatUtils._();

  // Date and Time Formatting
  static String formatDate(
    DateTime? date, {
    String locale = 'tr_TR',
    String pattern = 'dd.MM.yyyy',
  }) {
    if (date == null) return '';
    return DateFormat(pattern, locale).format(date);
  }

  static String formatTime(
    DateTime? time, {
    String locale = 'tr_TR',
    bool use24Hour = true,
  }) {
    if (time == null) return '';
    final pattern = use24Hour ? 'HH:mm' : 'hh:mm a';
    return DateFormat(pattern, locale).format(time);
  }

  static String formatDateTime(
    DateTime? dateTime, {
    String locale = 'tr_TR',
    String pattern = 'dd.MM.yyyy HH:mm',
  }) {
    if (dateTime == null) return '';
    return DateFormat(pattern, locale).format(dateTime);
  }

  // Smart date formatting based on context
  static String formatSmartDate(DateTime? date, {String locale = 'tr'}) {
    if (date == null) return '';
    return date.smartFormat(locale: locale);
  }

  // Time ago formatting
  static String formatTimeAgo(DateTime? date, {String locale = 'tr'}) {
    if (date == null) return '';
    return locale == 'tr' ? date.turkishTimeAgo : date.englishTimeAgo;
  }

  // Time remaining formatting
  static String formatTimeRemaining(DateTime? date, {String locale = 'tr'}) {
    if (date == null) return '';
    return locale == 'tr'
        ? date.turkishTimeRemaining
        : date.englishTimeRemaining;
  }

  // Duration formatting
  static String formatDuration(
    Duration? duration, {
    String locale = 'tr',
    bool showSeconds = false,
  }) {
    if (duration == null) return '';

    if (locale == 'tr') {
      return duration.turkishDuration;
    } else {
      return duration.englishDuration;
    }
  }

  static String formatClassDuration(int minutes, {String locale = 'tr'}) {
    if (locale == 'tr') {
      if (minutes >= 60) {
        final hours = minutes ~/ 60;
        final remainingMinutes = minutes % 60;
        if (remainingMinutes == 0) {
          return '$hours saat';
        } else {
          return '$hours saat $remainingMinutes dk';
        }
      } else {
        return '$minutes dk';
      }
    } else {
      if (minutes >= 60) {
        final hours = minutes ~/ 60;
        final remainingMinutes = minutes % 60;
        if (remainingMinutes == 0) {
          return '$hours ${hours == 1 ? 'hour' : 'hours'}';
        } else {
          return '$hours ${hours == 1 ? 'hour' : 'hours'} $remainingMinutes min';
        }
      } else {
        return '$minutes min';
      }
    }
  }

  // Number formatting
  static String formatNumber(
    num? number, {
    String locale = 'tr_TR',
    int decimalPlaces = 0,
  }) {
    if (number == null) return '';

    final pattern = decimalPlaces > 0
        ? '#,##0.${'0' * decimalPlaces}'
        : '#,##0';

    return NumberFormat(pattern, locale).format(number);
  }

  static String formatCompactNumber(num? number, {String locale = 'tr_TR'}) {
    if (number == null) return '';
    return NumberFormat.compact(locale: locale).format(number);
  }

  // Currency formatting
  static String formatCurrency(
    num? amount, {
    String locale = 'tr_TR',
    String symbol = '₺',
    int decimalPlaces = 2,
  }) {
    if (amount == null) return '';

    return NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalPlaces,
    ).format(amount);
  }

  static String formatPrice(double? price, {String locale = 'tr'}) {
    if (price == null) return '';

    if (locale == 'tr') {
      return price.turkishCurrency;
    } else {
      return price.englishCurrency;
    }
  }

  // Percentage formatting
  static String formatPercentage(
    num? value, {
    String locale = 'tr_TR',
    int decimalPlaces = 1,
  }) {
    if (value == null) return '';

    final pattern = decimalPlaces > 0
        ? '#,##0.${'0' * decimalPlaces}%'
        : '#,##0%';

    return NumberFormat(pattern, locale).format(value);
  }

  // Phone number formatting
  static String formatPhoneNumber(String? phone, {String locale = 'tr'}) {
    if (phone == null || phone.isEmpty) return '';

    if (locale == 'tr') {
      return phone.formatTurkishPhone;
    } else {
      // Basic international formatting
      final cleaned = phone.onlyNumbers();
      if (cleaned.length >= 10) {
        return '+${cleaned.substring(0, 2)} ${cleaned.substring(2, 5)} ${cleaned.substring(5, 8)} ${cleaned.substring(8)}';
      }
      return phone;
    }
  }

  // Email masking
  static String formatMaskedEmail(String? email) {
    if (email == null || email.isEmpty) return '';
    return email.maskEmail;
  }

  // Phone masking
  static String formatMaskedPhone(String? phone) {
    if (phone == null || phone.isEmpty) return '';
    return phone.maskPhone;
  }

  // File size formatting
  static String formatFileSize(int? bytes) {
    if (bytes == null) return '';
    return bytes.asFileSize;
  }

  // Rating formatting
  static String formatRating(double? rating, {int decimalPlaces = 1}) {
    if (rating == null) return '';
    return rating.toStringAsFixed(decimalPlaces);
  }

  static String formatRatingWithCount(
    double? rating,
    int? count, {
    String locale = 'tr',
  }) {
    if (rating == null || count == null) return '';

    final ratingStr = formatRating(rating);

    if (locale == 'tr') {
      return '$ratingStr ($count değerlendirme)';
    } else {
      return '$ratingStr ($count ${count == 1 ? 'review' : 'reviews'})';
    }
  }

  // Capacity formatting
  static String formatCapacity(int? current, int? max, {String locale = 'tr'}) {
    if (current == null || max == null) return '';

    if (locale == 'tr') {
      return '$current / $max kişi';
    } else {
      return '$current / $max people';
    }
  }

  // Spots remaining formatting
  static String formatSpotsRemaining(int? spots, {String locale = 'tr'}) {
    if (spots == null || spots <= 0) return '';

    if (locale == 'tr') {
      return '$spots yer kaldı';
    } else {
      return '$spots ${spots == 1 ? 'spot' : 'spots'} left';
    }
  }

  // Class count formatting
  static String formatClassCount(int? count, {String locale = 'tr'}) {
    if (count == null) return '';

    if (locale == 'tr') {
      return '$count ders';
    } else {
      return '$count ${count == 1 ? 'class' : 'classes'}';
    }
  }

  // Member count formatting
  static String formatMemberCount(int? count, {String locale = 'tr'}) {
    if (count == null) return '';

    if (locale == 'tr') {
      return '$count üye';
    } else {
      return '$count ${count == 1 ? 'member' : 'members'}';
    }
  }

  // Age formatting
  static String formatAge(DateTime? birthDate, {String locale = 'tr'}) {
    if (birthDate == null) return '';

    final age = birthDate.age;

    if (locale == 'tr') {
      return '$age yaş';
    } else {
      return '$age ${age == 1 ? 'year' : 'years'} old';
    }
  }

  // Experience formatting
  static String formatExperience(int? years, {String locale = 'tr'}) {
    if (years == null) return '';

    if (locale == 'tr') {
      return '$years yıl deneyim';
    } else {
      return '$years ${years == 1 ? 'year' : 'years'} experience';
    }
  }

  // Status formatting
  static String formatMembershipStatus(String? status, {String locale = 'tr'}) {
    if (status == null || status.isEmpty) return '';

    if (locale == 'tr') {
      switch (status.toLowerCase()) {
        case 'active':
          return 'Aktif';
        case 'expired':
          return 'Süresi Dolmuş';
        case 'suspended':
          return 'Askıya Alınmış';
        case 'cancelled':
          return 'İptal Edilmiş';
        default:
          return status;
      }
    } else {
      return status.capitalize;
    }
  }

  static String formatPaymentStatus(String? status, {String locale = 'tr'}) {
    if (status == null || status.isEmpty) return '';

    if (locale == 'tr') {
      switch (status.toLowerCase()) {
        case 'completed':
        case 'success':
          return 'Başarılı';
        case 'pending':
          return 'Beklemede';
        case 'failed':
          return 'Başarısız';
        case 'cancelled':
          return 'İptal Edildi';
        case 'refunded':
          return 'İade Edildi';
        default:
          return status;
      }
    } else {
      return status.capitalize;
    }
  }

  static String formatReservationStatus(
    String? status, {
    String locale = 'tr',
  }) {
    if (status == null || status.isEmpty) return '';

    if (locale == 'tr') {
      switch (status.toLowerCase()) {
        case 'confirmed':
          return 'Onaylandı';
        case 'cancelled':
          return 'İptal Edildi';
        case 'waitlisted':
          return 'Bekleme Listesinde';
        case 'no_show':
          return 'Gelmedi';
        case 'attended':
          return 'Katıldı';
        default:
          return status;
      }
    } else {
      return status.capitalize;
    }
  }

  // Class difficulty formatting
  static String formatDifficulty(String? difficulty, {String locale = 'tr'}) {
    if (difficulty == null || difficulty.isEmpty) return '';

    if (locale == 'tr') {
      switch (difficulty.toLowerCase()) {
        case 'beginner':
          return 'Başlangıç';
        case 'intermediate':
          return 'Orta';
        case 'advanced':
          return 'İleri';
        default:
          return difficulty;
      }
    } else {
      return difficulty.capitalize;
    }
  }

  // Address formatting
  static String formatAddress(Map<String, String?> address) {
    final parts = <String>[];

    if (address['street'] != null && address['street']!.isNotEmpty) {
      parts.add(address['street']!);
    }
    if (address['district'] != null && address['district']!.isNotEmpty) {
      parts.add(address['district']!);
    }
    if (address['city'] != null && address['city']!.isNotEmpty) {
      parts.add(address['city']!);
    }
    if (address['postalCode'] != null && address['postalCode']!.isNotEmpty) {
      parts.add(address['postalCode']!);
    }

    return parts.join(', ');
  }

  // Distance formatting
  static String formatDistance(double? meters, {String locale = 'tr'}) {
    if (meters == null) return '';

    if (meters < 1000) {
      if (locale == 'tr') {
        return '${meters.round()} m';
      } else {
        return '${meters.round()} m';
      }
    } else {
      final km = meters / 1000;
      if (locale == 'tr') {
        return '${km.toStringAsFixed(1)} km';
      } else {
        return '${km.toStringAsFixed(1)} km';
      }
    }
  }

  // List formatting
  static String formatList(
    List<String>? items, {
    String locale = 'tr',
    int maxItems = 3,
  }) {
    if (items == null || items.isEmpty) return '';

    if (items.length <= maxItems) {
      if (locale == 'tr') {
        return items.join(', ');
      } else {
        if (items.length == 1) return items.first;
        if (items.length == 2) return '${items.first} and ${items.last}';
        return '${items.take(items.length - 1).join(', ')}, and ${items.last}';
      }
    } else {
      final visibleItems = items.take(maxItems).toList();
      final remaining = items.length - maxItems;

      if (locale == 'tr') {
        return '${visibleItems.join(', ')} ve $remaining tane daha';
      } else {
        return '${visibleItems.join(', ')} and $remaining more';
      }
    }
  }

  // Credit card formatting
  static String formatCreditCard(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) return '';
    return cardNumber.formatCreditCard;
  }

  static String formatCreditCardMasked(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) return '';
    return cardNumber.maskCreditCard();
  }

  // IBAN formatting
  static String formatIBAN(String? iban) {
    if (iban == null || iban.isEmpty) return '';
    return iban.formatIBAN();
  }

  // Name formatting
  static String formatFullName(String? firstName, String? lastName) {
    final parts = <String>[];

    if (firstName != null && firstName.isNotEmpty) {
      parts.add(firstName.trim());
    }
    if (lastName != null && lastName.isNotEmpty) {
      parts.add(lastName.trim());
    }

    return parts.join(' ');
  }

  static String formatInitials(String? firstName, String? lastName) {
    final name = formatFullName(firstName, lastName);
    return name.initials;
  }

  // Class type formatting
  static String formatClassType(String? type, {String locale = 'tr'}) {
    if (type == null || type.isEmpty) return '';

    if (locale == 'tr') {
      switch (type.toLowerCase()) {
        case 'pilates_mat':
          return 'Mat Pilates';
        case 'pilates_reformer':
          return 'Reformer Pilates';
        case 'hatha_yoga':
          return 'Hatha Yoga';
        case 'vinyasa_yoga':
          return 'Vinyasa Yoga';
        case 'meditation':
          return 'Meditasyon';
        default:
          return type.replaceAll('_', ' ').capitalizeWords;
      }
    } else {
      return type.replaceAll('_', ' ').capitalizeWords;
    }
  }

  // Studio type formatting
  static String formatStudioType(String? type, {String locale = 'tr'}) {
    if (type == null || type.isEmpty) return '';

    if (locale == 'tr') {
      switch (type.toLowerCase()) {
        case 'pilates_studio':
          return 'Pilates Stüdyosu';
        case 'yoga_studio':
          return 'Yoga Stüdyosu';
        case 'meditation_room':
          return 'Meditasyon Odası';
        case 'multi_purpose':
          return 'Çok Amaçlı';
        case 'outdoor':
          return 'Açık Hava';
        default:
          return type.replaceAll('_', ' ').capitalizeWords;
      }
    } else {
      return type.replaceAll('_', ' ').capitalizeWords;
    }
  }

  // Gender formatting
  static String formatGender(String? gender, {String locale = 'tr'}) {
    if (gender == null || gender.isEmpty) return '';

    if (locale == 'tr') {
      switch (gender.toLowerCase()) {
        case 'male':
        case 'm':
          return 'Erkek';
        case 'female':
        case 'f':
          return 'Kadın';
        default:
          return gender;
      }
    } else {
      switch (gender.toLowerCase()) {
        case 'male':
        case 'm':
          return 'Male';
        case 'female':
        case 'f':
          return 'Female';
        default:
          return gender.capitalize;
      }
    }
  }

  // Text truncation
  static String truncateText(
    String? text,
    int maxLength, {
    String suffix = '...',
  }) {
    if (text == null || text.isEmpty) return '';
    return text.truncate(maxLength, suffix: suffix);
  }

  static String truncateWords(
    String? text,
    int maxWords, {
    String suffix = '...',
  }) {
    if (text == null || text.isEmpty) return '';
    return text.truncateWords(maxWords, suffix: suffix);
  }

  // URL formatting
  static String formatUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    return url.addHttpsIfNeeded();
  }

  static String formatDomain(String? url) {
    if (url == null || url.isEmpty) return '';
    return url.extractDomain();
  }

  // Search highlighting (for search results)
  static String highlightSearchTerm(String text, String searchTerm) {
    if (searchTerm.isEmpty) return text;

    final regex = RegExp(RegExp.escape(searchTerm), caseSensitive: false);
    return text.replaceAllMapped(regex, (match) => '**${match.group(0)}**');
  }

  // Version formatting
  static String formatVersion(String? version) {
    if (version == null || version.isEmpty) return '';
    return 'v$version';
  }
}
