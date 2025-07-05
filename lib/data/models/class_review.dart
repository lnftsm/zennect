class ClassReview {
  final String id;
  final String userId;
  final String scheduleId;
  final String instructorId;
  final int classRating; // 1-5
  final int instructorRating; // 1-5
  final String? comment;
  final DateTime createdAt;

  ClassReview({
    required this.id,
    required this.userId,
    required this.scheduleId,
    required this.instructorId,
    required this.classRating,
    required this.instructorRating,
    this.comment,
    required this.createdAt,
  });

  factory ClassReview.fromJson(Map<String, dynamic> json) {
    return ClassReview(
      id: json['id'],
      userId: json['userId'],
      scheduleId: json['scheduleId'],
      instructorId: json['instructorId'],
      classRating: json['classRating'],
      instructorRating: json['instructorRating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'scheduleId': scheduleId,
      'instructorId': instructorId,
      'classRating': classRating,
      'instructorRating': instructorRating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  double get averageRating => (classRating + instructorRating) / 2;

  ClassReview copyWith({
    String? id,
    String? userId,
    String? scheduleId,
    String? instructorId,
    int? classRating,
    int? instructorRating,
    String? comment,
    DateTime? createdAt,
  }) {
    return ClassReview(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      scheduleId: scheduleId ?? this.scheduleId,
      instructorId: instructorId ?? this.instructorId,
      classRating: classRating ?? this.classRating,
      instructorRating: instructorRating ?? this.instructorRating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
