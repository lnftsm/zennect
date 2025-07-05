import 'package:logger/logger.dart';
import 'dart:io';

class LogService {
  static Logger? _logger;
  static bool _isInitialized = false;

  // Private constructor
  LogService._();

  // Initialize the logger
  static void initialize({
    Level level = Level.debug,
    bool enableFileOutput = true,
    String? logDirectory,
  }) {
    if (_isInitialized) return;

    _logger = Logger(
      filter: _LogFilter(level),
      printer: _LogPrinter(),
      output: enableFileOutput
          ? MultiOutput([
              ConsoleOutput(),
              if (enableFileOutput) FileOutput(logDirectory: logDirectory),
            ])
          : ConsoleOutput(),
      level: level,
    );

    _isInitialized = true;
  }

  // Ensure logger is initialized
  static Logger get _instance {
    if (!_isInitialized) {
      initialize();
    }
    return _logger!;
  }

  // Debug level logging
  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  // Info level logging
  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  // Warning level logging
  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  // Error level logging
  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  // Fatal level logging
  static void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.f(message, time: time, error: error, stackTrace: stackTrace);
  }

  // Trace level logging
  static void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.t(message, time: time, error: error, stackTrace: stackTrace);
  }

  // API request logging
  static void apiRequest(
    String method,
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
    int? statusCode,
  }) {
    final message =
        '''
🌐 API REQUEST
Method: $method
URL: $url
${headers != null ? 'Headers: $headers' : ''}
${body != null ? 'Body: $body' : ''}
${statusCode != null ? 'Status: $statusCode' : ''}
    ''';
    i(message);
  }

  // API response logging
  static void apiResponse(
    String method,
    String url,
    int statusCode,
    dynamic response, {
    Duration? duration,
  }) {
    final message =
        '''
✅ API RESPONSE
Method: $method
URL: $url
Status: $statusCode
${duration != null ? 'Duration: ${duration.inMilliseconds}ms' : ''}
Response: $response
    ''';
    i(message);
  }

  // API error logging
  static void apiError(
    String method,
    String url,
    dynamic error, {
    int? statusCode,
    Duration? duration,
    StackTrace? stackTrace,
  }) {
    final message =
        '''
❌ API ERROR
Method: $method
URL: $url
${statusCode != null ? 'Status: $statusCode' : ''}
${duration != null ? 'Duration: ${duration.inMilliseconds}ms' : ''}
Error: $error
    ''';
    e(message, error: error, stackTrace: stackTrace);
  }

  // Database operation logging
  static void database(
    String operation,
    String collection, {
    Map<String, dynamic>? data,
    String? documentId,
  }) {
    final message =
        '''
🗄️ DATABASE OPERATION
Operation: $operation
Collection: $collection
${documentId != null ? 'Document ID: $documentId' : ''}
${data != null ? 'Data: $data' : ''}
    ''';
    d(message);
  }

  // Authentication logging
  static void auth(String action, {String? userId, String? email}) {
    final message =
        '''
🔐 AUTH ACTION
Action: $action
${userId != null ? 'User ID: $userId' : ''}
${email != null ? 'Email: $email' : ''}
    ''';
    i(message);
  }

  // Navigation logging
  static void navigation(
    String from,
    String to, {
    Map<String, dynamic>? arguments,
  }) {
    final message =
        '''
🧭 NAVIGATION
From: $from
To: $to
${arguments != null ? 'Arguments: $arguments' : ''}
    ''';
    d(message);
  }

  // Business logic logging
  static void business(String action, {Map<String, dynamic>? data}) {
    final message =
        '''
💼 BUSINESS ACTION
Action: $action
${data != null ? 'Data: $data' : ''}
    ''';
    d(message);
  }

  // Performance logging
  static void performance(
    String operation,
    Duration duration, {
    Map<String, dynamic>? metadata,
  }) {
    final message =
        '''
⚡ PERFORMANCE
Operation: $operation
Duration: ${duration.inMilliseconds}ms
${metadata != null ? 'Metadata: $metadata' : ''}
    ''';
    i(message);
  }

  // User action logging
  static void userAction(
    String action, {
    String? userId,
    Map<String, dynamic>? data,
  }) {
    final message =
        '''
👤 USER ACTION
Action: $action
${userId != null ? 'User ID: $userId' : ''}
${data != null ? 'Data: $data' : ''}
    ''';
    d(message);
  }

  // Firebase logging
  static void firebase(
    String action, {
    String? collection,
    String? documentId,
    Map<String, dynamic>? data,
  }) {
    final message =
        '''
🔥 FIREBASE
Action: $action
${collection != null ? 'Collection: $collection' : ''}
${documentId != null ? 'Document ID: $documentId' : ''}
${data != null ? 'Data: $data' : ''}
    ''';
    d(message);
  }

  // Payment logging
  static void payment(
    String action, {
    String? transactionId,
    double? amount,
    String? currency,
    String? status,
  }) {
    final message =
        '''
💳 PAYMENT
Action: $action
${transactionId != null ? 'Transaction ID: $transactionId' : ''}
${amount != null ? 'Amount: $amount' : ''}
${currency != null ? 'Currency: $currency' : ''}
${status != null ? 'Status: $status' : ''}
    ''';
    i(message);
  }

  // Notification logging
  static void notification(
    String action, {
    String? title,
    String? body,
    String? userId,
  }) {
    final message =
        '''
🔔 NOTIFICATION
Action: $action
${title != null ? 'Title: $title' : ''}
${body != null ? 'Body: $body' : ''}
${userId != null ? 'User ID: $userId' : ''}
    ''';
    d(message);
  }

  // Close logger
  static void close() {
    _logger?.close();
    _isInitialized = false;
  }
}

