class Announcement {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final bool isActive;
  final DateTime? scheduledAt;
  final List<String> targetAudience; // membershipTypes or 'all'
  final DateTime createdAt;
  final DateTime updatedAt;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.isActive = true,
    this.scheduledAt,
    this.targetAudience = const ['all'],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      isActive: json['isActive'] ?? true,
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'])
          : null,
      targetAudience: List<String>.from(json['targetAudience'] ?? ['all']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'scheduledAt': scheduledAt?.toIso8601String(),
      'targetAudience': targetAudience,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isScheduled => scheduledAt != null;
  bool get isPublished =>
      isActive && (scheduledAt == null || DateTime.now().isAfter(scheduledAt!));
  bool get isForAll => targetAudience.contains('all');
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  Announcement copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    bool? isActive,
    DateTime? scheduledAt,
    List<String>? targetAudience,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Announcement(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      targetAudience: targetAudience ?? this.targetAudience,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
