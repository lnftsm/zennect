import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  // Turkish Date Formats
  String get turkishDate => DateFormat('dd.MM.yyyy', 'tr_TR').format(this);
  String get turkishTime => DateFormat('HH:mm', 'tr_TR').format(this);
  String get turkishDateTime =>
      DateFormat('dd.MM.yyyy HH:mm', 'tr_TR').format(this);
  String get turkishDateTimeLong =>
      DateFormat('dd MMMM yyyy HH:mm', 'tr_TR').format(this);
  String get turkishDateLong =>
      DateFormat('dd MMMM yyyy', 'tr_TR').format(this);
  String get turkishDayName => DateFormat('EEEE', 'tr_TR').format(this);
  String get turkishMonthName => DateFormat('MMMM', 'tr_TR').format(this);
  String get turkishShortDate => DateFormat('dd/MM/yy', 'tr_TR').format(this);

  // English Date Formats
  String get englishDate => DateFormat('dd/MM/yyyy', 'en_US').format(this);
  String get englishTime => DateFormat('HH:mm', 'en_US').format(this);
  String get englishDateTime =>
      DateFormat('dd/MM/yyyy HH:mm', 'en_US').format(this);
  String get englishDateTimeLong =>
      DateFormat('dd MMMM yyyy HH:mm', 'en_US').format(this);
  String get englishDateLong =>
      DateFormat('dd MMMM yyyy', 'en_US').format(this);
  String get englishDayName => DateFormat('EEEE', 'en_US').format(this);
  String get englishMonthName => DateFormat('MMMM', 'en_US').format(this);
  String get englishShortDate => DateFormat('dd/MM/yy', 'en_US').format(this);

  // API Formats
  String get apiFormat => DateFormat('yyyy-MM-dd').format(this);
  String get apiDateTimeFormat =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);
  String get isoFormat => toIso8601String();

  // Time Formats
  String get time24 => DateFormat('HH:mm').format(this);
  String get time12 => DateFormat('hh:mm a').format(this);
  String get timeWithSeconds => DateFormat('HH:mm:ss').format(this);

  // Day Operations
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
  DateTime get startOfWeek {
    final daysFromMonday = weekday - 1;
    return subtract(Duration(days: daysFromMonday)).startOfDay;
  }

  DateTime get endOfWeek => startOfWeek.add(const Duration(days: 6)).endOfDay;
  DateTime get startOfMonth => DateTime(year, month, 1);
  DateTime get endOfMonth => DateTime(year, month + 1, 0).endOfDay;
  DateTime get startOfYear => DateTime(year, 1, 1);
  DateTime get endOfYear => DateTime(year, 12, 31).endOfDay;

  // Week Operations
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;
  bool get isWeekday => !isWeekend;
  bool get isMonday => weekday == DateTime.monday;
  bool get isTuesday => weekday == DateTime.tuesday;
  bool get isWednesday => weekday == DateTime.wednesday;
  bool get isThursday => weekday == DateTime.thursday;
  bool get isFriday => weekday == DateTime.friday;
  bool get isSaturday => weekday == DateTime.saturday;
  bool get isSunday => weekday == DateTime.sunday;

  // Time Comparisons
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.startOfWeek;
    final endOfWeek = now.endOfWeek;
    return isAfter(startOfWeek) && isBefore(endOfWeek) ||
        isAtSameMomentAs(startOfWeek) ||
        isAtSameMomentAs(endOfWeek);
  }

  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  bool get isThisYear {
    final now = DateTime.now();
    return year == now.year;
  }

  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());

  // Age Calculation
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  // Duration Helpers
  Duration get timeUntilNow => DateTime.now().difference(this);
  Duration get timeSinceNow => difference(DateTime.now());

  // Time Ago Formatting (Turkish)
  String get turkishTimeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'yıl' : 'yıl'} önce';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'ay' : 'ay'} önce';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'gün' : 'gün'} önce';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'saat' : 'saat'} önce';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'dakika' : 'dakika'} önce';
    } else {
      return 'Şimdi';
    }
  }

  // Time Ago Formatting (English)
  String get englishTimeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  // Remaining Time (Turkish)
  String get turkishTimeRemaining {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.isNegative) return 'Geçti';

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'yıl' : 'yıl'} kaldı';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'ay' : 'ay'} kaldı';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'gün' : 'gün'} kaldı';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'saat' : 'saat'} kaldı';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'dakika' : 'dakika'} kaldı';
    } else {
      return 'Şimdi';
    }
  }

  // Remaining Time (English)
  String get englishTimeRemaining {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.isNegative) return 'Expired';

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} remaining';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} remaining';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} remaining';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} remaining';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} remaining';
    } else {
      return 'Now';
    }
  }

  // Smart Date Display
  String smartFormat({String locale = 'tr'}) {
    if (isToday) {
      return locale == 'tr' ? 'Bugün $time24' : 'Today $time24';
    } else if (isYesterday) {
      return locale == 'tr' ? 'Dün $time24' : 'Yesterday $time24';
    } else if (isTomorrow) {
      return locale == 'tr' ? 'Yarın $time24' : 'Tomorrow $time24';
    } else if (isThisWeek) {
      return locale == 'tr'
          ? '$turkishDayName $time24'
          : '$englishDayName $time24';
    } else if (isThisYear) {
      return locale == 'tr'
          ? DateFormat('dd MMM HH:mm', 'tr_TR').format(this)
          : DateFormat('dd MMM HH:mm', 'en_US').format(this);
    } else {
      return locale == 'tr' ? turkishDateTime : englishDateTime;
    }
  }

  // Add/Subtract Operations
  DateTime addYears(int years) =>
      DateTime(year + years, month, day, hour, minute, second, millisecond);
  DateTime subtractYears(int years) => addYears(-years);
  DateTime addMonths(int months) {
    final newMonth = month + months;
    final newYear = year + (newMonth - 1) ~/ 12;
    final finalMonth = ((newMonth - 1) % 12) + 1;
    return DateTime(
      newYear,
      finalMonth,
      day,
      hour,
      minute,
      second,
      millisecond,
    );
  }

  DateTime subtractMonths(int months) => addMonths(-months);
  DateTime addWeeks(int weeks) => add(Duration(days: weeks * 7));
  DateTime subtractWeeks(int weeks) => addWeeks(-weeks);

  // Business Days
  bool get isBusinessDay =>
      weekday >= DateTime.monday && weekday <= DateTime.friday;

  DateTime get nextBusinessDay {
    DateTime next = add(const Duration(days: 1));
    while (!next.isBusinessDay) {
      next = next.add(const Duration(days: 1));
    }
    return next;
  }

  DateTime get previousBusinessDay {
    DateTime prev = subtract(const Duration(days: 1));
    while (!prev.isBusinessDay) {
      prev = prev.subtract(const Duration(days: 1));
    }
    return prev;
  }

  // Calendar Helpers
  int get daysInMonth {
    final nextMonth = month == 12
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1)).day;
  }

  bool get isLeapYear {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  int get weekOfYear {
    final startOfYear = DateTime(year, 1, 1);
    final daysSinceStartOfYear = difference(startOfYear).inDays;
    return ((daysSinceStartOfYear + startOfYear.weekday - 1) / 7).ceil();
  }

  // Class/Membership Related
  bool isWithinClassBookingWindow({int maxDaysAhead = 7}) {
    final now = DateTime.now();
    final maxBookingDate = now.add(Duration(days: maxDaysAhead));
    return isAfter(now) && isBefore(maxBookingDate);
  }

  bool canCancelClass({int minHoursBeforeClass = 2}) {
    final now = DateTime.now();
    final cancelDeadline = subtract(Duration(hours: minHoursBeforeClass));
    return now.isBefore(cancelDeadline);
  }

  bool get isMembershipExpiringSoon {
    final now = DateTime.now();
    final warningDate = now.add(const Duration(days: 7));
    return isAfter(now) && isBefore(warningDate);
  }

  // Time Slots
  List<DateTime> generateTimeSlots({
    required Duration interval,
    required DateTime endTime,
  }) {
    final slots = <DateTime>[];
    DateTime current = this;

    while (current.isBefore(endTime)) {
      slots.add(current);
      current = current.add(interval);
    }

    return slots;
  }

  // Working Hours Check
  bool isWithinWorkingHours({int startHour = 8, int endHour = 22}) {
    return hour >= startHour && hour < endHour;
  }

  // Timezone Helpers
  DateTime toUtc() => toUtc();
  DateTime toLocal() => toLocal();

  // Comparison Helpers
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameWeek(DateTime other) {
    final thisWeekStart = startOfWeek;
    final otherWeekStart = other.startOfWeek;
    return thisWeekStart.isSameDay(otherWeekStart);
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  bool isSameYear(DateTime other) {
    return year == other.year;
  }

  // Custom Formatting
  String format(String pattern, {String locale = 'tr_TR'}) {
    return DateFormat(pattern, locale).format(this);
  }

  // Firebase Timestamp Compatible
  Map<String, dynamic> get firestoreTimestamp {
    return {
      'seconds': millisecondsSinceEpoch ~/ 1000,
      'nanoseconds': (millisecondsSinceEpoch % 1000) * 1000000,
    };
  }

  // JSON Serialization
  String get jsonString => toIso8601String();

  // Reminder Helpers
  DateTime getReminderTime(int minutesBefore) {
    return subtract(Duration(minutes: minutesBefore));
  }

  List<DateTime> getMultipleReminders(List<int> minutesBeforeList) {
    return minutesBeforeList
        .map((minutes) => getReminderTime(minutes))
        .where((reminderTime) => reminderTime.isAfter(DateTime.now()))
        .toList();
  }
}

// Nullable DateTime Extensions
extension NullableDateTimeExtensions on DateTime? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;

  String get turkishDateOrEmpty => this?.turkishDate ?? '';
  String get turkishTimeOrEmpty => this?.turkishTime ?? '';
  String get englishDateOrEmpty => this?.englishDate ?? '';
  String get englishTimeOrEmpty => this?.englishTime ?? '';

  bool get isTodayOrNull => this?.isToday ?? false;
  bool get isPastOrNull => this?.isPast ?? false;
  bool get isFutureOrNull => this?.isFuture ?? false;

  String turkishTimeAgoOrDefault(String defaultValue) =>
      this?.turkishTimeAgo ?? defaultValue;

  String englishTimeAgoOrDefault(String defaultValue) =>
      this?.englishTimeAgo ?? defaultValue;
}

// Duration Extensions
extension DurationExtensions on Duration {
  String get turkishDuration {
    if (inDays > 0) {
      return '$inDays ${inDays == 1 ? 'gün' : 'gün'}';
    } else if (inHours > 0) {
      return '$inHours ${inHours == 1 ? 'saat' : 'saat'}';
    } else if (inMinutes > 0) {
      return '$inMinutes ${inMinutes == 1 ? 'dakika' : 'dakika'}';
    } else {
      return '$inSeconds ${inSeconds == 1 ? 'saniye' : 'saniye'}';
    }
  }

  String get englishDuration {
    if (inDays > 0) {
      return '$inDays ${inDays == 1 ? 'day' : 'days'}';
    } else if (inHours > 0) {
      return '$inHours ${inHours == 1 ? 'hour' : 'hours'}';
    } else if (inMinutes > 0) {
      return '$inMinutes ${inMinutes == 1 ? 'minute' : 'minutes'}';
    } else {
      return '$inSeconds ${inSeconds == 1 ? 'second' : 'seconds'}';
    }
  }

  String get hoursMinutesFormat {
    final hours = inHours;
    final minutes = inMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  String get minutesSecondsFormat {
    final minutes = inMinutes;
    final seconds = inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
