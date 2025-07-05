enum ReservationStatus { confirmed, cancelled, waitlisted, noShow }

class Reservation {
  final String id;
  final String userId;
  final String scheduleId;
  final ReservationStatus status;
  final DateTime reservedAt;
  final DateTime? cancelledAt;
  final String? cancellationReason;
  final bool attended;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reservation({
    required this.id,
    required this.userId,
    required this.scheduleId,
    this.status = ReservationStatus.confirmed,
    required this.reservedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.attended = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      userId: json['userId'],
      scheduleId: json['scheduleId'],
      status: ReservationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      reservedAt: DateTime.parse(json['reservedAt']),
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'])
          : null,
      cancellationReason: json['cancellationReason'],
      attended: json['attended'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'scheduleId': scheduleId,
      'status': status.toString().split('.').last,
      'reservedAt': reservedAt.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
      'attended': attended,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isActive => status == ReservationStatus.confirmed;
  bool get isCancelled => status == ReservationStatus.cancelled;
  bool get isWaitlisted => status == ReservationStatus.waitlisted;
  bool get isNoShow => status == ReservationStatus.noShow;

  Reservation copyWith({
    String? id,
    String? userId,
    String? scheduleId,
    ReservationStatus? status,
    DateTime? reservedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    bool? attended,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Reservation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      scheduleId: scheduleId ?? this.scheduleId,
      status: status ?? this.status,
      reservedAt: reservedAt ?? this.reservedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      attended: attended ?? this.attended,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
