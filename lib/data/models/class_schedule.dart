enum ClassScheduleStatus { scheduled, cancelled, completed, inProgress }

class ClassSchedule {
  final String id;
  final String classId;
  final String instructorId;
  final String studioId;
  final DateTime startTime;
  final DateTime endTime;
  final int maxCapacity;
  final int currentEnrollment;
  final ClassScheduleStatus status;
  final bool allowWaitlist;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClassSchedule({
    required this.id,
    required this.classId,
    required this.instructorId,
    required this.studioId,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    this.currentEnrollment = 0,
    this.status = ClassScheduleStatus.scheduled,
    this.allowWaitlist = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      id: json['id'],
      classId: json['classId'],
      instructorId: json['instructorId'],
      studioId: json['studioId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      maxCapacity: json['maxCapacity'],
      currentEnrollment: json['currentEnrollment'] ?? 0,
      status: ClassScheduleStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      allowWaitlist: json['allowWaitlist'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'instructorId': instructorId,
      'studioId': studioId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'maxCapacity': maxCapacity,
      'currentEnrollment': currentEnrollment,
      'status': status.toString().split('.').last,
      'allowWaitlist': allowWaitlist,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isFull => currentEnrollment >= maxCapacity;
  bool get isAvailable => status == ClassScheduleStatus.scheduled && !isFull;
  int get availableSpots => maxCapacity - currentEnrollment;
  Duration get duration => endTime.difference(startTime);

  ClassSchedule copyWith({
    String? id,
    String? classId,
    String? instructorId,
    String? studioId,
    DateTime? startTime,
    DateTime? endTime,
    int? maxCapacity,
    int? currentEnrollment,
    ClassScheduleStatus? status,
    bool? allowWaitlist,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClassSchedule(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      instructorId: instructorId ?? this.instructorId,
      studioId: studioId ?? this.studioId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      currentEnrollment: currentEnrollment ?? this.currentEnrollment,
      status: status ?? this.status,
      allowWaitlist: allowWaitlist ?? this.allowWaitlist,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
