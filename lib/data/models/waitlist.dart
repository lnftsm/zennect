enum WaitlistStatus { waiting, notified, confirmed, expired, cancelled }

class Waitlist {
  final String id;
  final String userId;
  final String scheduleId;
  final int position;
  final DateTime joinedAt;
  final WaitlistStatus status;
  final DateTime? notifiedAt;
  final DateTime? responseDeadline;
  final DateTime createdAt;
  final DateTime updatedAt;

  Waitlist({
    required this.id,
    required this.userId,
    required this.scheduleId,
    required this.position,
    required this.joinedAt,
    this.status = WaitlistStatus.waiting,
    this.notifiedAt,
    this.responseDeadline,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Waitlist.fromJson(Map<String, dynamic> json) {
    return Waitlist(
      id: json['id'],
      userId: json['userId'],
      scheduleId: json['scheduleId'],
      position: json['position'],
      joinedAt: DateTime.parse(json['joinedAt']),
      status: WaitlistStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      notifiedAt: json['notifiedAt'] != null
          ? DateTime.parse(json['notifiedAt'])
          : null,
      responseDeadline: json['responseDeadline'] != null
          ? DateTime.parse(json['responseDeadline'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'scheduleId': scheduleId,
      'position': position,
      'joinedAt': joinedAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'notifiedAt': notifiedAt?.toIso8601String(),
      'responseDeadline': responseDeadline?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isWaiting => status == WaitlistStatus.waiting;
  bool get isNotified => status == WaitlistStatus.notified;
  bool get isConfirmed => status == WaitlistStatus.confirmed;
  bool get isExpired => status == WaitlistStatus.expired;
  bool get isCancelled => status == WaitlistStatus.cancelled;

  Duration? get timeWaiting => DateTime.now().difference(joinedAt);

  Duration? get remainingResponseTime {
    if (responseDeadline == null) return null;
    final remaining = responseDeadline!.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  Waitlist copyWith({
    String? id,
    String? userId,
    String? scheduleId,
    int? position,
    DateTime? joinedAt,
    WaitlistStatus? status,
    DateTime? notifiedAt,
    DateTime? responseDeadline,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Waitlist(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      scheduleId: scheduleId ?? this.scheduleId,
      position: position ?? this.position,
      joinedAt: joinedAt ?? this.joinedAt,
      status: status ?? this.status,
      notifiedAt: notifiedAt ?? this.notifiedAt,
      responseDeadline: responseDeadline ?? this.responseDeadline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