// Custom log filter
class _LogFilter extends LogFilter {
  final Level _level;

  _LogFilter(this._level);

  @override
  bool shouldLog(LogEvent event) {
    return event.level.index >= _level.index;
  }
}

// Custom log printer
class _LogPrinter extends LogPrinter {
  static final _deviceStackTraceRegex = RegExp(
    r'#[0-9]+[\s]+(.+) \(([^\s]+)\)',
  );
  static final _webStackTraceRegex = RegExp(
    r'^((packages|dart-sdk)/)?(.*/)?(.*\.dart):([0-9]+):([0-9]+)',
  );
  static final _browserStackTraceRegex = RegExp(
    r'^    at .*?:(.*):([0-9]+):([0-9]+)$',
  );

  @override
  List<String> log(LogEvent event) {
    final messageStr = _stringifyMessage(event.message);
    final errorStr = event.error != null ? '  ERROR: ${event.error}' : '';
    final timeStr = _getTime(event.time);
    final levelStr = _getLevelEmoji(event.level);
    final locationStr = _getLocation(event.stackTrace);

    final output = <String>[];

    // Add header
    output.add('$timeStr $levelStr $locationStr');

    // Add message
    if (messageStr.isNotEmpty) {
      for (final line in messageStr.split('\n')) {
        output.add('  $line');
      }
    }

    // Add error
    if (errorStr.isNotEmpty) {
      output.add(errorStr);
    }

    // Add stack trace in debug mode
    if (event.stackTrace != null && event.level.index >= Level.error.index) {
      final stackTraceStr = _getStackTrace(event.stackTrace!);
      if (stackTraceStr.isNotEmpty) {
        output.add('  STACK TRACE:');
        for (final line in stackTraceStr.split('\n')) {
          if (line.trim().isNotEmpty) {
            output.add('    $line');
          }
        }
      }
    }

    return output;
  }

  String _stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      try {
        return message.toString();
      } catch (e) {
        return message.toString();
      }
    }
    return message.toString();
  }

  String _getTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:'
        '${time.second.toString().padLeft(2, '0')}.'
        '${time.millisecond.toString().padLeft(3, '0')}';
  }

  String _getLevelEmoji(Level level) {
    switch (level) {
      case Level.trace:
        return '🔍 TRACE';
      case Level.debug:
        return '🐛 DEBUG';
      case Level.info:
        return 'ℹ️ INFO ';
      case Level.warning:
        return '⚠️ WARN ';
      case Level.error:
        return '❌ ERROR';
      case Level.fatal:
        return '💀 FATAL';
      default:
        return level.name.toUpperCase();
    }
  }

  String _getLocation(StackTrace? stackTrace) {
    if (stackTrace == null) return '';

    final lines = stackTrace.toString().split('\n');

    for (final line in lines) {
      final match =
          _deviceStackTraceRegex.firstMatch(line) ??
          _webStackTraceRegex.firstMatch(line) ??
          _browserStackTraceRegex.firstMatch(line);

      if (match != null) {
        if (match.groupCount >= 2) {
          final fileName = match.group(1) ?? '';
          final lineNumber = match.group(2) ?? '';

          if (fileName.isNotEmpty &&
              !fileName.contains('logger') &&
              !fileName.contains('log_service')) {
            return '[$fileName:$lineNumber]';
          }
        }
      }
    }

    return '[Unknown]';
  }

  String _getStackTrace(StackTrace stackTrace) {
    final lines = stackTrace.toString().split('\n');
    final filteredLines = <String>[];

    for (final line in lines) {
      if (!line.contains('logger') &&
          !line.contains('log_service') &&
          line.trim().isNotEmpty) {
        filteredLines.add(line);
      }

      // Only show first 10 lines to avoid clutter
      if (filteredLines.length >= 10) break;
    }

    return filteredLines.join('\n');
  }
}

// File output for logging
class FileOutput extends LogOutput {
  final String? logDirectory;
  late final File _file;

  FileOutput({this.logDirectory}) {
    final directory = logDirectory ?? Directory.current.path;
    final fileName = 'zennect_${DateTime.now().toString().split(' ')[0]}.log';
    _file = File('$directory/$fileName');
  }

  @override
  void output(OutputEvent event) {
    try {
      final timestamp = DateTime.now().toIso8601String();
      final logLine = '[$timestamp] ${event.lines.join('\n')}\n';
      _file.writeAsStringSync(logLine, mode: FileMode.append);
    } catch (e) {
      // Ignore file write errors in production
    }
  }
}

// Multi output for both console and file
class MultiOutput extends LogOutput {
  final List<LogOutput> outputs;

  MultiOutput(this.outputs);

  @override
  void output(OutputEvent event) {
    for (final output in outputs) {
      try {
        output.output(event);
      } catch (e) {
        // Ignore individual output errors
      }
    }
  }
}
