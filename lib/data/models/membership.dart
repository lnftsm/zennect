enum MembershipStatus { active, expired, suspended, cancelled }

class Membership {
  final String id;
  final String userId;
  final String packageId;
  final DateTime startDate;
  final DateTime endDate;
  final int? remainingClasses;
  final MembershipStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Membership({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.startDate,
    required this.endDate,
    this.remainingClasses,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'],
      userId: json['userId'],
      packageId: json['packageId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      remainingClasses: json['remainingClasses'],
      status: MembershipStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'packageId': packageId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'remainingClasses': remainingClasses,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isActive =>
      status == MembershipStatus.active && DateTime.now().isBefore(endDate);
  bool get isExpiring =>
      isActive && endDate.difference(DateTime.now()).inDays <= 7;
  bool get hasLowClassCount =>
      remainingClasses != null && remainingClasses! <= 2;

  Duration get remainingDuration => endDate.difference(DateTime.now());
  int get remainingDays => remainingDuration.inDays;

  Membership copyWith({
    String? id,
    String? userId,
    String? packageId,
    DateTime? startDate,
    DateTime? endDate,
    int? remainingClasses,
    MembershipStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Membership(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      packageId: packageId ?? this.packageId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      remainingClasses: remainingClasses ?? this.remainingClasses,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
